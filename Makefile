TEXINPUTS:=	.:sjtuthesis:texmf:$(TEXINPUTS)
BSTINPUTS:=	.:sjtuthesis:texmf:$(BSTINPUTS)

TEMPLATE:=	$(wildcard sjtuthesis/*)
SRCS:=		thesis.tex references.bib $(wildcard tex/*.tex)

all: thesis.pdf

thesis.pdf: $(SRCS) $(TEMPLATE)
	env TEXINPUTS=$(TEXINPUTS) BSTINPUTS=$(BSTINPUTS) latexmk -xelatex thesis

fix:
	@echo "Trim trailing whitespace ..."
	@for f in $(SRCS); do sed -i -E 's/\s+$$//' $$f; done
	@echo "Change period style ..."
	@for f in $(SRCS); do sed -i -E -e 's/。$$/./' -e 's/。/. /' $$f; done

count:
	@texcount thesis.tex -inc \
	    | awk '/total/ {getline; print "词数    :",$$4}'
	@texcount thesis.tex -inc -char \
	    | awk '/total/ {getline; print "字符数  :",$$4}'
	@texcount thesis.tex -inc -ch-only \
	    | awk '/total/ {getline; print "中文字数:",$$4}'

clean:
	latexmk -C thesis
	rm -f *.xdv *.bbl *.loa *.fls *.xml tex/*.aux

.PHONY: all clean count fix
