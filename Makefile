# Aktuelle Definitionen zum make-Prozess für "Die TeXnische Komödie"
# -- anzupassen für die aktuelle Ausgabe --

Shell=/bin/bash

MAIN = dtk

ARTICLES += artikel1.tex
ADDINPUTS += artikel1.bib

ARTICLES += artikel2.tex
ADDINPUTS += artikel2a.bib
ADDINPUTS += artikel2b.bib

ARTICLES += artikel3.tex

ARTICLES += artikel4.tex
ADDINPUTS += artikel4.bib

ARTICLES += artikel5.tex
ADDINPUTS += artikel5.bib

PICTURES = knuth.jpg LANDSCHAFT.JPG 
#PICTURES = $(wildcard *.jpg) $(wildcard *.JPG) $(wildcard *.jpeg) $(wildcard *.JPEG)

ADDINPUTS += $(PICTURES)

SHELL=/bin/bash 

include Makefile.in
















