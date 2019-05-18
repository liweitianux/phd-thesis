all: defense.pdf

defense.pdf: defense.tex
	env TEXINPUTS=.:texmf:../texmf: latexmk -xelatex defense

clean:
	-latexmk -C defense
	rm -f *.nav *.run.xml *.snm
