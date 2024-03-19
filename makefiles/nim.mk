NIMC_ARGS=--verbosity:0

%.exe: %.nim
	nim compile $(NIMC_ARGS) $<

run_%.exe: %.nim
	nim compile -r $(NIMC_ARGS) $<
run_%: run_%.exe

fmt_%.exe: %.nim
	nimpretty $<
fmt_%: fmt_%.exe

doc_%.exe: %.nim
	nim doc $<
doc_%: doc_%.exe

fmtrun_%:
	$(MAKE) fmt_$*
	$(MAKE) run_$*

fmtdoc_%:
	$(MAKE) fmt_$*
	$(MAKE) doc_$*
