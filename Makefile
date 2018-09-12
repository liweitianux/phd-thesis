TEXINPUTS:=	.:sjtuthesis:texmf:$(TEXINPUTS)
BSTINPUTS:=	.:sjtuthesis:texmf:$(BSTINPUTS)

TEMPLATE:=	$(wildcard sjtuthesis/*)
SRCS:=		thesis.tex references.bib $(wildcard tex/*.tex)

all: thesis.pdf

thesis.pdf: $(SRCS) $(TEMPLATE)
	env TEXINPUTS=$(TEXINPUTS) BSTINPUTS=$(BSTINPUTS) latexmk -xelatex thesis

wordcount:
	@perl tools/texcount.pl thesis.tex -inc \
	    | awk '/total/ {getline; print "词数    :",$$4}'
	@perl tools/texcount.pl thesis.tex -inc -char \
	    | awk '/total/ {getline; print "字符数  :",$$4}'
	@perl tools/texcount.pl thesis.tex -inc -ch-only \
	    | awk '/total/ {getline; print "中文字数:",$$4}'

clean:
	latexmk -C thesis
	rm -f *.xdv *.bbl *.loa *.fls *.xml tex/*.aux

.PHONY: all clean wordcount
