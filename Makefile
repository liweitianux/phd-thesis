THESIS= thesis
TEX_DIR= tex
BIB_DIR= bib
TEMPLATE= sjtuthesis.cls sjtuthesis.cfg

LATEXMK_OPT= -xelatex

all: $(THESIS).pdf

$(THESIS).pdf: $(THESIS).tex $(TEX_DIR)/*.tex $(BIB_DIR)/*.bib $(TEMPLATE)
	latexmk $(LATEXMK_OPT) $(THESIS)

validate:
	xelatex -no-pdf -halt-on-error $(THESIS)
	biber --debug $(THESIS)

wordcount:
	@perl tools/texcount.pl $(THESIS).tex -inc \
	    | awk '/total/ {getline; print "词数    :",$$4}'
	@perl tools/texcount.pl $(THESIS).tex -inc -char \
	    | awk '/total/ {getline; print "字符数  :",$$4}'
	@perl tools/texcount.pl $(THESIS).tex -inc -ch-only \
	    | awk '/total/ {getline; print "中文字数:",$$4}'

clean:
	latexmk -C
	rm -f *.xdv *.bbl *.fls \
	    $(TEX_DIR)/*.xdv $(TEX_DIR)/*.aux \
	    $(TEX_DIR)/*.log $(TEX_DIR)/*.fls _tmp_.pdf *.xml

.PHONY: all clean wordcount
