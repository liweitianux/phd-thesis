TEXINPUTS:=	.:sjtuthesis:texmf:$(TEXINPUTS)
BSTINPUTS:=	.:sjtuthesis:texmf:$(BSTINPUTS)

TEMPLATE:=	$(wildcard sjtuthesis/*)
BIB:=		references.bib
SRCS:=		thesis.tex $(wildcard src/*.tex)

all: thesis.pdf

thesis.pdf: $(SRCS) $(BIB) $(TEMPLATE)
	env TEXINPUTS=$(TEXINPUTS) BSTINPUTS=$(BSTINPUTS) latexmk -xelatex thesis

pdf: $(SRCS) $(TEMPLATE)
	env TEXINPUTS=$(TEXINPUTS) BSTINPUTS=$(BSTINPUTS) xelatex thesis

bib: thesis.bcf $(BIB)
	biber thesis

fix:
	@echo "Trim trailing whitespace ..."
	@for f in $(SRCS); do sed -i -E 's/\s+$$//' $$f; done
	@echo "Change period style ..."
	@for f in $(SRCS); do sed -i -E -e 's/。$$/./' -e 's/。/. /' $$f; done

count:
	@echo -n "Chinese character count: "
	@pdftotext thesis.pdf - | \
	    perl -CS -p -e 's/[^\s\p{Han}]//g' | \
	    tr -d '\n\t ' | wc -m

clean:
	latexmk -C thesis
	rm -f $(SRCS:.tex=.aux) *.xdv *.bbl *.loa *.fls *.xml

.PHONY: all clean count fix
