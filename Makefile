CPP_COMPILER=g++
C_COMPILER=gcc

COMMON_CFLAGS=-Wall -Wextra -Werror -pedantic

DEBUG_CFLAGS=-g
OPT_CFLAGS=-DNDEBUG -O2

C_CFLAGS=$(COMMON_CFLAGS) -std=c99
CPP03_CFLAGS=$(COMMON_CFLAGS) -std=c++98
CPP11_CFLAGS=$(COMMON_CFLAGS) -std=c++11 -DGHEAP_CPP11

BUILD_DIR=build

all: tests perftests ops_count_test

.PHONY: build_dir build-tests build-perftests build-ops_count_test clean

build_dir:
	mkdir -p build

build-tests: build_dir
	$(C_COMPILER) tests.c $(C_CFLAGS) $(DEBUG_CFLAGS) -o ${BUILD_DIR}/tests_c
	$(CPP_COMPILER) tests.cpp $(CPP03_CFLAGS) $(DEBUG_CFLAGS) -o ${BUILD_DIR}/tests_cpp03
	$(CPP_COMPILER) tests.cpp $(CPP11_CFLAGS) $(DEBUG_CFLAGS) -o ${BUILD_DIR}/tests_cpp11

tests: build-tests
	${BUILD_DIR}/tests_c
	${BUILD_DIR}/tests_cpp03
	${BUILD_DIR}/tests_cpp11

build-perftests: build_dir
	$(C_COMPILER) perftests.c $(C_CFLAGS) $(OPT_CFLAGS) -o ${BUILD_DIR}/perftests_c
	$(CPP_COMPILER) perftests.cpp $(CPP03_CFLAGS) $(OPT_CFLAGS) -o ${BUILD_DIR}/perftests_cpp03
	$(CPP_COMPILER) perftests.cpp $(CPP11_CFLAGS) $(OPT_CFLAGS) -o ${BUILD_DIR}/perftests_cpp11

perftests: build-perftests
	${BUILD_DIR}/perftests_c
	${BUILD_DIR}/perftests_cpp03
	${BUILD_DIR}/perftests_cpp11

build-ops_count_test: build_dir
	$(CPP_COMPILER) ops_count_test.cpp $(CPP03_CFLAGS) $(OPT_CFLAGS) -o ${BUILD_DIR}/ops_count_test_cpp03
	$(CPP_COMPILER) ops_count_test.cpp $(CPP11_CFLAGS) $(OPT_CFLAGS) -o ${BUILD_DIR}/ops_count_test_cpp11

ops_count_test: build-ops_count_test
	${BUILD_DIR}/ops_count_test_cpp03
	${BUILD_DIR}/ops_count_test_cpp11

clean:
	rm -r ${BUILD_DIR}
