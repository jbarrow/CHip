CC=clang
TARGET=chip_test
FLAGS=-DTEST

all: default

matrix.o: ../src/linear/matrix.cu
	nvcc -c ../src/linear/matrix.cu -arch=sm_21

vector.o: ../src/linear/vector.cu
	nvcc -c ../src/linear/vector.cu -arch=sm_21

test_matrix.o: test_matrix.c
	clang -c test_matrix.c

default: vector.o matrix.o test_matrix.o
	nvcc test_matrix.o vector.o matrix.o -arch=sm_21 -lcudart -lcunit -O3 -o $(TARGET)
	./$(TARGET)

clean:
	rm -f *.o rm -f $(TARGET)