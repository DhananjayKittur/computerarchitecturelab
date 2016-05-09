#include <stdio.h>

#define N_SAMPLES	5
#define N_COEFFS	3

double	sample[N_SAMPLES] = {1, 2, 1, 2, 1};
double	coeff[N_COEFFS]= {0.5, 1, 0.5};
double	result[N_SAMPLES];

void smooth(double sample[], double coeff[], double result[], int n)
{
	int i, j;
	double norm=0.0;

	for (i=0; i<N_COEFFS; i++)
		norm+= coeff[i]>0 ? coeff[i] : -coeff[i];

	//Check if need to check for negative n
	//Optimization 1
	result[0] = sample[0];
	//Optimization 1 ends
	//Optimization 2
	
	/*for (i=0; i<N_COEFFS; i++ )
		coeff[i] /= norm;
		//It may be used to replace result[i] /= norm
	*/
	//Optimization 2 ends. But not sure if it really does optimization
	for (i=1; i<n-1; i++){
		result[i]=0.0;
		for (j=0; j<N_COEFFS; j++)
			result[i] += sample[i-1+j]*coeff[j];
		result[i]/=norm;
	}
	result[n-1] = sample[n-1];
}

int main(int argc, char *arvg[])
{
	int i;

	if (N_SAMPLES>=N_COEFFS)
		smooth(sample, coeff, result, N_SAMPLES);

	for (i=0; i<N_SAMPLES; i++)
		printf("%f\n", result[i]);
}
