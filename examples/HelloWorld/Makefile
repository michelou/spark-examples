##
## Copyright (c) 2018-2024 Stéphane Micheloud
##
## Licensed under the MIT License.
##
##############################################################################

include ../Makefile.inc

SOURCE_DIR  = src
TARGET_DIR  = target
CLASSES_DIR = $(TARGET_DIR)/classes

SCALAC_CPATH = $(SCALA_LIB_JAR)$(PSEP)$(SPARK_CATALYST_JAR)$(PSEP)$(SPARK_CORE_JAR)$(PSEP)$(SPARK_SQL_JAR)$(PSEP)$(SPARK_UTILS_JAR)$(PSEP)$(CLASSES_DIR)
SCALAC_FLAGS = -deprecation -classpath "$(SCALAC_CPATH)"

SCALA_CPATH  = $(SCALAC_CPATH)$(PSEP)$(LOG4J_CORE_JAR)
SCALA_FLAGS  = -classpath "$(SCALA_CPATH)"

##############################################################################
## main rules

SOURCES   = $(shell $(FIND) "$(SOURCE_DIR)/main/scala" -type f -name "*.scala" 2>/dev/null)
RESOURCES = $(shell $(FIND) "$(SOURCE_DIR)/main/resources" -type f -name "*.conf" -or -name "*.xml" 2>/dev/null)
TARGET    = $(TARGET_DIR)/.latest-build

OPTS_FILE    = $(TARGET_DIR)/scalac_opts.txt
SOURCES_FILE = $(TARGET_DIR)/scalac_sources.txt

MAIN_CLASS = HelloWorld
MAIN_ARGS ?= 

all: build

build: deps $(TARGET)

$(TARGET): $(SOURCES) $(RESOURCES)
	[ -d "$(CLASSES_DIR)" ] || "$(MKDIR)" -p "$(CLASSES_DIR)"
	@$(ECHO) $(SCALAC_FLAGS) -d "$(CLASSES_DIR)" > "$(OPTS_FILE)"
	@$(ECHO) $(SOURCES) > "$(SOURCES_FILE)"
	"$(SCALAC)" "@$(OPTS_FILE)" "@$(SOURCES_FILE)"
	for f in $(RESOURCES); do "$(CP)" "$$f" "$(CLASSES_DIR)"; done
	@$(TOUCH) "$(TARGET)"

clean:
	"$(RM)" -rf "project\target"
	"$(RM)" -rf "$(TARGET_DIR)"

run: build
	"$(SCALA)" $(SCALA_FLAGS) $(MAIN_CLASS) $(MAIN_ARGS)

help:
	@$(ECHO) "Usage: make all|build|clean|doc|help|run"
	@$(ECHO) ""
	@$(ECHO) "  Subcommands:"
	@$(ECHO) "    all    alias for build"
	@$(ECHO) "    build  compile Scala source files"
	@$(ECHO) "    clean  delete generated files"
	@$(ECHO) "    doc    generate HTML documentation"
	@$(ECHO) "    help   print this help message"
	@$(ECHO) "    run    execute main program \"$(MAIN_CLASS)\""

##############################################################################
## doc rules

DOC_TARGET_DIR = $(TARGET_DIR)/docs
DOC_SOURCES    = $(shell $(FIND) "$(SOURCE_DIR)/main/scala" -type f -name "*.scala" 2>/dev/null)
DOC_TARGET     = $(DOC_TARGET_DIR)/.latest-build

PROJECT_NAME    ?= $(shell basename $(CURDIR))
PROJECT_URL     ?= https://github.com/$(USERNAME)/spark-examples
PROJECT_VERSION ?= 1.0.0

DOC_OPTS_FILE    = $(TARGET_DIR)/scaladoc_opts.txt
DOC_SOURCES_FILE = $(TARGET_DIR)/scaladoc_sources.txt

$(DOC_TARGET): $(DOC_SOURCES)
	[ -d "$(DOC_TARGET_DIR)" ] || "$(MKDIR)" -p "$(DOC_TARGET_DIR)"
	@$(ECHO) -siteroot "$(DOC_TARGET_DIR)" -d "$(DOC_TARGET_DIR)" -project "$(PROJECT_NAME)" -project-version "$(PROJECT_VERSION)" > "$(DOC_OPTS_FILE)"
	@$(ECHO) $(DOC_SOURCES) > "$(DOC_SOURCES_FILE)"
	"$(SCALADOC)" "@$(DOC_OPTS_FILE)" "@$(DOC_SOURCES_FILE)"
	@$(TOUCH) "$(DOC_TARGET)"

doc: build $(DOC_TARGET)

##############################################################################
## phony

.PHONY: all build clean deps doc help run

.SUFFIXES:
.SUFFIXES: .class .conf .html .jar .java .scala
