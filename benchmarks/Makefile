CC=clang
TARGET=chip_benchmark

all: default

matrix.o: ../src/linear/matrix.cu
	nvcc -c ../src/linear/matrix.cu -arch=sm_21

vector.o: ../src/linear/vector.cu
	nvcc -c ../src/linear/vector.cu -arch=sm_21

benchmark.o: benchmark.c
	clang -c benchmark.c

default: vector.o matrix.o benchmark.o
	nvcc benchmark.o vector.o matrix.o -arch=sm_21 -lcudart -lcunit -O3 -o $(TARGET)
	./$(TARGET)

clean:
	rm -f *.o rm -f $(TARGET)