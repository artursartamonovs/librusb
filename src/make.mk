DIR=src

SRC_UTILS_PRE   += $(wildcard $(DIR)/os/*.c)
SRC_UTILS       += $(wildcard $(DIR)/*.c)
SRC_UTILS_PRE_L += $(wildcard $(DIR)/os/linux/*.c)
SRC_UTILS_PRE_M =  $(wildcard $(DIR)/os/macos/*.c)
OBJ_UTILS       += $(SRC_UTILS:.c=.o)
OBJ_UTILS_PRE   += $(SRC_UTILS_PRE:.c=.o)
OBJ_UTILS_PRE_M += $(SRC_UTILS_PRE_M:.c=.o)
OBJ_UTILS_PRE_L += $(SRC_UTILS_PRE_L:.c=.o)
LDFLAGS_UTILS   = 
INCLUDE         = -I./include -I./src
CFLAGS          = -fPIC

build-src: src-pre
	echo "Hello"
	echo $(SRC_UTILS_PRE)
	echo $(SRC_UTILS)



build-src-macos: print src-pre-macos
	echo "Build macos"

print:
	echo "$(OBJ_UTILS_PRE)"
	echo "$(OBJ_UTILS_PRE_M)"
	echo "$(OBJ_UTILS)"

$(DIR)-pre-macos: $(OBJ_UTILS_PRE) $(OBJ_UTILS_PRE_M) $(OBJ_UTILS)
	echo "here 2"

$(DIR)-pre: $(OBJ_UTILS_PRE) $(OBJ_UTILS_PRE_L) $(OBJ_UTILS)
	echo "here 1"

$(DIR)/os/%.o: $(DIR)/os/%.c
	echo "A"
	$(CC)  $(CFLAGS) $(INCLUDE) -c $< -o $(BUILD_DIR)$@

$(DIR)/%.o:  $(DIR)/%.c
	echo "B"
	$(CC) $(CFLAGS) $(INCLUDE)  -c $< -o $(BUILD_DIR)$@ $(LDFLAGS_UTILS) 