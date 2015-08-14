# Aktuelle Definitionen zum make-Prozess für "Die TeXnische Komödie"
# -- anzupassen für die aktuelle Ausgabe --

MAIN = komoedie

ARTICLES += artikel1.tex
#ADDINPUTS += artikel1-foo.tex abbildung17.png

ARTICLES += artikel2.tex
#ADDINPUTS += artikel2-bar.tex

ARTICLES += artikel3.tex
#ADDINPUTS += artikel3-baz.tex

all : $(MAIN).pdf

include Makefile.in
















