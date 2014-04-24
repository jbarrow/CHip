#include <CUnit/Basic.h>
#include <CUnit/Console.h>
#include <CUnit/Automated.h>

int init_suite_success(void) { return 0; }
int init_suite_failure(void) { return -1; }
int clean_suite_success(void) { return 0; }
int clean_suite_failure(void) { return -1; }

void test_success1(void)
{
	CU_ASSERT(1);
}

int main() {
	CU_pSuite pSuite = NULL;

	/* initialize the CUnit test registry */
	if (CUE_SUCCESS != CU_initialize_registry())
		return CU_get_error();

	/* add a test suite to the registry */
	pSuite = CU_add_suite("Suite_success", init_suite_success, clean_suite_success);
	if (NULL == pSuite) {
		CU_cleanup_registry();
		return CU_get_error();
	}

	/* add the tests to the suite */
	if((NULL == CU_add_test(pSuite, "successful_test_1", test_success1))) {
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