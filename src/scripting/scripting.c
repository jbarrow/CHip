#include "scripting.h"
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"
#include <stdlib.h>
#include <stdio.h>

void report_errors(lua_State *L, int status) {
	if( status != 0 ) {
		printf("-- ");
		fprintf(stderr, "%s", lua_tostring(L, -1));
		printf(" \n");
		lua_pop(L, 1);
		exit(-1);
	}
}