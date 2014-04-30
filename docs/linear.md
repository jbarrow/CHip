Linear
------

The linear package of CHip is the core of the entire application. The majority of the library is centered around matrices that store doubles, including the vector implementations -- vectors are either row or column vectors, and are treated like matrices. This cuts down on much of the complexity required.

The following functions are defined:

    c_matrix *new_c_matrix(int i, int j);

This creates and allocates the memory for a new 2-dimensional matrix with i rows and j columns, and returns a pointer to that memory.

    void del_c_matrix(c_matrix* m);

The counterpart to creating a matrix, this deallocates all the memory used in its creation.

    double c_matrix_get(c_matrix *m, int i, int j);

Used to get the element found at the ith row and jth column of the matrix. 

An implementation idea is to be able to select more than one element with the get method.

    void c_matrix_set(c_matrix *m, int i, int j, double val);

Used to set or update the matrix element found at the ith row and jth column.

    void zeros(c_matrix* m);

Zero out a pre-allocated matrix.

    void ones(c_matrix* m);

Fill an allocated matrix with all ones.

    void c_matrix_rand(c_matrix* m, double a, double b);

Fill an allocated matrix with random values defined on the interval (a, b).

    void c_matrix_dist(c_matrix* m, double (*init)());

Fill an allocated matrix with random values pulled from a specified distribution. The distribution can be specified by passing in a function pointer that returns a double and takes no arguments.

    void c_matrix_add(const c_matrix* m1, const c_matrix* m2, c_matrix* m);

An element-wise add for two matrices that adds m1 and m2, and stores them in a third, pre-allocated, matrix. Handles size checking to ensure m1 and m2 are the same size.

    void c_matrix_sub(const c_matrix* m1, const c_matrix* m2, c_matrix* m);

Element-wise subtraction for two matrices, with the result stored in a third. Handles size checking to ensure m1 and m2 are the same size.

    void c_matrix_mul(const c_matrix* m1, const c_matrix* m2, c_matrix* m);

Matrix multiplication of two matrices, with an element stored in the third. Automatically handles size checking for matrix multiplication.

    void c_element_mul(const c_matrix *m1, const c_matrix *m2, c_matrix *m);

    void c_element_div(const c_matrix *m1, const c_matrix *m2, c_matrix *m);

    void c_scalar_add(const c_matrix* m, double d, c_matrix* m_dest);

    void c_scalar_mul(const c_matrix* m, double d, c_matrix* m_dest);

    void c_matrix_transpose(const c_matrix* m, c_matrix* m_prime);

    c_matrix* new_c_vector(int size);

    void del_c_matrix(c_matrix* m);

    double c_vector_get(c_matrix* m, int i);

    void c_vector_set(c_matrix* m, int i, double value);

    int check_vector(c_matrix* m);

    double c_dot_product(const c_matrix* v1, const c_matrix* v2);

As I finish implementing each of these, I'll add specific details to the documentation.