#include <stdio.h>
#include <stdlib.h>
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"
#include "linear/matrix.h"
#include "scripting/scripting.h"

/*
 *	The entry point for CHip. Files will be loaded in
 *	through the command line and parsed out to run
 *	a script/implementation.
 */
int main(int argc, char** argv) {
	int n;
	for(n = 1; n < argc; ++n) {
		const char *file = argv[n];

		lua_State *L = lua_open();   /* opens Lua */
		luaL_openlibs(L);

		printf("-- Loading file: %s\n", file);

		int s = luaL_loadfile(L, file);

		if( s == 0 ) {
			s = lua_pcall(L, 0, LUA_MULTRET, 0);
		}

		report_errors(L, s);
		lua_close(L);
	}

	return 0;
}