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
	CU_ASSERT(2 == m->n);
	CU_ASSERT(4 == m->m);
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
	if((NULL == CU_add_test(pSuite, "Test_matrix_initialize", test_matrix_initialize))) {
		CU_cleanup_registry();
		return CU_get_error();
	}

	CU_basic_set_mode(CU_BRM_VERBOSE);
	CU_basic_run_tests();
	printf("\n");
	CU_basic_show_failures(CU_get_failure_list());
	printf("\n\n");

	/* clean up registry and return */
	CU_cleanup_registry();
	return CU_get_error();
}