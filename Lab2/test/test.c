#include <immintrin.h>
#include <malloc.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <time.h>
#include <math.h>

int matrix[4][4] __attribute__ ((aligned(16)));

int transpose() {
	__m128i *matrix_vec = (__m128i *) matrix;

	__m128i I0 = _mm_load_si128(&matrix_vec[0]);
	__m128i I1 = _mm_load_si128(&matrix_vec[1]);
	__m128i I2 = _mm_load_si128(&matrix_vec[2]);
	__m128i I3 = _mm_load_si128(&matrix_vec[3]);

	__m128i T0 = _mm_unpacklo_epi32(I0, I1);
	__m128i T1 = _mm_unpacklo_epi32(I2, I3);
	__m128i T2 = _mm_unpackhi_epi32(I0, I1);
	__m128i T3 = _mm_unpackhi_epi32(I2, I3);

	I0 = _mm_unpacklo_epi64(T0, T1);
	I1 = _mm_unpackhi_epi64(T0, T1);
	I2 = _mm_unpacklo_epi64(T2, T3);
	I3 = _mm_unpackhi_epi64(T2, T3);

	_mm_store_si128( &matrix_vec[0], I0);
	_mm_store_si128( &matrix_vec[1], I1);
	_mm_store_si128( &matrix_vec[2], I2);
	_mm_store_si128( &matrix_vec[3], I3);

}

void print_2dArray() {
	for( int i=0; i<4; i++ ) {
		for( int j=0; j<4; j++ ) {
			printf("%d ", matrix[i][j]);
		}
		printf("\n");
	}
	printf("\n");
}

int main() {
	int *ptr;

	ptr = (int*)&matrix[0];
	for( int i=0; i<4; i++ ) {
		for( int j=0; j<4; j++ ) {
			*ptr++ = i*4+j+1;
		}
	}
	print_2dArray();
	transpose();
	print_2dArray();
}