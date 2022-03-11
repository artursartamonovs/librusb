PROJECT=rusb
CC=gcc
CFLAGS=
INCLUDE=-I./include 
LDFLAGS=
LDFLAGS_LIB=

CC=gcc
AR=ar
SOURCES=
SRC_LIB=
OBJ_LIB=
SRC_OS=
OBJ_OS=

BUILD_DIR=build/

OS=linux
include src/make.mk 

SOURCES+=$(wildcard src/*.c)
SOURCES+=$(wildcard src/os/*.c)
OBJECTS_=$(addprefix $(BUILD_DIR),$(SOURCES))
OBJECTS=$(OBJECTS_:.c=.o)

#%.o: %.c
#	echo "Main"
#	$(CC) $(CFLAGS) $(INCLUDE) -c $< -o $(BUILD_DIR)$@

linux: build-src
	echo "end"
	#echo $(SOURCES)
	#echo $(OBJECTS)
	$(CC) -shared -Wl,-soname,lib$(PROJECT).so -o lib$(PROJECT).so $(OBJECTS) $(LDFLAGS_LIB) 
	$(AR) rcv lib$(PROJECT).a $(OBJECTS)

macos: build-src-macos
	echo "Starting here"
	$(CC) -v -dynamiclib -undefined suppress -flat_namespace -o lib$(PROJECT).dylib  $(OBJECTS) $(LDFLAGS_LIB) 
	$(AR) rcv lib$(PROJECT).a $(OBJECTS)

clean:
	rm -rfv $(BUILD_DIR)/src/*.o
	rm -rfv $(BUILD_DIR)/src/os/*.o
