include ../skynet/platform.mk

CC ?= gcc

SHARED := -fPIC --shared

LUA_CLIB_PATH ?= ../luaclib
SKYNET_BUILD_PATH ?= ../skynet

CFLAGS = -g -O2 -Wall -I$(LUA_INC) 

LUA_STATICLIB := ../skynet/3rd/lua/liblua.a
LUA_LIB ?= $(LUA_STATICLIB)
LUA_INC ?= ../skynet/3rd/lua


LUA_CLIB = cjson

all	: $(LUA_CLIB_PATH)/cjson.so

$(LUA_CLIB_PATH)/cjson.so : lua-cjson/fpconv.c lua-cjson/strbuf.c lua-cjson/lua_cjson.c | $(LUA_CLIB_PATH)
	$(CC) $(CFLAGS) $(SHARED) -Ilua-cjson $^ -o $@

clean :
	rm -f $(LUA_CLIB_PATH)/*.so
