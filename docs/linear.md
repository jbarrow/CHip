Linear
------

The linear package of CHip is the core of the entire application. The majority of the library is centered around matrices that store doubles, including the vector implementations -- vectors are either row or column vectors, and are treated like matrices. This cuts down on much of the complexity required.

The following functions are defined:

    c_matrix *new_c_matrix(int i, int j);

    void del_c_matrix(c_matrix* m);

    double c_matrix_get(c_matrix *m, int i, int j);

    void c_matrix_set(c_matrix *m, int i, int j, double val);

    void zeros(c_matrix* m);

    void ones(c_matrix* m);

    void c_matrix_rand(c_matrix* m, double a, double b);

    void c_matrix_dist(c_matrix* m, double (*init)());

    void c_matrix_add(const c_matrix* m1, const c_matrix* m2, c_matrix* m);

    void c_matrix_sub(const c_matrix* m1, const c_matrix* m2, c_matrix* m);

    void c_matrix_mul(const c_matrix* m1, const c_matrix* m2, c_matrix* m);

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