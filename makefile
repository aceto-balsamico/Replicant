
# ディレクトリ定義
SRC_DIR 		= src
MAIN_BODY_DIR 	= main_body
USERLIB_DIR 	= HookFunctionFolder
OBJ_DIR 		= obj
BIN_DIR 		= bin
SHELL_ARGS 		= 

# 出力ファイル名
TARGET 				= $(BIN_DIR)/MainExe

# サブディレクトリ作成
SRC_OBJ_DIR 		= $(OBJ_DIR)/$(SRC_DIR)
MAIN_BODY_OBJ_DIR 	= $(OBJ_DIR)/$(MAIN_BODY_DIR)
USERLIB_OBJ_DIR 	= $(OBJ_DIR)/$(USERLIB_DIR)

# コンパイラとフラグ設定
# 共通コンパイルフラグ
COMMON_CFLAGS 		= -I$(SRC_DIR) -I$(MAIN_BODY_DIR) -I$(USERLIB_DIR) $(SHELL_ARGS)

# srcディレクトリ用
SRC_CC 				= gcc
SRC_CXX 			= g++
SRC_CFLAGS 			= -O0 -Wall
SRC_CXXFLAGS 		= -O0 -Wall

# main_bodyディレクトリ用
MAIN_BODY_CC 		= gcc
MAIN_BODY_CXX 		= g++
MAIN_BODY_CFLAGS 	= -Wall -O0 -fPIC
MAIN_BODY_CXXFLAGS 	= -Wall -O0 -fPIC

# userlibディレクトリ用
USERLIB_CC 			= gcc
USERLIB_CXX 		= g++
USERLIB_CFLAGS 		= -Wall -O0 -fPIC
USERLIB_CXXFLAGS 	= -Wall -O0 -fPIC

# リンカフラグ
LDFLAGS = -lpthread -lm -ldl
SOFLAGS = -shared $(LDFLAGS)

# ソースファイル検索
SRC_C_FILES 			= $(wildcard $(SRC_DIR)/*.c)
SRC_CPP_FILES 			= $(wildcard $(SRC_DIR)/*.cpp)
MAIN_BODY_C_FILES 		= $(wildcard $(MAIN_BODY_DIR)/*.c)
MAIN_BODY_CPP_FILES 	= $(wildcard $(MAIN_BODY_DIR)/*.cpp)
USERLIB_C_FILES 		= $(wildcard $(USERLIB_DIR)/*.c)
USERLIB_CPP_FILES 		= $(wildcard $(USERLIB_DIR)/*.cpp)

# オブジェクトファイル定義
SRC_C_OBJS 				= $(SRC_C_FILES:$(SRC_DIR)/%.c=$(SRC_OBJ_DIR)/%.o)
SRC_CPP_OBJS 			= $(SRC_CPP_FILES:$(SRC_DIR)/%.cpp=$(SRC_OBJ_DIR)/%.o)
MAIN_BODY_C_OBJS 		= $(MAIN_BODY_C_FILES:$(MAIN_BODY_DIR)/%.c=$(MAIN_BODY_OBJ_DIR)/%.o)
MAIN_BODY_CPP_OBJS 		= $(MAIN_BODY_CPP_FILES:$(MAIN_BODY_DIR)/%.cpp=$(MAIN_BODY_OBJ_DIR)/%.o)
USERLIB_C_OBJS 			= $(USERLIB_C_FILES:$(USERLIB_DIR)/%.c=$(USERLIB_OBJ_DIR)/%.o)
USERLIB_CPP_OBJS 		= $(USERLIB_CPP_FILES:$(USERLIB_DIR)/%.cpp=$(USERLIB_OBJ_DIR)/%.o)

# 動的ライブラリ定義
MAIN_BODY_SO 			= $(BIN_DIR)/libmain_body.so
USERLIB_SO				= $(BIN_DIR)/libuserlib.so

# 全オブジェクトファイル
ALL_OBJS = $(SRC_C_OBJS) $(SRC_CPP_OBJS)

.PHONY: all clean lib

all: $(TARGET)

lib: $(USERLIB_SO)

# 実行ファイル作成 (オブジェクトファイルとMAIN_BODY.SOのリンク。USERLIB_SOはリンクしない)
$(TARGET): $(ALL_OBJS) $(MAIN_BODY_SO) | $(BIN_DIR)
	@echo "\033[34mExecutable Linking...\033[0m"
	g++ -o $@ $(ALL_OBJS) $(MAIN_BODY_SO) $(LDFLAGS)

# MainBody.so 動的ライブラリ作成(リンク)
$(MAIN_BODY_SO): $(MAIN_BODY_C_OBJS) $(MAIN_BODY_CPP_OBJS) | $(BIN_DIR)
	@echo "\033[34mShared Object Creation...\033[0m"
	g++ -o $@ $(MAIN_BODY_C_OBJS) $(MAIN_BODY_CPP_OBJS) $(SOFLAGS)
# Userlib.so 動的ライブラリ作成(リンク)
$(USERLIB_SO): $(USERLIB_C_OBJS) $(USERLIB_CPP_OBJS) | $(BIN_DIR)
	@echo "\033[34mShared Object Creation...\033[0m"
	g++ -o $@ $(USERLIB_C_OBJS) $(USERLIB_CPP_OBJS) $(SOFLAGS)

# srcディレクトリのCファイルコンパイル
$(SRC_OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(SRC_OBJ_DIR)
	$(SRC_CC) $(SRC_CFLAGS) $(COMMON_CFLAGS) -c $< -o $@

# srcディレクトリのC++ファイルコンパイル
$(SRC_OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp | $(SRC_OBJ_DIR)
	$(SRC_CXX) $(SRC_CXXFLAGS) $(COMMON_CFLAGS) -c $< -o $@

# main_bodyディレクトリのCファイルコンパイル
$(MAIN_BODY_OBJ_DIR)/%.o: $(MAIN_BODY_DIR)/%.c | $(MAIN_BODY_OBJ_DIR)
	$(MAIN_BODY_CC) $(MAIN_BODY_CFLAGS) $(COMMON_CFLAGS) -c $< -o $@

# main_bodyディレクトリのC++ファイルコンパイル
$(MAIN_BODY_OBJ_DIR)/%.o: $(MAIN_BODY_DIR)/%.cpp | $(MAIN_BODY_OBJ_DIR)
	$(MAIN_BODY_CXX) $(MAIN_BODY_CXXFLAGS) $(COMMON_CFLAGS) -c $< -o $@

# userlibディレクトリのCファイルコンパイル
$(USERLIB_OBJ_DIR)/%.o: $(USERLIB_DIR)/%.c | $(USERLIB_OBJ_DIR)
	$(USERLIB_CC) $(USERLIB_CFLAGS) $(COMMON_CFLAGS) -c $< -o $@

# userlibディレクトリのC++ファイルコンパイル
$(USERLIB_OBJ_DIR)/%.o: $(USERLIB_DIR)/%.cpp | $(USERLIB_OBJ_DIR)
	$(USERLIB_CXX) $(USERLIB_CXXFLAGS) $(COMMON_CFLAGS) -c $< -o $@

# ディレクトリ作成
$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR) > /dev/null 2>&1

$(SRC_OBJ_DIR): | $(OBJ_DIR)
	@mkdir -p $(SRC_OBJ_DIR) > /dev/null 2>&1

$(MAIN_BODY_OBJ_DIR): | $(OBJ_DIR)
	@mkdir -p $(MAIN_BODY_OBJ_DIR) > /dev/null 2>&1

$(USERLIB_OBJ_DIR): | $(OBJ_DIR)
	@mkdir -p $(USERLIB_OBJ_DIR) > /dev/null 2>&1

$(BIN_DIR):
	@mkdir -p $(BIN_DIR) > /dev/null 2>&1

# クリーンアップ
clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)

# デバッグ用：変数表示
debug:
	@echo "SRC_C_FILES: $(SRC_C_FILES)"
	@echo "SRC_CPP_FILES: $(SRC_CPP_FILES)"
	@echo "MAIN_BODY_C_FILES: $(MAIN_BODY_C_FILES)"
	@echo "MAIN_BODY_CPP_FILES: $(MAIN_BODY_CPP_FILES)"
	@echo "USERLIB_C_FILES: $(USERLIB_C_FILES)"
	@echo "USERLIB_CPP_FILES: $(USERLIB_CPP_FILES)"
	@echo "ALL_OBJS: $(ALL_OBJS)"
	@echo "MAIN_BODY_SO: $(MAIN_BODY_SO)"