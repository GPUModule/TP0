#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "utils.h"

#define N 16 //width
#define M 16 //height
#define THREADS_PER_BLOCK 256
#define SQRT_THREADS_PER_BLOCK sqrt(THREADS_PER_BLOCK)

void checkCUDAError(const char*);
void random_floats(float *a);
void MatMulCPU(float *a, float *b, float *c);
int validate(float *a, float *ref);


__global__ void MatMulKernel(float *a, float *b, float *c) {
	// A completer
}



int main(void) {
	srand( time( NULL ) );

	float *a, *b, *c, *c_ref;		// host copies of a, b, c
	float *d_a, *d_b, *d_c;			// device copies of a, b, c
	int errors;
	unsigned int size = N * M * sizeof(float);

	// Alloc space for device copies of a, b, c
	// A completer
	//cudaMalloc
	//cudaMalloc
	//cudaMalloc
	checkCUDAError("CUDA malloc");

	// Alloc space for host copies of a, b, c and setup input values
	// A completer
	// a = 
	// b =
	// c =
	// c_ref =

	// Copy inputs to device
	// A completer
	//cudaMemcpy
	//cudaMemcpy
	checkCUDAError("CUDA memcpy");

	// Launch add() kernel on GPU
	//unsigned int block_width = 
	//unsigned int grid_width = 
	//unsigned int grid_height = 
	//dim3 blocksPerGrid(grid_width, grid_height);
	//dim3 threadsPerBlock(block_width, block_width);
	MatMulKernel << <blocksPerGrid, threadsPerBlock >> >(d_a, d_b, d_c);
	checkCUDAError("CUDA kernel");

	//perform CPU version
	MatMulCPU(a, b, c_ref);


	// Copy result back to host
	// A completer
	// cudaMemcpy
	checkCUDAError("CUDA memcpy");

	// validate
	errors = validate(c, c_ref);
	printf("CUDA GPU result has %d errors.\n", errors);



	// Cleanup
	free(a); free(b); free(c);
	cudaFree(d_a); cudaFree(d_b); cudaFree(d_c);
	checkCUDAError("CUDA cleanup");

	return 0;
}

void checkCUDAError(const char *msg)
{
	cudaError_t err = cudaGetLastError();
	if (cudaSuccess != err)
	{
		fprintf(stderr, "CUDA ERROR: %s: %s.\n", msg, cudaGetErrorString(err));
		exit(EXIT_FAILURE);
	}
}

void random_floats(float *a)
{
	for (unsigned int x = 0; x < N; x++){
		for (unsigned int y = 0; y < M; y++){
			a[(y*N) + x] = (float)(rand() % 101);
		}
	}
}

void MatMulCPU(float *a, float *b, float *c)
{
	// A completer
}

int validate(float *a, float *ref){
	int errors = 0;
	for (unsigned int x = 0; x < N; x++){
		for (unsigned int y = 0; y < M; y++){
			int i = (y*N) + x;
			if (a[i] != ref[i]){
				errors++;
				fprintf(stderr, "ERROR at index %d: GPU result %f does not match CPU value of %f\n", i, a[i], ref[i]);
			}
		}
	}

	return errors;
}