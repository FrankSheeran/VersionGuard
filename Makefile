################################################################################
#
# VersionGuard -- demo Makefile
#
# For details and legal information please see the accompanying
# VersionGuard document and LICENSE file.
#
# This first section includes the Makefile code related to VersionGuard.
#
################################################################################

all::

DISTRIBUTION := vgdemo
VERSION      := 1.0.1
DISTRIBUTION_NAME := $(DISTRIBUTION).$(VERSION)

.PHONY: checkversion

# Perl script variables: $v is version, $b is before, $a is after, $c is changed, $m is message
checkversion:
	if perl -e '$$v="i$(DISTRIBUTION_NAME)"; $$v=~s/\W/_/g;for(@ARGV){$$b=$$a=`cat $$_`;$$a=~s/\w+(\s*\/\*Edited by Make\*\/)/$$v$$1/g;$$m="up-to-date";if($$a ne$$b){$$c=1;$$m="REGENERATING";open(C, ">$$_")||die;print C $$a;close C||die}print"  > $$m: $$_\n"}exit !$$c' VersionGuard.cpp VersionGuard.h; then \
	  printf "\n  > VERSION UPDATED. Re-starting make.\n\n"; \
	  $(MAKE) $(MAKEFLAGS); \
	  exit 0;\
        fi



################################################################################
#
# The following is simply to make the demo run, hasn't been extensively tested,
# and shouldn't be used as an example of how to write a Makefile.
#
################################################################################

# Compiler and flags
CXX := g++
CXXFLAGS := -Wall -Wextra -g -fPIC -I.
#CXXFLAGS := -Wall -Wextra -g -fPIC -I. -L/usr/lib64
AR := ar
ARFLAGS := rcs

# Directories
DISTRIBUTION_DIR := $(DISTRIBUTION_NAME)
LIB_DIR := $(DISTRIBUTION_DIR)/lib
BIN_DIR := $(DISTRIBUTION_DIR)/bin

# Sources
HELLOLIB_SRC := hellolib.cpp VersionGuard.cpp
HELLO_SRC := main.cpp

# Targets
STATIC_LIB := $(LIB_DIR)/libhellolib.a
DYNAMIC_LIB := $(LIB_DIR)/libhellolib.so
STATIC_BIN := $(BIN_DIR)/hello_static
DYNAMIC_BIN := $(BIN_DIR)/hello_dynamic

# Build rules
all:: checkversion $(STATIC_LIB) $(DYNAMIC_LIB) $(STATIC_BIN) $(DYNAMIC_BIN)

# Create output directories
$(LIB_DIR) $(BIN_DIR):
	mkdir -p $@

# Compile static library
$(STATIC_LIB): $(HELLOLIB_SRC) | $(LIB_DIR)
	$(CXX) $(CXXFLAGS) -c $(HELLOLIB_SRC)
	$(AR) $(ARFLAGS) $@ $(HELLOLIB_SRC:.cpp=.o)
#	rm -f *.o

# Compile dynamic library
$(DYNAMIC_LIB): $(HELLOLIB_SRC) | $(LIB_DIR)
	$(CXX) $(CXXFLAGS) -shared -o $@ $(HELLOLIB_SRC)

# Compile binary linked to static library
$(STATIC_BIN): $(HELLO_SRC) $(STATIC_LIB) | $(BIN_DIR)
	$(CXX) $(CXXFLAGS) -o $@ $(HELLO_SRC) $(STATIC_LIB)
#	$(CXX) $(CXXFLAGS) -o $@ $(HELLO_SRC) -L$(LIB_DIR) -lhellolib -static

# Compile binary linked to dynamic library
$(DYNAMIC_BIN): $(HELLO_SRC) $(DYNAMIC_LIB) | $(BIN_DIR)
	$(CXX) $(CXXFLAGS) -o $@ $(HELLO_SRC) -L$(LIB_DIR) -lhellolib
#	$(CXX) $(CXXFLAGS) -o $@ $(HELLO_SRC) $(DYNAMIC_LIB)
#	$(CXX) $(CXXFLAGS) -o $@ $(HELLO_SRC) -L$(LIB_DIR) -lhellolib -Wl,-rpath,$(LIB_DIR)

# Clean up
clean:
	rm -rf $(DISTRIBUTION_DIR) *.o

pristine: clean
	rm -rf *~ core

.PHONY: all clean



# Automation used not for the demo but for maintaining this project.

README.md: VersionGuard_1a.docx
	pandoc --number-sections -t markdown_strict $< -o $@
