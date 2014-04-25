#include <CUnit/Basic.h>
#include <CUnit/Console.h>
#include <CUnit/Automated.h>
#include "../src/linear/matrix.h"

static c_matrix *m = NULL;

int init_matrix_suite(void) { 
	m = new_c_matrix(2, 4);
	if(NULL == m)
		return -1;
	else
		return 0;
}

int clean_matrix_suite(void) {
	del_c_matrix(m);
	return 0;
}

void test_matrix_initialize() {
	/*	we're going to start checking if the size is properly
		set, as there is no data */
	CU_ASSERT(2 == m->n);
	CU_ASSERT(4 == m->m);
}

void test_matrix_set() {
	c_matrix_set(m, 1, 1, 2.0);
	CU_ASSERT(2.0 == m->data[0]);
}

void test_matrix_zeros() {
	zeros(m);
	int i;
	for(i = 0; i < 8; ++i)
		CU_ASSERT(0.0 == m->data[i]);
}

void test_matrix_ones() {
	ones(m);
	int i;
	for(i = 0; i < 8; ++i)
		CU_ASSERT(1.0 == m->data[i]);
}

void test_matrix_add() {
	ones(m);
	c_matrix_add(m, m, m);
	int i;
	for(i = 0; i < 8; ++i)
		CU_ASSERT_DOUBLE_EQUAL(2.0, m->data[i], 0.000000000001);
}

int main() {
	CU_pSuite pSuite = NULL;

	/* initialize the CUnit test registry */
	if (CUE_SUCCESS != CU_initialize_registry())
		return CU_get_error();

	/* add a test suite to the registry */
	pSuite = CU_add_suite("Matrix_suite", init_matrix_suite, clean_matrix_suite);
	if (NULL == pSuite) {
		CU_cleanup_registry();
		return CU_get_error();
	}

	/* add the tests to the suite */
	if((NULL == CU_add_test(pSuite, "Test matrix initializion", test_matrix_initialize)) || 
		(NULL == CU_add_test(pSuite, "Test matrix set", test_matrix_set)) ||
		(NULL == CU_add_test(pSuite, "Test matrix zeros", test_matrix_zeros)) ||
		(NULL == CU_add_test(pSuite, "Test matrix ones", test_matrix_ones)) ||
		(NULL == CU_add_test(pSuite, "Test matrix addition", test_matrix_add))) {
		CU_cleanup_registry();
		return CU_get_error();
	}

	CU_basic_set_mode(CU_BRM_VERBOSE);
	CU_basic_run_tests();
	printf("\n");
	CU_basic_show_failures(CU_get_failure_list());

	/* clean up registry and return */
	CU_cleanup_registry();
	return CU_get_error();
}