
# ディレクトリ定義
SRC_DIR 		= src
MAIN_BODY_DIR 	= main_body
USERLIB_DIR 	= FookFunctionFolder
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
# 共通フラグ
COMMON_CFLAGS 		= -I$(SRC_DIR) -I$(MAIN_BODY_DIR) -I$(USERLIB_DIR) $(SHELL_ARGS)

# srcディレクトリ用
SRC_CC 				= gcc
SRC_CXX 			= g++
SRC_CFLAGS 			= -O0 -Wall
SRC_CXXFLAGS 		= -O0 -Wall -lpthread -lm

# main_bodyディレクトリ用
MAIN_BODY_CC 		= gcc
MAIN_BODY_CXX 		= g++
MAIN_BODY_CFLAGS 	= -O3 -shared -fPIC -ldl
MAIN_BODY_CXXFLAGS 	= -O3 -shared -fPIC -ldl

# userlibディレクトリ用
USERLIB_CC 			= gcc
USERLIB_CXX 		= g++
USERLIB_CFLAGS 		= -O3 -Wall -shared -fPIC -ldl
USERLIB_CXXFLAGS 	= -O3 -Wall -shared -fPIC -ldl

# リンカフラグ
LDFLAGS = -lpthread -lm -ldl

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

# 実行ファイル作成 (USERLIB_SOはリンクしない)
$(TARGET): $(ALL_OBJS) $(MAIN_BODY_SO) | $(BIN_DIR)
	g++ -o $@ $(ALL_OBJS) $(MAIN_BODY_SO) $(LDFLAGS)

# 動的ライブラリ作成
$(MAIN_BODY_SO): $(MAIN_BODY_C_OBJS) $(MAIN_BODY_CPP_OBJS) | $(BIN_DIR)
	g++ -shared -o $@ $(MAIN_BODY_C_OBJS) $(MAIN_BODY_CPP_OBJS) $(LDFLAGS)

$(USERLIB_SO): $(USERLIB_C_OBJS) $(USERLIB_CPP_OBJS) | $(BIN_DIR)
	g++ -shared -o $@ $(USERLIB_C_OBJS) $(USERLIB_CPP_OBJS) $(LDFLAGS)

# srcディレクトリのCファイルコンパイル
$(SRC_OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(SRC_OBJ_DIR)
	$(SRC_CC) $(COMMON_CFLAGS) $(SRC_CFLAGS) -c $< -o $@

# srcディレクトリのC++ファイルコンパイル
$(SRC_OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp | $(SRC_OBJ_DIR)
	$(SRC_CXX) $(COMMON_CFLAGS) $(SRC_CXXFLAGS) -c $< -o $@

# main_bodyディレクトリのCファイルコンパイル
$(MAIN_BODY_OBJ_DIR)/%.o: $(MAIN_BODY_DIR)/%.c | $(MAIN_BODY_OBJ_DIR)
	$(MAIN_BODY_CC) $(COMMON_CFLAGS) $(MAIN_BODY_CFLAGS) -c $< -o $@

# main_bodyディレクトリのC++ファイルコンパイル
$(MAIN_BODY_OBJ_DIR)/%.o: $(MAIN_BODY_DIR)/%.cpp | $(MAIN_BODY_OBJ_DIR)
	$(MAIN_BODY_CXX) $(COMMON_CFLAGS) $(MAIN_BODY_CXXFLAGS) -c $< -o $@

# userlibディレクトリのCファイルコンパイル
$(USERLIB_OBJ_DIR)/%.o: $(USERLIB_DIR)/%.c | $(USERLIB_OBJ_DIR)
	$(USERLIB_CC) $(COMMON_CFLAGS) $(USERLIB_CFLAGS) -c $< -o $@

# userlibディレクトリのC++ファイルコンパイル
$(USERLIB_OBJ_DIR)/%.o: $(USERLIB_DIR)/%.cpp | $(USERLIB_OBJ_DIR)
	$(USERLIB_CXX) $(COMMON_CFLAGS) $(USERLIB_CXXFLAGS) -c $< -o $@

# ディレクトリ作成
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(SRC_OBJ_DIR): | $(OBJ_DIR)
	mkdir -p $(SRC_OBJ_DIR)

$(MAIN_BODY_OBJ_DIR): | $(OBJ_DIR)
	mkdir -p $(MAIN_BODY_OBJ_DIR)

$(USERLIB_OBJ_DIR): | $(OBJ_DIR)
	mkdir -p $(USERLIB_OBJ_DIR)

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

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