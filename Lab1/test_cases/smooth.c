#include <stdio.h>
#include <stdlib.h>
#define OUTPUT_FILE "output.txt"
#define MAX_INPUT 100
#define MAX_COEFF MAX_INPUT

double	sample[MAX_INPUT] = {1, 2, 1, 2, 1};
double	coeff[MAX_COEFF]= {0.5, 1, 0.5};
double	result[MAX_INPUT];
int N_SAMPLES = 0;
int N_COEFFS = 0;

void smooth(double sample[], double coeff[], double result[], int n)
{
	int i, j;
	double norm=0.0;

	for (i=0; i<N_COEFFS; i++)
		norm+= coeff[i]>0 ? coeff[i] : -coeff[i];

	for (i=0; i<n; i++){
		if (i==0 || i==n-1){
			result[i] = sample[i];
		}else{
			result[i]=0.0;
			for (j=0; j<N_COEFFS; j++)
				result[i] += sample[i-1+j]*coeff[j];
			result[i]/=norm;
		}
	}
}

int main(int argc, char *arvg[])
{
	int i, j;
	int num_samples;
	FILE *file = fopen("test_input.txt", "r+");
	FILE *file_output = fopen(OUTPUT_FILE, "w+");
	fscanf( file, "%d", &num_samples);
	for( i=0; i<num_samples; i++ ) {
		fscanf(file, "%d", &N_COEFFS);
		for( j=0; j<N_COEFFS; j++ ) {
			fscanf(file, "%lf", &coeff[j]);
		}
		fscanf(file, "%d", &N_SAMPLES);
		for( j=0; j<N_SAMPLES; j++ ) {
			fscanf( file, "%lf", &sample[j] );
		}
		fprintf(file_output, "\nTest case: %d\n", i + 1);
		if (N_SAMPLES>=N_COEFFS) {
			smooth(sample, coeff, result, N_SAMPLES);
			for( j=0; j<N_SAMPLES; j++ ) {
				fprintf(file_output, " %lf ", result[j]);
			}
		}
		else {
			fprintf(file_output, "Value Not available\n");
		}
	}
	if (N_SAMPLES>=N_COEFFS)
		smooth(sample, coeff, result, N_SAMPLES);

	for (i=0; i<N_SAMPLES; i++)
		printf("%f\n", result[i]);

	fclose(file);
	fclose(file_output);

}
