RUBBER=rubber -Wrefs -Wmisc

pdf: resume.pdf
.PHONY: pdf

resume.pdf: resume.tex
	$(RUBBER) --pdf -Wrefs -Wmisc resume.tex
.PHONY: resume.pdf

html: html/dede.html
.PHONY: html

html/dede.html: resume.pdf
	mkdir -p `dirname $@`
#	HeVeA looks for \jobname.bbl, but jobname=html/dede
	cp resume.bbl html/dede.bbl
#	Run HeVeA once to produce images file
	hevea -I hevea hacks.hva -e util-macros.tex -e resume.aux -o $@ resume.tex
#	Generate required images
	python hevea/hvaimages.py html/dede.image.tex
#	Run HeVeA to a fixed point to produce the final output
	hevea -fix -I hevea hacks.hva -e util-macros.tex -e resume.aux -o $@ resume.tex

html.tar.gz: html/dede.html
	tar czf $@ $^ html/dede*.png

clean:
	$(RUBBER) --pdf --clean resume.tex
.PHONY: clean
