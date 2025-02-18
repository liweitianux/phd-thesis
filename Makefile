# Install the required extra packages:
# $ tlmgr --usermode init-usertree
# $ tlmgr --usermode install newtx newtxsf siunitx biblatex logreq
# $ tlmgr --usermode install biblatex-gb7714-2015
#
# Acro v3 is major update, and v3.6+ seems to have issues, so use v2.
# $ wget https://pi.kwarc.info/historic/systems/texlive/2019/tlnet-final/archive/acro.tar.xz  # v2.11c
# $ tlmgr --usermode install --file acro.tar.xz
#
# Historic TeXLive 2019 archives:
# - https://pi.kwarc.info/historic/systems/texlive/2019/tlnet-final/archive/
# - https://texlive.info/historic/systems/texlive/2019/tlnet-final/archive/

TEXINPUTS:=	.:sjtuthesis:texmf:$(TEXINPUTS)
BSTINPUTS:=	.:sjtuthesis:texmf:$(BSTINPUTS)

SRCS:=		thesis.tex \
		$(wildcard src/*.tex)
BIB:=		references.bib
FIGURES:=	$(wildcard figures/*.*) \
		$(wildcard figures/self/*.*)
TEMPLATE:=	$(wildcard sjtuthesis/*)
EXTRA:=		$(wildcard texmf/*) \
		$(wildcard scans/*.pdf) \
		Makefile \
		README.md

ID:=		lwt
DATE:=		$(shell date +'%Y%m%d')

DPI?=		200

all: thesis.pdf

thesis.pdf: $(SRCS) $(BIB) $(FIGURES) $(TEMPLATE)
	env TEXINPUTS=$(TEXINPUTS) BSTINPUTS=$(BSTINPUTS) latexmk -xelatex thesis

pdf: $(SRCS) $(TEMPLATE)
	env TEXINPUTS=$(TEXINPUTS) BSTINPUTS=$(BSTINPUTS) xelatex thesis

bib: thesis.bcf $(BIB)
	biber thesis

dist: thesis.pdf
	@test -d "dist" || mkdir -v "dist"
	cp -a thesis.pdf dist/thesis.$(ID).$(DATE).pdf
	tar -cvjf dist/thesis.$(ID).$(DATE).tar.bz2 \
	    --transform 's@^@thesis.$(ID).$(DATE)/@' \
	    $(SRCS) $(BIB) $(FIGURES) $(TEMPLATE) $(EXTRA)
	@echo "Created distribution at: dist/thesis.$(ID).$(DATE).{pdf,tar.bz2}"

optimize:
	qpdf --linearize --compress-streams=y --optimize-images \
	    thesis.pdf thesis.optimized.pdf
	mv thesis.optimized.pdf thesis.pdf

compress:
	rm -f thesis.compressed.pdf
	gs  -dQUIET -dNOPAUSE -dBATCH -dSAFER \
	    -sDEVICE=pdfwrite \
	    -dPDFSETTINGS=/ebook \
	    -dPrinted=false \
	    -dEmbedAllFonts=true \
	    -dSubsetFonts=true \
	    -dFastWebView=true \
	    -dColorImageDownsampleType=/Bicubic \
	    -dGrayImageDownsampleType=/Bicubic \
	    -dColorImageResolution=$(DPI) \
	    -dGrayImageResolution=$(DPI) \
	    -sOutputFile=thesis.compressed.pdf \
	    thesis.pdf

count:
	@echo -n "Chinese character count: "
	@pdftotext thesis.pdf - | \
	    perl -CS -p -e 's/[^\s\p{Han}]//g' | \
	    tr -d '\n\t ' | wc -m

clean:
	-latexmk -C thesis
	rm -f $(SRCS:.tex=.aux) *.xdv *.bbl *.loa *.fls *.xml

.PHONY: all clean count dist fix
