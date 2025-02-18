# Install the required extra packages:
# $ tlmgr --usermode init-usertree
# $ tlmgr --usermode install newtx newtxsf siunitx biblatex logreq

all: defense.pdf

defense.pdf: defense.tex preamble.tex
	env TEXINPUTS=.:texmf:../texmf: latexmk -xelatex defense

optimize: defense.pdf
	qpdf --linearize --compress-streams=y --optimize-images \
	    defense.pdf defense.optimized.pdf
	mv defense.optimized.pdf defense.pdf

compress: defense.pdf
	rm -f defense.compressed.pdf
	gs  -dQUIET -dNOPAUSE -dBATCH -dSAFER \
	    -sDEVICE=pdfwrite \
	    -dPDFSETTINGS=/ebook \
	    -dPrinted=false \
	    -dEmbedAllFonts=true \
	    -dSubsetFonts=true \
	    -dFastWebView=true \
	    -dColorImageDownsampleType=/Bicubic \
	    -dGrayImageDownsampleType=/Bicubic \
	    -dColorImageResolution=200 \
	    -dGrayImageResolution=200 \
	    -sOutputFile=defense.compressed.pdf \
	    defense.pdf

clean:
	-latexmk -C defense
	rm -f *.nav *.run.xml *.snm
