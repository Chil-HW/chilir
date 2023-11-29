LISP_PROG := @LISP_PROGRAM@
LISP_FLAGS := --no-userinit --non-interactive

makefile_dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

lisp_eval := $(LISP_PROG) $(LISP_FLAGS) \
             --eval '(require "asdf")' \
             --eval '(asdf:load-asd "$(makefile_dir)/chilir.asd")' \
             --eval

lisp_quit := --eval '(uiop:quit)'

chilir_files := chilir.asd $(shell find . -type f -name '*.lisp')

.PHONY: build
build: $(chilir_files)
	$(lisp_eval) '(asdf:compile-system :chilir)'

chilir_tests := chilir.asd $(shell find ./tests/ -type f -name '*.lisp')
.PHONY: check
check: $(chilir_files) $(chilir_tests)
	$(lisp_eval) '(asdf:test-system :chilir)'

include doc/local.mk
