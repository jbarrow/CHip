all: clean CHip

scripting.o: src/scripting/scripting.c
	gcc -c src/scripting/scripting.c -g -llua -lliblua

matrix.o: src/linear/matrix.cu
	nvcc -c src/linear/matrix.cu -arch=sm_21 -g

vector.o: src/linear/vector.cu
	nvcc -c src/linear/vector.cu -arch=sm_21 -g

CHip.o: src/CHip.c
	clang -c src/CHip.c -g

CHip: CHip.o vector.o matrix.o scripting.o
	nvcc -g CHip.o vector.o matrix.o scripting.o -arch=sm_21 -lcudart -O3 -o CHip -llua

clean:
	rm -f CHip *.o