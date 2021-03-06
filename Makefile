OPENRESTY_PREFIX=/usr/local/openresty

LUA_INCLUDE_DIR ?= $(OPENRESTY_PREFIX)/include
LUA_LIB_DIR ?=     $(OPENRESTY_PREFIX)/lualib
INSTALL ?= install

CMPFLAG       = -c -fPIC
LINKFLAG      = -shared
.PHONY: all test install clean

all: lib/libredis_slot.so

clean:
	rm -rf lib/*.so lib/*.o

lib/redis_slot.o:lib/redis_slot.c
	$(CC) $(CMPFLAG) -o $@ $^

lib/libredis_slot.so:lib/redis_slot.o
	$(CC) $(LINKFLAG) -o $@ $^

install: all
	$(INSTALL) -d $(LUA_LIB_DIR)/resty
	$(INSTALL) lib/resty/*.lua $(LUA_LIB_DIR)/resty
	$(INSTALL) lib/libredis_slot.so $(LUA_LIB_DIR)/libredis_slot.so

test: all
	PATH=$(OPENRESTY_PREFIX)/nginx/sbin:$$PATH prove -I../test-nginx/lib -r t

