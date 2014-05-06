#ifndef SCRIPTING_H
#define SCRIPTING_H

#include "lua.h"
#include "lualib.h"

void report_errors(lua_State *L, int status);

#endif