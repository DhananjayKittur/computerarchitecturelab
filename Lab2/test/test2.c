#include <immintrin.h>
#include <malloc.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <time.h>
#include <math.h>

int input[100] __attribute__ ((aligned(16)));
int output[100] __attribute__ ((aligned(16)));

int scalar() {

	for (int i=0; i<100; i++) {
		output[i] = input[i] * input[i] + 3;
	}
}

int intrinsic() {

	//intrinsics code
	__m128i *in_vec = (__m128i *) input;
	__m128i *out_vec = (__m128i *) output;
	__m128i xmm0;
	__m128i add3 = _mm_set1_epi32(3);

	for (int i=0; i<25; i++ ) {
		xmm0 = _mm_load_si128( & in_vec[i] );
		xmm0 = _mm_mullo_epi32( xmm0, xmm0 );
		xmm0 = _mm_add_epi32 ( xmm0, add3 );
		_mm_store_si128( &out_vec[i], xmm0 );
	}
}
void print_1DArray(int *arr) {
	for( int i=0; i<100; i++ ) {
		printf("%d ", arr[i]);
	}
}

int main(){
	for( int i=0; i<100; i++ ) {
		input[i] = i + 1;
	}
	print_1DArray(input);
	scalar();
	printf("\n\nScalar Output\n\n");
	print_1DArray(output);
	intrinsic();
	printf("\n\nIntrinsic Output\n\n");
	print_1DArray(output);
	printf("\n\n");
}