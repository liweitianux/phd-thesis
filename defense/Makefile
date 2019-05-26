all: defense.pdf

defense.pdf: defense.tex
	env TEXINPUTS=.:texmf:../texmf: latexmk -xelatex defense

optimize: defense.pdf
	qpdf --compress-streams=y --optimize-images \
	    defense.pdf defense.optimized.pdf
	mv defense.optimized.pdf defense.pdf

clean:
	-latexmk -C defense
	rm -f *.nav *.run.xml *.snm
