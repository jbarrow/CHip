all: clean CHip

matrix.o: src/linear/matrix.cu
	nvcc -c src/linear/matrix.cu -arch=sm_21

vector.o: src/linear/vector.cu
	nvcc -c src/linear/vector.cu -arch=sm_21

CHip.o: src/CHip.c
	clang -c src/CHip.c

CHip: CHip.o vector.o matrix.o
	nvcc CHip.o vector.o matrix.o -arch=sm_21 -lcudart -O3 -o CHip

clean:
	rm -f CHip *.o