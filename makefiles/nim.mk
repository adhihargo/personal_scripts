%.exe: %.nim
	nim compile --verbosity:0 $<

run_%: %.nim
	nim compile -r --verbosity:0 $<

fmt_%: %.nim
	nimpretty $<

doc_%: %.nim
	nim doc $<

fmtrun_%:
	$(MAKE) fmt_$*
	$(MAKE) run_$*

fmtdoc_%:
	$(MAKE) fmt_$*
	$(MAKE) doc_$*
