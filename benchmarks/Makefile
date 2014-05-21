CC=clang
TARGET=chip_benchmark

all: default

logger.o: ../src/logger.c
	$(CC) -c ../src/logger.c

matrix.o: ../src/linear/matrix.cu logger.o
	nvcc -c ../src/linear/matrix.cu -arch=sm_21

vector.o: ../src/linear/vector.cu
	nvcc -c ../src/linear/vector.cu -arch=sm_21

benchmark.o: benchmark.cu
	nvcc -c benchmark.cu -arch=sm_21

default: vector.o matrix.o benchmark.o
	nvcc benchmark.o logger.o vector.o matrix.o -arch=sm_21 -lcudart -lcunit -O3 -o $(TARGET)
	./$(TARGET)

clean:
	rm -f *.o $(TARGET) *.csv *.log