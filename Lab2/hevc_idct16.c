#include <immintrin.h>
#include <malloc.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <time.h>
#include <math.h>

#define IDCT_SIZE         16
#define ITERATIONS        1000000
#define MAX_NEG_CROP      1024

#define MIN(X,Y) ((X) < (Y) ? (X) : (Y))
#define MAX(X,Y) ((X) > (Y) ? (X) : (Y))

static const short g_aiT16[16][16]  __attribute__((aligned(16))) =
{
  { 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64},
  { 90, 87, 80, 70, 57, 43, 25,  9, -9,-25,-43,-57,-70,-80,-87,-90},
  { 89, 75, 50, 18,-18,-50,-75,-89,-89,-75,-50,-18, 18, 50, 75, 89},
  { 87, 57,  9,-43,-80,-90,-70,-25, 25, 70, 90, 80, 43, -9,-57,-87},
  { 83, 36,-36,-83,-83,-36, 36, 83, 83, 36,-36,-83,-83,-36, 36, 83},
  { 80,  9,-70,-87,-25, 57, 90, 43,-43,-90,-57, 25, 87, 70, -9,-80},
  { 75,-18,-89,-50, 50, 89, 18,-75,-75, 18, 89, 50,-50,-89,-18, 75},
  { 70,-43,-87,  9, 90, 25,-80,-57, 57, 80,-25,-90, -9, 87, 43,-70},
  { 64,-64,-64, 64, 64,-64,-64, 64, 64,-64,-64, 64, 64,-64,-64, 64},
  { 57,-80,-25, 90, -9,-87, 43, 70,-70,-43, 87,  9,-90, 25, 80,-57},
  { 50,-89, 18, 75,-75,-18, 89,-50,-50, 89,-18,-75, 75, 18,-89, 50},
  { 43,-90, 57, 25,-87, 70,  9,-80, 80, -9,-70, 87,-25,-57, 90,-43},
  { 36,-83, 83,-36,-36, 83,-83, 36, 36,-83, 83,-36,-36, 83,-83, 36},
  { 25,-70, 90,-80, 43,  9,-57, 87,-87, 57, -9,-43, 80,-90, 70,-25},
  { 18,-50, 75,-89, 89,-75, 50,-18,-18, 50,-75, 89,-89, 75,-50, 18},
  {  9,-25, 43,-57, 70,-80, 87,-90, 90,-87, 80,-70, 57,-43, 25, -9}
};

static int64_t diff(struct timespec start, struct timespec end)
{
    struct timespec temp;
    int64_t d;
    if ((end.tv_nsec-start.tv_nsec)<0) {
        temp.tv_sec = end.tv_sec-start.tv_sec-1;
        temp.tv_nsec = 1000000000+end.tv_nsec-start.tv_nsec;
    } else {
        temp.tv_sec = end.tv_sec-start.tv_sec;
        temp.tv_nsec = end.tv_nsec-start.tv_nsec;
    }
    d = temp.tv_sec*1000000000+temp.tv_nsec;
    return d;
}

static void compare_results(short *ref, short *res, const char *msg)
{
    int correct =1;

    printf("Comparing %s\n",msg);
    for(int j=0; j<IDCT_SIZE; j++)  {
        for(int i=0; i<IDCT_SIZE; i++){
            if(ref[j*IDCT_SIZE+i] != res[j*IDCT_SIZE+i]){
                correct=0;
                printf("failed at %d,%d\t ref=%d, res=%d\n ", i, j, ref[j*IDCT_SIZE+i],res[j*IDCT_SIZE+i]);
            }
        }
    }
    if (correct){
        printf("correct\n\n");
    }
}

// this function is for timing, do not change anything here
static void benchmark( void (*idct16)(short *, short *), short *input, short *output, const char *version )
{
    struct timespec start, end;
    clock_gettime(CLOCK_REALTIME,&start);

    for(int i=0;i<ITERATIONS;i++)
        idct16(input, output);

    clock_gettime(CLOCK_REALTIME,&end);
    double avg = (double) diff(start,end)/ITERATIONS;
    printf("%10s:\t %.3f ns\n", version, avg);
}

//scalar code for the inverse transform
static void partialButterflyInverse16(short *src, short *dst, int shift)
{
  int E[8],O[8];
  int EE[4],EO[4];
  int EEE[2],EEO[2];
  int add = 1<<(shift-1);

  for (int j=0; j<16; j++)
  {
    /* Utilizing symmetry properties to the maximum to minimize the number of multiplications */
    for (int k=0; k<8; k++)
    {
      O[k] = g_aiT16[ 1][k]*src[ 16] + g_aiT16[ 3][k]*src[ 3*16] + g_aiT16[ 5][k]*src[ 5*16] + g_aiT16[ 7][k]*src[ 7*16] +
        g_aiT16[ 9][k]*src[ 9*16] + g_aiT16[11][k]*src[11*16] + g_aiT16[13][k]*src[13*16] + g_aiT16[15][k]*src[15*16];
    }
    /*Parallelization
    i. transpose src so that both will be aligned. Now, multiply each with the proper method.
    ii. Add the solution which I should try to do parallely
    */
    for (int k=0; k<4; k++)
    {
      EO[k] = g_aiT16[ 2][k]*src[ 2*16] + g_aiT16[ 6][k]*src[ 6*16] + g_aiT16[10][k]*src[10*16] + g_aiT16[14][k]*src[14*16];
    }
    /*Apply same principle as before*/
    EEO[0] = g_aiT16[4][0]*src[ 4*16 ] + g_aiT16[12][0]*src[ 12*16 ];
    EEE[0] = g_aiT16[0][0]*src[ 0    ] + g_aiT16[ 8][0]*src[  8*16 ];
    EEO[1] = g_aiT16[4][1]*src[ 4*16 ] + g_aiT16[12][1]*src[ 12*16 ];
    EEE[1] = g_aiT16[0][1]*src[ 0    ] + g_aiT16[ 8][1]*src[  8*16 ];

    /* Combining even and odd terms at each hierarchy levels to calculate the final spatial domain vector */
    for (int k=0; k<2; k++)
    {
      EE[k] = EEE[k] + EEO[k];
      EE[k+2] = EEE[1-k] - EEO[1-k];
    }
    for (int k=0; k<4; k++)
    {
      E[k] = EE[k] + EO[k];
      E[k+4] = EE[3-k] - EO[3-k];
    }
    for (int k=0; k<8; k++)
    {
      dst[k]   = MAX( -32768, MIN( 32767, (E[k]   + O[k]   + add)>>shift ));
      dst[k+8] = MAX( -32768, MIN( 32767, (E[7-k] - O[7-k] + add)>>shift ));
    }
    src ++;
    dst += 16;
  }
}

//scalar code for the inverse transform
static void partialButterflyInverse16_simd(short *src, short *dst, int shift)
{
  int E[8],O[8] __attribute__((aligned(16)));
  int EE[4],EO[4] __attribute__((aligned(16)));
  int EEE[2],EEO[2] __attribute__((aligned(16)));
  int add = 1<<(shift-1);

  int temp_output[8] __attribute__((aligned(16)));
  int temp_output1[4] __attribute__((aligned(16)));

#if 1 //For Optimization Level 0
  __m128i const_vector_arr[8];

    for( int k=0; k<8; k++ ) {
        const_vector_arr[k] = _mm_set_epi16(g_aiT16[15][k], g_aiT16[13][k], g_aiT16[11][k], g_aiT16[9][k], 
          g_aiT16[7][k], g_aiT16[5][k], g_aiT16[3][k], g_aiT16[1][k]);
    }
#endif

#if 0 //For the optimization level 1
  __m128i const_vector_arr_1[2]; 
  const_vector_arr_1[0] = _mm_set_epi16( g_aiT16[14][1], g_aiT16[10][1], g_aiT16[6][1], g_aiT16[2][1], 
            g_aiT16[14][0], g_aiT16[10][0], g_aiT16[6][0], g_aiT16[2][0]);
  const_vector_arr_1[1] = _mm_set_epi16( g_aiT16[14][3], g_aiT16[10][3], g_aiT16[6][3], g_aiT16[2][3], 
            g_aiT16[14][2], g_aiT16[10][2], g_aiT16[6][2], g_aiT16[2][2]);
#endif

#if 0 //For the optimization level 2
  __m128i const_vector_2; 
  const_vector_2 = _mm_set_epi16(g_aiT16[8][1], g_aiT16[0][1], g_aiT16[12][1], g_aiT16[4][1], 
         g_aiT16[8][0], g_aiT16[0][0], g_aiT16[12][0], g_aiT16[4][0]);
#endif

  for (int j=0; j<16; j++)
  {
    /* Utilizing symmetry properties to the maximum to minimize the number of multiplications */

    /*************************** Optimization LEVEL 0 *******************************************************/
    //Test phase begins
    __m128i src_vector;
    __m128i const_vector;


    src_vector = _mm_set_epi16(*(src+240), *(src+208), *(src+176), *(src+144), *(src+112), 
      *(src+80), *(src+48), *(src+16));
  #if 0
    __m128i lo_out[8];
    __m128i hi_out[8];
    for( int k=0; k<8; k++ ) {
      const_vector = *(__m128i *) &g_aiT16[k*2+1][0];
      lo_out[k] = _mm_mullo_epi16 (const_vector, src_vector);
      hi_out[k] = _mm_mulhi_epi16 (const_vector, src_vector);
    }

    for( int k=0; k<8; k++ ) {
      *(__m128i *) temp_output = _mm_unpacklo_epi16 ( lo_out[k], hi_out[k] );
      *(__m128i *) &temp_output[4] = _mm_unpackhi_epi16( lo_out[k], hi_out[k] );
      *(__m128i *) temp_output1 = _mm_add_epi32 (*(__m128i *)temp_output, *(__m128i *) &temp_output[4] );
      O[k] = temp_output1[0] + temp_output1[1] + temp_output1[2] + temp_output1[3];
    }
  #else
  #if 1


    //const_vector = *(__m128i *) ps8O_g;

    for( int k=0; k<8; k++ ) {
       *(__m128i *) temp_output1  = _mm_madd_epi16 ( const_vector_arr[k], src_vector );
       O[k] = temp_output1[0] + temp_output1[1] + temp_output1[2] + temp_output1[3];
    }
  #else

    //Test phase ends
    for (int k=0; k<8; k++)
    {
      O[k] = g_aiT16[ 1][k]*src[ 16] + g_aiT16[ 3][k]*src[ 3*16] + g_aiT16[ 5][k]*src[ 5*16] + g_aiT16[ 7][k]*src[ 7*16] +
        g_aiT16[ 9][k]*src[ 9*16] + g_aiT16[11][k]*src[11*16] + g_aiT16[13][k]*src[13*16] + g_aiT16[15][k]*src[15*16];
    }
  #endif
#endif
  /*************************** Optimization LEVEL 0 Ends *******************************************************/

  /*************************** Optimization LEVEL 1 Begins *******************************************************/
#if 0
    //Test phase begins (This portion is not optimizing rather is very costly)
    src_vector = _mm_set_epi16(*(src+14*16), *(src+10*16), *(src+6*16), *(src+2*16), *(src+14*16), 
      *(src+10*16), *(src+6*16), *(src+2*16));
    *(__m128i *) temp_output1  = _mm_madd_epi16 ( const_vector_arr_1[0], src_vector );
    EO[0] = temp_output1[0] + temp_output1[1];
    EO[1] = temp_output1[2] + temp_output1[3];

    *(__m128i *) temp_output1  = _mm_madd_epi16 ( const_vector_arr_1[1], src_vector );
    EO[2] = temp_output1[0] + temp_output1[1];
    EO[3] = temp_output1[2] + temp_output1[3];
    //Test phase ends
#else
    for (int k=0; k<4; k++)
    {

      EO[k] = g_aiT16[ 2][k]*src[ 2*16] + g_aiT16[ 6][k]*src[ 6*16] + g_aiT16[10][k]*src[10*16] + g_aiT16[14][k]*src[14*16];
    }
#endif
    /*************************** Optimization LEVEL 1 Ends *******************************************************/

    /*************************** Optimization LEVEL 2 *******************************************************/
  #if 0
    src_vector = _mm_set_epi16(*(src+8*16), *(src), *(src+12*16), *(src+4*16), *(src+8*16), 
     *(src), *(src+12*16), *(src+4*16));
    *(__m128i *) temp_output1  = _mm_madd_epi16 ( const_vector_2, src_vector );
    EEO[0] = temp_output1[0];
    EEE[0] = temp_output1[1];
    EEO[1] = temp_output1[2];
    EEE[1] = temp_output1[3];
    for (int k=0; k<2; k++)
    {
      EE[k] = EEE[k] + EEO[k];
      EE[k+2] = EEE[1-k] - EEO[1-k];
    }
    *(__m128i *) E =  _mm_add_epi32( *(__m128i *) EE, *(__m128i *) EO );
    *(__m128i *) temp_output1 = _mm_sub_epi32( *(__m128i *) EE, *(__m128i *) EO );
     *(__m128i *) &E[4] = _mm_shuffle_epi32( *(__m128i *) temp_output1, 27 );
#if 0
    for (int k=0; k<4; k++)
    {
      E[k] = EE[k] + EO[k];
      E[k+4] = EE[3-k] - EO[3-k];
    }
#endif
  #else
  #if 0 //Type 2 Optimization
    EEO[0] = g_aiT16[4][0]*src[ 4*16 ] + g_aiT16[12][0]*src[ 12*16 ];
    EEE[0] = g_aiT16[0][0]*src[ 0    ] + g_aiT16[ 8][0]*src[  8*16 ];
    EEO[1] = g_aiT16[4][1]*src[ 4*16 ] + g_aiT16[12][1]*src[ 12*16 ];
    EEE[1] = g_aiT16[0][1]*src[ 0    ] + g_aiT16[ 8][1]*src[  8*16 ];
    /* Combining even and odd terms at each hierarchy levels to calculate the final spatial domain vector */
    for (int k=0; k<2; k++)
    {
      EE[k] = EEE[k] + EEO[k];
      EE[k+2] = EEE[1-k] - EEO[1-k];
    }
    *(__m128i *) E =  _mm_add_epi32( *(__m128i *) EE, *(__m128i *) EO );
    *(__m128i *) temp_output1 = _mm_sub_epi32( *(__m128i *) EE, *(__m128i *) EO );
    *(__m128i *) &E[4] = _mm_shuffle_epi32( *(__m128i *) temp_output1, 27 );
  #else
    EEO[0] = g_aiT16[4][0]*src[ 4*16 ] + g_aiT16[12][0]*src[ 12*16 ];
    EEE[0] = g_aiT16[0][0]*src[ 0    ] + g_aiT16[ 8][0]*src[  8*16 ];
    EEO[1] = g_aiT16[4][1]*src[ 4*16 ] + g_aiT16[12][1]*src[ 12*16 ];
    EEE[1] = g_aiT16[0][1]*src[ 0    ] + g_aiT16[ 8][1]*src[  8*16 ];
    /* Combining even and odd terms at each hierarchy levels to calculate the final spatial domain vector */
    for (int k=0; k<2; k++)
    {
      EE[k] = EEE[k] + EEO[k];
      EE[k+2] = EEE[1-k] - EEO[1-k];
    }
    for (int k=0; k<4; k++)
    {
      E[k] = EE[k] + EO[k];
      E[k+4] = EE[3-k] - EO[3-k];
    }
  #endif
#endif
    /*************************** Optimization LEVEL 2 Ends *******************************************************/

    /*************************** Optimization LEVEL 3 Begin *******************************************************/
#if 1
    __m128i s128Var1, s128Var2, s128Var3, s128Var4, s128Var5, s128Var6, s128Var7, s12AddVec;

    s128Var1 = _mm_add_epi32( *(__m128i *) E, *(__m128i *) O);
    s128Var2 = _mm_add_epi32( *(__m128i *) &E[4], *(__m128i *) &O[4]);


    s12AddVec = _mm_set1_epi32(add);



    s128Var3 = _mm_add_epi32( s128Var1, s12AddVec );
    s128Var4 = _mm_add_epi32( s128Var2, s12AddVec );
    s128Var5 = _mm_srai_epi32 ( s128Var3, shift );
    s128Var6 = _mm_srai_epi32 ( s128Var4, shift );
    s128Var1 = _mm_packs_epi32(s128Var5, s128Var6 );
    //*(__m128i *) dst = _mm_packs_epi32(s128Var5, s128Var6 );

    _mm_store_si128( (__m128i *)dst, s128Var1);

    //This one is for subtraction
    s128Var1 = _mm_sub_epi32( *(__m128i *) E, *(__m128i *) O);
    s128Var2 = _mm_sub_epi32( *(__m128i *) &E[4], *(__m128i *) &O[4]);


    s12AddVec = _mm_set1_epi32(add);



    s128Var3 = _mm_add_epi32( s128Var1, s12AddVec );
    s128Var4 = _mm_add_epi32( s128Var2, s12AddVec );
    s128Var5 = _mm_srai_epi32 ( s128Var3, shift );
    s128Var6 = _mm_srai_epi32 ( s128Var4, shift );
    s128Var7 = _mm_packs_epi32(s128Var5, s128Var6 );

     *(__m64 *)&dst[12] = _mm_shuffle_pi16 ( *(__m64 *)&s128Var7, 27 );
     *(__m64 *)&dst[8] = _mm_shuffle_pi16 ( *(__m64 *)&s128Var7[1], 27 );
#else
   
  
    for (int k=0; k<8; k++)
    {
      dst[k]   = MAX( -32768, MIN( 32767, (E[k]   + O[k]   + add)>>shift ));
      dst[k+8] = MAX( -32768, MIN( 32767, (E[7-k] - O[7-k] + add)>>shift ));
    }
  
#endif
/*************************** Optimization LEVEL 3 Ends *******************************************************/
    src ++;
    dst += 16;
  }
}

static void idct16_scalar(short* pCoeff, short* pDst)
{
  short tmp[ 16*16] __attribute__((aligned(16)));
  partialButterflyInverse16(pCoeff, tmp, 7);
  partialButterflyInverse16(tmp, pDst, 12);
}



//scalar code for the inverse transform
static void partialButterflyInverse16_simd2(short *src, short *orig_dst, int shift1, int shift2 )
{
  int E[8],O[8] __attribute__((aligned(16)));
  int EE[4],EO[4] __attribute__((aligned(16)));
  int EEE[2],EEO[2] __attribute__((aligned(16)));
  int add = 1<<(shift1-1);

  int temp_output[8] __attribute__((aligned(16)));
  int temp_output1[4] __attribute__((aligned(16)));
  short tmp[ 16*16] __attribute__((aligned(16)));
  short *dst = tmp;
  __m128i src_vector;
  __m128i const_vector;

#if 1 //For Optimization Level 0
  __m128i const_vector_arr[8];

    for( int k=0; k<8; k++ ) {
        const_vector_arr[k] = _mm_set_epi16(g_aiT16[15][k], g_aiT16[13][k], g_aiT16[11][k], g_aiT16[9][k], 
          g_aiT16[7][k], g_aiT16[5][k], g_aiT16[3][k], g_aiT16[1][k]);
    }
#endif

  for (int j=0; j<16; j++)
  {
    /* Utilizing symmetry properties to the maximum to minimize the number of multiplications */

    /*************************** Optimization LEVEL 0 *******************************************************/
    //Test phase begins


    src_vector = _mm_set_epi16(*(src+240), *(src+208), *(src+176), *(src+144), *(src+112), 
      *(src+80), *(src+48), *(src+16));


    //const_vector = *(__m128i *) ps8O_g;

    for( int k=0; k<8; k++ ) {
       *(__m128i *) temp_output1  = _mm_madd_epi16 ( const_vector_arr[k], src_vector );
       O[k] = temp_output1[0] + temp_output1[1] + temp_output1[2] + temp_output1[3];
    }
  /*************************** Optimization LEVEL 0 Ends *******************************************************/

  /*************************** Optimization LEVEL 1 Begins *******************************************************/
    for (int k=0; k<4; k++)
    {

      EO[k] = g_aiT16[ 2][k]*src[ 2*16] + g_aiT16[ 6][k]*src[ 6*16] + g_aiT16[10][k]*src[10*16] + g_aiT16[14][k]*src[14*16];
    }
    /*************************** Optimization LEVEL 1 Ends *******************************************************/

    /*************************** Optimization LEVEL 2 *******************************************************/
    EEO[0] = g_aiT16[4][0]*src[ 4*16 ] + g_aiT16[12][0]*src[ 12*16 ];
    EEE[0] = g_aiT16[0][0]*src[ 0    ] + g_aiT16[ 8][0]*src[  8*16 ];
    EEO[1] = g_aiT16[4][1]*src[ 4*16 ] + g_aiT16[12][1]*src[ 12*16 ];
    EEE[1] = g_aiT16[0][1]*src[ 0    ] + g_aiT16[ 8][1]*src[  8*16 ];
    /* Combining even and odd terms at each hierarchy levels to calculate the final spatial domain vector */
    for (int k=0; k<2; k++)
    {
      EE[k] = EEE[k] + EEO[k];
      EE[k+2] = EEE[1-k] - EEO[1-k];
    }
    for (int k=0; k<4; k++)
    {
      E[k] = EE[k] + EO[k];
      E[k+4] = EE[3-k] - EO[3-k];
    }
    /*************************** Optimization LEVEL 2 Ends *******************************************************/

    /*************************** Optimization LEVEL 3 Begin *******************************************************/
    __m128i s128Var1, s128Var2, s128Var3, s128Var4, s128Var5, s128Var6, s128Var7, s12AddVec;

    s128Var1 = _mm_add_epi32( *(__m128i *) E, *(__m128i *) O);
    s128Var2 = _mm_add_epi32( *(__m128i *) &E[4], *(__m128i *) &O[4]);


    s12AddVec = _mm_set1_epi32(add);



    s128Var3 = _mm_add_epi32( s128Var1, s12AddVec );
    s128Var4 = _mm_add_epi32( s128Var2, s12AddVec );
    s128Var5 = _mm_srai_epi32 ( s128Var3, shift1 );
    s128Var6 = _mm_srai_epi32 ( s128Var4, shift1 );
    s128Var1 = _mm_packs_epi32(s128Var5, s128Var6 );
    //*(__m128i *) dst = _mm_packs_epi32(s128Var5, s128Var6 );

    _mm_store_si128( (__m128i *)dst, s128Var1);

    //This one is for subtraction
    s128Var1 = _mm_sub_epi32( *(__m128i *) E, *(__m128i *) O);
    s128Var2 = _mm_sub_epi32( *(__m128i *) &E[4], *(__m128i *) &O[4]);


    s12AddVec = _mm_set1_epi32(add);



    s128Var3 = _mm_add_epi32( s128Var1, s12AddVec );
    s128Var4 = _mm_add_epi32( s128Var2, s12AddVec );
    s128Var5 = _mm_srai_epi32 ( s128Var3, shift1 );
    s128Var6 = _mm_srai_epi32 ( s128Var4, shift1 );
    s128Var7 = _mm_packs_epi32(s128Var5, s128Var6 );

     *(__m64 *)&dst[12] = _mm_shuffle_pi16 ( *(__m64 *)&s128Var7, 27 );
     *(__m64 *)&dst[8] = _mm_shuffle_pi16 ( *(__m64 *)&s128Var7[1], 27 );
/*************************** Optimization LEVEL 3 Ends *******************************************************/
    src ++;
    dst += 16;
  }


  src = tmp;
  dst = orig_dst;
  add = 1<<(shift2-1);
  for (int j=0; j<16; j++)
  {
    /* Utilizing symmetry properties to the maximum to minimize the number of multiplications */

    /*************************** Optimization LEVEL 0 *******************************************************/
    //Test phase begins


    src_vector = _mm_set_epi16(*(src+240), *(src+208), *(src+176), *(src+144), *(src+112), 
      *(src+80), *(src+48), *(src+16));


    //const_vector = *(__m128i *) ps8O_g;

    for( int k=0; k<8; k++ ) {
       *(__m128i *) temp_output1  = _mm_madd_epi16 ( const_vector_arr[k], src_vector );
       O[k] = temp_output1[0] + temp_output1[1] + temp_output1[2] + temp_output1[3];
    }
  /*************************** Optimization LEVEL 0 Ends *******************************************************/

  /*************************** Optimization LEVEL 1 Begins *******************************************************/
    for (int k=0; k<4; k++)
    {
      EO[k] = g_aiT16[ 2][k]*src[ 2*16] + g_aiT16[ 6][k]*src[ 6*16] + g_aiT16[10][k]*src[10*16] + g_aiT16[14][k]*src[14*16];
    }
    /*************************** Optimization LEVEL 1 Ends *******************************************************/

    /*************************** Optimization LEVEL 2 *******************************************************/
    EEO[0] = g_aiT16[4][0]*src[ 4*16 ] + g_aiT16[12][0]*src[ 12*16 ];
    EEE[0] = g_aiT16[0][0]*src[ 0    ] + g_aiT16[ 8][0]*src[  8*16 ];
    EEO[1] = g_aiT16[4][1]*src[ 4*16 ] + g_aiT16[12][1]*src[ 12*16 ];
    EEE[1] = g_aiT16[0][1]*src[ 0    ] + g_aiT16[ 8][1]*src[  8*16 ];
    /* Combining even and odd terms at each hierarchy levels to calculate the final spatial domain vector */
    for (int k=0; k<2; k++)
    {
      EE[k] = EEE[k] + EEO[k];
      EE[k+2] = EEE[1-k] - EEO[1-k];
    }
    for (int k=0; k<4; k++)
    {
      E[k] = EE[k] + EO[k];
      E[k+4] = EE[3-k] - EO[3-k];
    }
    /*************************** Optimization LEVEL 2 Ends *******************************************************/

    /*************************** Optimization LEVEL 3 Begin *******************************************************/
    __m128i s128Var1, s128Var2, s128Var3, s128Var4, s128Var5, s128Var6, s128Var7, s12AddVec;

    s128Var1 = _mm_add_epi32( *(__m128i *) E, *(__m128i *) O);
    s128Var2 = _mm_add_epi32( *(__m128i *) &E[4], *(__m128i *) &O[4]);


    s12AddVec = _mm_set1_epi32(add);



    s128Var3 = _mm_add_epi32( s128Var1, s12AddVec );
    s128Var4 = _mm_add_epi32( s128Var2, s12AddVec );
    s128Var5 = _mm_srai_epi32 ( s128Var3, shift2 );
    s128Var6 = _mm_srai_epi32 ( s128Var4, shift2 );
    s128Var1 = _mm_packs_epi32(s128Var5, s128Var6 );
    //*(__m128i *) dst = _mm_packs_epi32(s128Var5, s128Var6 );

    _mm_store_si128( (__m128i *)dst, s128Var1);

    //This one is for subtraction
    s128Var1 = _mm_sub_epi32( *(__m128i *) E, *(__m128i *) O);
    s128Var2 = _mm_sub_epi32( *(__m128i *) &E[4], *(__m128i *) &O[4]);


    s12AddVec = _mm_set1_epi32(add);



    s128Var3 = _mm_add_epi32( s128Var1, s12AddVec );
    s128Var4 = _mm_add_epi32( s128Var2, s12AddVec );
    s128Var5 = _mm_srai_epi32 ( s128Var3, shift2 );
    s128Var6 = _mm_srai_epi32 ( s128Var4, shift2 );
    s128Var7 = _mm_packs_epi32(s128Var5, s128Var6 );

     *(__m64 *)&dst[12] = _mm_shuffle_pi16 ( *(__m64 *)&s128Var7, 27 );
     *(__m64 *)&dst[8] = _mm_shuffle_pi16 ( *(__m64 *)&s128Var7[1], 27 );
/*************************** Optimization LEVEL 3 Ends *******************************************************/
    src ++;
    dst += 16;
  }
}









//scalar code for the inverse transform
static void partialButterflyInverse16_simd3(short *src, short *dst, int shift1 )
{
  int E[8][8],O[8][8] __attribute__((aligned(16)));
  int EE[8][4],EO[8][4] __attribute__((aligned(16)));
  int EEE[8][2],EEO[8][2] __attribute__((aligned(16)));
  int add = 1<<(shift1-1);

  int temp_output[8] __attribute__((aligned(16)));
  int temp_output1[4] __attribute__((aligned(16)));
  //short tmp[ 16*16] __attribute__((aligned(16)));
  //short *dst = tmp;
  __m128i src_vector;
  __m128i const_vector;

#if 1 //For Optimization Level 0
  __m128i const_vector_arr[8], src_vector_arr[8];



  __m128i I0 = _mm_load_si128((__m128i*)&g_aiT16[1]);
  __m128i I1 = _mm_load_si128((__m128i*)&g_aiT16[3]);
  __m128i I2 = _mm_load_si128((__m128i*)&g_aiT16[5]);
  __m128i I3 = _mm_load_si128((__m128i*)&g_aiT16[7]);
  __m128i I4 = _mm_load_si128((__m128i*)&g_aiT16[9]);
  __m128i I5 = _mm_load_si128((__m128i*)&g_aiT16[11]);
  __m128i I6 = _mm_load_si128((__m128i*)&g_aiT16[13]);
  __m128i I7 = _mm_load_si128((__m128i*)&g_aiT16[15]);

  __m128i T0 = _mm_unpacklo_epi16(I0, I1);
  __m128i T1 = _mm_unpackhi_epi16(I0, I1);
  __m128i T2 = _mm_unpacklo_epi16(I2, I3);
  __m128i T3 = _mm_unpackhi_epi16(I2, I3);
  __m128i T4 = _mm_unpacklo_epi16(I4, I5);
  __m128i T5 = _mm_unpackhi_epi16(I4, I5);
  __m128i T6 = _mm_unpacklo_epi16(I6, I7);
  __m128i T7 = _mm_unpackhi_epi16(I6, I7);
  I0 = _mm_unpacklo_epi32(T0, T2);
  I1 = _mm_unpackhi_epi32(T0, T2);
  I2 = _mm_unpacklo_epi32(T1, T3);
  I3 = _mm_unpackhi_epi32(T1, T3);
  I4 = _mm_unpacklo_epi32(T4, T6);
  I5 = _mm_unpackhi_epi32(T4, T6);
  I6 = _mm_unpacklo_epi32(T5, T7);
  I7 = _mm_unpackhi_epi32(T5, T7);
  const_vector_arr[0] = _mm_unpacklo_epi64(I0, I4);
  const_vector_arr[1] = _mm_unpackhi_epi64(I0, I4);
  const_vector_arr[2] = _mm_unpacklo_epi64(I1, I5);
  const_vector_arr[3] = _mm_unpackhi_epi64(I1, I5);
  const_vector_arr[4] = _mm_unpacklo_epi64(I2, I6);
  const_vector_arr[5] = _mm_unpackhi_epi64(I2, I6);
  const_vector_arr[6] = _mm_unpacklo_epi64(I3, I7);
  const_vector_arr[7] = _mm_unpackhi_epi64(I3, I7);


#if 1 //For the optimization level 1
  __m128i const_vector_arr_1[2];
  *(__m64 *)&I0 = *(__m64 *)&g_aiT16[2][0];
  ((__m64 *)&I0)[1] =  *(__m64 *) &g_aiT16[10][0];
  *(__m64 *)&I1 = *(__m64 *)&g_aiT16[6][0];
  ((__m64 *)&I1)[1] =  *(__m64 *) &g_aiT16[14][0];

  T0 = _mm_unpacklo_epi16(I0, I1);
  T1 = _mm_unpackhi_epi16(I0, I1);

  const_vector_arr_1[0] = _mm_unpacklo_epi32(T0, T1);
  const_vector_arr_1[1] = _mm_unpackhi_epi32(T0, T1);


#if 1 //For the optimization level 2
  __m128i const_vector_2; 
  const_vector_2 = _mm_set_epi16(g_aiT16[8][1], g_aiT16[0][1], g_aiT16[12][1], g_aiT16[4][1], 
         g_aiT16[8][0], g_aiT16[0][0], g_aiT16[12][0], g_aiT16[4][0]);
#endif
#endif
#endif

  for (int j=0; j<2; j++)
  {
    /* Utilizing symmetry properties to the maximum to minimize the number of multiplications */

    /*************************** Optimization LEVEL 0 *******************************************************/
    //Test phase begins
    short *orig_src = src;



    I0 = _mm_load_si128((__m128i*)&src[16]);
    I1 = _mm_load_si128((__m128i*)&src[48]);
    I2 = _mm_load_si128((__m128i*)&src[80]);
    I3 = _mm_load_si128((__m128i*)&src[112]);
    I4 = _mm_load_si128((__m128i*)&src[144]);
    I5 = _mm_load_si128((__m128i*)&src[176]);
    I6 = _mm_load_si128((__m128i*)&src[208]);
    I7 = _mm_load_si128((__m128i*)&src[240]);

    T0 = _mm_unpacklo_epi16(I0, I1);
    T1 = _mm_unpackhi_epi16(I0, I1);
    T2 = _mm_unpacklo_epi16(I2, I3);
    T3 = _mm_unpackhi_epi16(I2, I3);
    T4 = _mm_unpacklo_epi16(I4, I5);
    T5 = _mm_unpackhi_epi16(I4, I5);
    T6 = _mm_unpacklo_epi16(I6, I7);
    T7 = _mm_unpackhi_epi16(I6, I7);

    I0 = _mm_unpacklo_epi32(T0, T2);
    I1 = _mm_unpackhi_epi32(T0, T2);
    I2 = _mm_unpacklo_epi32(T1, T3);
    I3 = _mm_unpackhi_epi32(T1, T3);
    I4 = _mm_unpacklo_epi32(T4, T6);
    I5 = _mm_unpackhi_epi32(T4, T6);
    I6 = _mm_unpacklo_epi32(T5, T7);
    I7 = _mm_unpackhi_epi32(T5, T7);

    src_vector_arr[0] = _mm_unpacklo_epi64(I0, I4);
    src_vector_arr[1] = _mm_unpackhi_epi64(I0, I4);
    src_vector_arr[2] = _mm_unpacklo_epi64(I1, I5);
    src_vector_arr[3] = _mm_unpackhi_epi64(I1, I5);
    src_vector_arr[4] = _mm_unpacklo_epi64(I2, I6);
    src_vector_arr[5] = _mm_unpackhi_epi64(I2, I6);
    src_vector_arr[6] = _mm_unpacklo_epi64(I3, I7);
    src_vector_arr[7] = _mm_unpackhi_epi64(I3, I7);
    //const_vector = *(__m128i *) ps8O_g;

    for( int k=0; k<8; k++ ) {
       *(__m128i *) temp_output1  = _mm_madd_epi16 ( const_vector_arr[k], src_vector_arr[0] );
       O[0][k] = temp_output1[0] + temp_output1[1] + temp_output1[2] + temp_output1[3];

       *(__m128i *) temp_output1  = _mm_madd_epi16 ( const_vector_arr[k], src_vector_arr[1] );
       O[1][k] = temp_output1[0] + temp_output1[1] + temp_output1[2] + temp_output1[3];

       *(__m128i *) temp_output1  = _mm_madd_epi16 ( const_vector_arr[k], src_vector_arr[2] );
       O[2][k] = temp_output1[0] + temp_output1[1] + temp_output1[2] + temp_output1[3];

       *(__m128i *) temp_output1  = _mm_madd_epi16 ( const_vector_arr[k], src_vector_arr[3] );
       O[3][k] = temp_output1[0] + temp_output1[1] + temp_output1[2] + temp_output1[3];

       *(__m128i *) temp_output1  = _mm_madd_epi16 ( const_vector_arr[k], src_vector_arr[4] );
       O[4][k] = temp_output1[0] + temp_output1[1] + temp_output1[2] + temp_output1[3];

       *(__m128i *) temp_output1  = _mm_madd_epi16 ( const_vector_arr[k], src_vector_arr[5] );
       O[5][k] = temp_output1[0] + temp_output1[1] + temp_output1[2] + temp_output1[3];

       *(__m128i *) temp_output1  = _mm_madd_epi16 ( const_vector_arr[k], src_vector_arr[6] );
       O[6][k] = temp_output1[0] + temp_output1[1] + temp_output1[2] + temp_output1[3];

       *(__m128i *) temp_output1  = _mm_madd_epi16 ( const_vector_arr[k], src_vector_arr[7] );
       O[7][k] = temp_output1[0] + temp_output1[1] + temp_output1[2] + temp_output1[3];
    }
  /*************************** Optimization LEVEL 0 Ends *******************************************************/

  /*************************** Optimization LEVEL 1 Begins *******************************************************/

    //Test phase begins (This portion is not optimizing rather is very costly)

    //Complete it tomorrow morning
    I0 = _mm_load_si128((__m128i*)&src[32]);
    I1 = _mm_load_si128((__m128i*)&src[96]);
    I2 = _mm_load_si128((__m128i*)&src[160]);
    I3 = _mm_load_si128((__m128i*)&src[224]);
    I4 = _mm_load_si128((__m128i*)&src[32]);
    I5 = _mm_load_si128((__m128i*)&src[96]);
    I6 = _mm_load_si128((__m128i*)&src[160]);
    I7 = _mm_load_si128((__m128i*)&src[224]);

    T0 = _mm_unpacklo_epi16(I0, I1);
    T1 = _mm_unpackhi_epi16(I0, I1);
    T2 = _mm_unpacklo_epi16(I2, I3);
    T3 = _mm_unpackhi_epi16(I2, I3);
    T4 = _mm_unpacklo_epi16(I4, I5);
    T5 = _mm_unpackhi_epi16(I4, I5);
    T6 = _mm_unpacklo_epi16(I6, I7);
    T7 = _mm_unpackhi_epi16(I6, I7);

    I0 = _mm_unpacklo_epi32(T0, T2);
    I1 = _mm_unpackhi_epi32(T0, T2);
    I2 = _mm_unpacklo_epi32(T1, T3);
    I3 = _mm_unpackhi_epi32(T1, T3);
    I4 = _mm_unpacklo_epi32(T4, T6);
    I5 = _mm_unpackhi_epi32(T4, T6);
    I6 = _mm_unpacklo_epi32(T5, T7);
    I7 = _mm_unpackhi_epi32(T5, T7);

    src_vector_arr[0] = _mm_unpacklo_epi64(I0, I4);
    src_vector_arr[1] = _mm_unpackhi_epi64(I0, I4);
    src_vector_arr[2] = _mm_unpacklo_epi64(I1, I5);
    src_vector_arr[3] = _mm_unpackhi_epi64(I1, I5);
    src_vector_arr[4] = _mm_unpacklo_epi64(I2, I6);
    src_vector_arr[5] = _mm_unpackhi_epi64(I2, I6);
    src_vector_arr[6] = _mm_unpacklo_epi64(I3, I7);
    src_vector_arr[7] = _mm_unpackhi_epi64(I3, I7);

    for( int m=0; m<8; m++ ) {
      *(__m128i *) temp_output1  = _mm_madd_epi16 ( const_vector_arr_1[0], src_vector_arr[m] );
      EO[m][0] = temp_output1[0] + temp_output1[1];
      EO[m][1] = temp_output1[2] + temp_output1[3];

      *(__m128i *) temp_output1  = _mm_madd_epi16 ( const_vector_arr_1[1], src_vector_arr[m] );
      EO[m][2] = temp_output1[0] + temp_output1[1];
      EO[m][3] = temp_output1[2] + temp_output1[3];
    }
    /*************************** Optimization LEVEL 1 Ends *******************************************************/

    /*************************** Optimization LEVEL 2 *******************************************************/

    I0 = _mm_load_si128((__m128i*)&src[64]);
    I1 = _mm_load_si128((__m128i*)&src[192]);
    I2 = _mm_load_si128((__m128i*)&src[0]);
    I3 = _mm_load_si128((__m128i*)&src[128]);
    I4 = _mm_load_si128((__m128i*)&src[64]);
    I5 = _mm_load_si128((__m128i*)&src[192]);
    I6 = _mm_load_si128((__m128i*)&src[0]);
    I7 = _mm_load_si128((__m128i*)&src[128]);

    T0 = _mm_unpacklo_epi16(I0, I1);
    T1 = _mm_unpackhi_epi16(I0, I1);
    T2 = _mm_unpacklo_epi16(I2, I3);
    T3 = _mm_unpackhi_epi16(I2, I3);
    T4 = _mm_unpacklo_epi16(I4, I5);
    T5 = _mm_unpackhi_epi16(I4, I5);
    T6 = _mm_unpacklo_epi16(I6, I7);
    T7 = _mm_unpackhi_epi16(I6, I7);

    I0 = _mm_unpacklo_epi32(T0, T2);
    I1 = _mm_unpackhi_epi32(T0, T2);
    I2 = _mm_unpacklo_epi32(T1, T3);
    I3 = _mm_unpackhi_epi32(T1, T3);
    I4 = _mm_unpacklo_epi32(T4, T6);
    I5 = _mm_unpackhi_epi32(T4, T6);
    I6 = _mm_unpacklo_epi32(T5, T7);
    I7 = _mm_unpackhi_epi32(T5, T7);

    src_vector_arr[0] = _mm_unpacklo_epi64(I0, I4);
    src_vector_arr[1] = _mm_unpackhi_epi64(I0, I4);
    src_vector_arr[2] = _mm_unpacklo_epi64(I1, I5);
    src_vector_arr[3] = _mm_unpackhi_epi64(I1, I5);
    src_vector_arr[4] = _mm_unpacklo_epi64(I2, I6);
    src_vector_arr[5] = _mm_unpackhi_epi64(I2, I6);
    src_vector_arr[6] = _mm_unpacklo_epi64(I3, I7);
    src_vector_arr[7] = _mm_unpackhi_epi64(I3, I7);
    for( int m=0; m<8; m++ ) {
      *(__m128i *) temp_output1  = _mm_madd_epi16 ( const_vector_2, src_vector_arr[m] );
      EE[m][0] = temp_output1[1] + temp_output1[0];
      EE[m][1] = temp_output1[3] + temp_output1[2];
      EE[m][2] = temp_output1[3] - temp_output1[2];
      EE[m][3] = temp_output1[1] - temp_output1[0];
      for (int k=0; k<4; k++)
      {
        E[m][k] = EE[m][k] + EO[m][k];
        E[m][k+4] = EE[m][3-k] - EO[m][3-k];
      }
    }
    /*************************** Optimization LEVEL 2 Ends *******************************************************/

    /*************************** Optimization LEVEL 3 Begin *******************************************************/
    __m128i s128Var1, s128Var2, s128Var3, s128Var4, s128Var5, s128Var6, s128Var7, s12AddVec;
    for( int m=0; m<8; m++ ) {

      s128Var1 = _mm_add_epi32( *(__m128i *) E[m], *(__m128i *) O[m]);
      s128Var2 = _mm_add_epi32( *(__m128i *) &E[m][4], *(__m128i *) &O[m][4]);


      s12AddVec = _mm_set1_epi32(add);



      s128Var3 = _mm_add_epi32( s128Var1, s12AddVec );
      s128Var4 = _mm_add_epi32( s128Var2, s12AddVec );
      s128Var5 = _mm_srai_epi32 ( s128Var3, shift1 );
      s128Var6 = _mm_srai_epi32 ( s128Var4, shift1 );
      s128Var1 = _mm_packs_epi32(s128Var5, s128Var6 );
    //*(__m128i *) dst = _mm_packs_epi32(s128Var5, s128Var6 );

      _mm_store_si128( (__m128i *)dst, s128Var1);

    //This one is for subtraction
      s128Var1 = _mm_sub_epi32( *(__m128i *) E[m], *(__m128i *) O[m]);
      s128Var2 = _mm_sub_epi32( *(__m128i *) &E[m][4], *(__m128i *) &O[m][4]);


      s12AddVec = _mm_set1_epi32(add);



      s128Var3 = _mm_add_epi32( s128Var1, s12AddVec );
      s128Var4 = _mm_add_epi32( s128Var2, s12AddVec );
      s128Var5 = _mm_srai_epi32 ( s128Var3, shift1 );
      s128Var6 = _mm_srai_epi32 ( s128Var4, shift1 );
      s128Var7 = _mm_packs_epi32(s128Var5, s128Var6 );

      *(__m64 *)&dst[12] = _mm_shuffle_pi16 ( *(__m64 *)&s128Var7, 27 );
      *(__m64 *)&dst[8] = _mm_shuffle_pi16 ( *(__m64 *)&s128Var7[1], 27 );

      src ++;
      dst += 16;
    }
/*************************** Optimization LEVEL 3 Ends *******************************************************/
  }
}


/// CURRENTLY SAME CODE AS SCALAR !!
/// REPLACE HERE WITH SSE intrinsics
static void idct16_simd(short* pCoeff, short* pDst)
{
#if 0
  short tmp[ 16*16] __attribute__((aligned(16)));
  partialButterflyInverse16_simd(pCoeff, tmp, 7);
  partialButterflyInverse16_simd(tmp, pDst, 12);
#else
  #if 0
  partialButterflyInverse16_simd2(pCoeff, pDst, 7, 12);
  #else
  short tmp[ 16*16] __attribute__((aligned(16)));
  partialButterflyInverse16_simd3(pCoeff, tmp, 7); //Just first one is used
  partialButterflyInverse16_simd3(tmp, pDst, 12);   //Just first one is used. Second is for furture purpose
  #endif
#endif
}

int main(int argc, char **argv)
{
    //allocate memory 16-byte aligned
    short *scalar_input = (short*) memalign(16, IDCT_SIZE*IDCT_SIZE*sizeof(short));
    short *scalar_output = (short *) memalign(16, IDCT_SIZE*IDCT_SIZE*sizeof(short));

    short *simd_input = (short*) memalign(16, IDCT_SIZE*IDCT_SIZE*sizeof(short));
    short *simd_output = (short *) memalign(16, IDCT_SIZE*IDCT_SIZE*sizeof(short));

    //initialize input
    printf("input array:\n");
    for(int j=0;j<IDCT_SIZE;j++){
        for(int i=0;i<IDCT_SIZE;i++){
            short value = rand()%2 ? (rand()%32768) : -(rand()%32768) ;
            scalar_input[j*IDCT_SIZE+i] = value;
            simd_input  [j*IDCT_SIZE+i] = value;
	    printf("%d\t", value);
        }
        printf("\n");
    }

    idct16_scalar(scalar_input, scalar_output);
    idct16_simd  (simd_input  , simd_output);

    //check for correctness
    compare_results (scalar_output, simd_output, "scalar and simd");

    printf("output array:\n");
    for(int j=0;j<IDCT_SIZE;j++){
        for(int i=0;i<IDCT_SIZE;i++){
	    printf("%d\t", scalar_output[j*IDCT_SIZE+i]);
        }
        printf("\n");
    }
    //Measure the performance of each kernel
    benchmark (idct16_scalar, scalar_input, scalar_output, "scalar");
    benchmark (idct16_simd, simd_input, simd_output, "simd");

    //cleanup
    free(scalar_input);    free(scalar_output);
    free(simd_input); free(simd_output);
}
