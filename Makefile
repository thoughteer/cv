language ?= english

cv.pdf: cv.ps
	ps2pdf cv.ps

cv.ps: cv.dvi
	dvips cv.dvi

cv.dvi: cv.cls cv.tex publications.bib
	echo '\\cvsetlanguage{$(language)}' > language.tex
	latex cv && biber cv && latex cv
	rm language.tex

cv.svg: cv.pdf
	pdf2svg cv.pdf cv.svg

clean:
	rm -f cv.aux cv.bbl cv.bcf cv.blg cv.dvi cv.log cv.out cv.pdf cv.ps cv.run.xml cv.svg

.PHONY: clean
