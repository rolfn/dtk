# Aktuelle Definitionen zum make-Prozess für "Die TeXnische Komödie"
# -- anzupassen für die aktuelle Ausgabe --

MAIN = komoedie
ARTICLES = artikel1.tex artikel2.tex artikel3.tex
BIBS =  artikel1.bib artikel2.bib

all : $(MAIN).pdf

include Makefile.in
















