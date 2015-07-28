
\listfiles
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\RequirePackage{hyphsubst}% Trennregeln austauschen
\HyphSubstIfExists{ngerman-x-latest}{%
  \HyphSubstLet{ngerman}{ngerman-x-latest}}{}
\HyphSubstIfExists{german-x-latest}{%
  \HyphSubstLet{german}{german-x-latest}}{}

\ProvidesClass{dtk2}%
  [2015/07/28 v0.1c dtk document class (RN)]

\RequirePackage{ifxetex,ifluatex,ifpdf,ifvtex}
\newcommand*\DTK@engine{}

\ifluatex
  \def\DTK@engine{4}% LuaTeX
\else
  \ifxetex
    \def\DTK@engine{3}% XeTeX
  \else
    \ifpdf
      \def\DTK@engine{2}% pdfTeX
    \else
      \ifvtex
        \def\DTK@engine{1}% VTeX
      \else
        \def\DTK@engine{0}% TeX+dvips
      \fi
    \fi
  \fi
\fi

\newif\ifDTK@Author@ \DTK@Author@true
\newif\ifDTK@bib@ \DTK@bib@false

\DeclareOption{10pt}{\OptionNotUsed}
\DeclareOption{11pt}{\OptionNotUsed}
\DeclareOption{12pt}{\OptionNotUsed}
\DeclareOption{twoside}{\OptionNotUsed}
\DeclareOption{oneside}{\OptionNotUsed}
\DeclareOption{full}{\DTK@Author@false}
\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{scrbook}}
%\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}%
\DeclareOption*{\OptionNotUsed}
\ProcessOptions\relax

\PassOptionsToPackage{pagesize,twoside=true}{typearea}

\LoadClass[%
,fontsize=10pt
,captions=oneline
,parskip=full*
,headings=small
,open=any
%,toc=flat
]{scrbook}

% *** Konstanten ***

\ifDTK@Author@\else\setcounter{errorcontextlines}{100}\fi

\paperwidth  = 148mm %
\paperheight = 210mm %
\textheight = 485pt %
\textwidth  = 333pt %
\oddsidemargin  = -35.89157pt %
\evensidemargin = -17.70235pt %
\marginparwidth = 1cm %
\marginparsep = 7pt %
\topmargin  = -55.66684pt %
\headheight = 17pt %
\headsep    = 17pt %
\footskip = 24pt %
\parskip   = 0.3\baselineskip
\advance\parskip by 0pt plus 2pt %
\parindent = 0pt %
\columnsep = 5pt %

\emergencystretch = 1.5em %
\clubpenalty  = 10000 %
\widowpenalty = 10000 %
\raggedbottom

\setcounter{secnumdepth}{\numexpr\partnumdepth-1\relax}
\setcounter{tocdepth}{\chapternumdepth}

\@fptop=\z@
\renewcommand\topfraction{.9}
\renewcommand\bottomfraction{.9}
\renewcommand\textfraction{.1}

\newcommand*\journalname{Die \TeX{}nische Kom\"odie}
\newcommand*\DTK@fancyJournalname{%
  \color{black!60}Die \color{black}\TeX\color{black!60}nische Kom\"odie}

\newcommand*\DTK@year{}
\newcommand*\DTK@month{}
\newcommand*\DTK@issue{}
\newcommand*\DTK@volume{}
\newcommand*\DTK@date{}
\newcommand*\DTK@corrVersion{}
\newcommand*\DTK@fullEdition{}

\newif\ifDTK@corr@ \DTK@corr@true
\newif\ifDTK@lineno@ \DTK@lineno@false

\newcommand*\DieTeXnischeKomoedie{% #1=Ausgabe, #2=Monat, #3=Jahr
  \@ifstar{\global\DTK@corr@true\DTK@DieTeXnischeKomoedie}%
    {\global\DTK@corr@false\DTK@DieTeXnischeKomoedie}%
}
\newcommand\DTK@DieTeXnischeKomoedie{%
  \@ifstar{\global\DTK@lineno@true\DTK@@DieTeXnischeKomoedie}%
    {\global\DTK@lineno@false\DTK@@DieTeXnischeKomoedie}%
}
\newcommand*\DTK@@DieTeXnischeKomoedie[3]{%
  \gdef\DTK@issue{#1}%
  \ifx\relax#1\relax\gdef\DTK@date{?/??}\else\xdef\DTK@date{#1/#3}\fi
  \gdef\DTK@month{#2}%
  \xdef\DTK@month@name{\DTMgermanmonthname{#2}}
  \gdef\DTK@year{#3}%
  \xdef\DTK@volume{\the\numexpr\DTK@year-1989+1\relax}%
  \xdef\DTK@fullEdition{\DTK@volume. Jahrgang\quad
    Heft \DTK@issue/\DTK@year\quad \DTK@month@name\ \DTK@year}
  \ifDTK@corr@
    \xdef\DTK@corrVersion{\noexpand\normalfont
      \noexpand\fbox{Korrekturversion: \DTMnow}}%
  \fi
}

% TODO: Nur Laden, wenn \DTK@lineno@true; Problem: "pagewise"
\let\@LN=\@gobbletwo% Wegen .aux-Datei von vorherigem lineno-Lauf
\RequirePackage[pagewise]{lineno}
\linenumbersep=.8ex %
\def\linenumberfont{\normalfont\footnotesize\ttfamily}%
\def\thelinenumber{%
  \fboxsep=.3ex %
  \fcolorbox{black}{red!30}{\@arabic{\c@page}-\@arabic{\c@linenumber}}%
}%
\AtBeginDocument{%
  \ifDTK@lineno@
    \linenumbers
  \fi
}

\RequirePackage{xpatch,xcolor,listings,multicol,ragged2e}
%\RequirePackage{etex} % ???
\RequirePackage{dantelogo,hologo,dtklogos}

\newdimen\DTK@tempdima
\newdimen\DTK@tempdimb
\newdimen\DTK@tempdimc

\newcommand*\DTK@tempa{}
\newcommand*\DTK@tempb{}
\newcommand*\DTK@tempc{}

\ifnum\DTK@engine < 3 %
  \input{dtk2-old-engines.clo}% pdfTeX oder TeX+dvips oder VTeX
\else
  \input{dtk2-new-engines.clo}% LuaTeX oder XeTeX
\fi

\RequirePackage[main=ngerman]{babel}
\RequirePackage[showzone=false]{datetime2}
\RequirePackage[autostyle=true,babel=once,german=guillemets,maxlevel=3]{csquotes}%
\MakeAutoQuote{»}{«}
\defineshorthand{"`}{\openautoquote}%
\defineshorthand{"'}{\closeautoquote}%

\ifxetex\else
\RequirePackage[%
,factor=1500
,protrusion=true
,expansion=true
,verbose=true
,final=true
,letterspace=100
,babel=true
]{microtype}
% TODO: Spezielle Angaben zu den Schriften
\fi

\AtEndOfClass{%
  \shorthandon{"}
  \ifDTK@Author@\else
    \ifDTKrecord\else
      \InputIfFileExists{userpackages.tex}{%
        \typeout{*************************************^^J%
                 * File `userpackages.tex' used.^^J%
                 *************************************}%
      }{}%
    \fi
  \fi
}

\RequirePackage[%
,style=dtk
,language=auto
,hyperref=auto
,abbreviate=true
,sorting=nyt
,bibencoding=utf8
,block=ragged
,backend=biber
%,useprefix=true
%,backrefstyle=two
,sortlocale=de_DE
%  ,sortlocale=de_DE_phonebook
,dateabbrev=false
,datezeros=false
,maxnames=3
,minnames=3
%,defernumbers=true
]{biblatex}

\newcommand*\ORIG@printbibliography{}
\let\ORIG@printbibliography=\printbibliography

\newcommand*\DTK@embedded@documentclasshook{}
\newcommand*\AtEmbeddedDocumentclass{%
  \g@addto@macro\DTK@embedded@documentclasshook}
\newcommand*\DTK@embedded@begindocumenthook{}
\newcommand*\AtEmbeddedBeginDocument{%
  \g@addto@macro\DTK@embedded@begindocumenthook}
\newcommand*\DTK@embedded@enddocumenthook{}
\newcommand*\AtEmbeddedEndDocument{%
  \g@addto@macro\DTK@embedded@enddocumenthook}
\newcommand*\DTK@jobname{}
\newcommand*\DTK@local@inputname{}
\newcommand*\DTK@eat@version[1][]{\ignorespaces}
\newcommand*\DTK@usepackage[2][]{%
  \@ifnextchar[%]
    {\DTK@@usepackage{#1}{#2}}%
    {\DTK@@usepackage{#1}{#2}[]}%
}%
\newcommand*\DTK@@usepackage{}
\newcommand*\DTK@documentclass[2][]{%
  \DTK@embedded@documentclasshook% TODO: nötig?
  \DTK@eat@version
}

\@ifundefined{ifDTKrecord}{\newif\ifDTKrecord \DTKrecordfalse}{}
\ifDTKrecord
  % Testlauf zum Aufsammeln von Paket- und bib-Dateinamen
  \@ifdefinable\User@Packages{%
    \newwrite\User@Packages
    \immediate\openout\User@Packages userpackages.tex\relax
    \immediate\write\User@Packages{\@percentchar\space *** \DTMnow\space ***}%
    \AtEndDocument{\immediate\closeout\User@Packages\relax}%
  }
  \newcommand*\DTK@addbibresource[2][]{%
    \immediate\write\User@Packages{%
      \string\addbibresource[datatype=bibtex,label=\the\c@refsection]{#2}%
        \@percentchar\space From file: \DTK@local@inputname
    }%
  }%
  \newcommand*\DTK@bibliography[1]{%
    \filename@parse{#1}%
    \@ifundefined{filename@ext}%
      {\IfFileExists{\filename@base.bib}%
        {\edef\DTK@tempa{\filename@base.bib}}{}}%
      {\edef\DTK@tempa{#1}}%
    \DTK@addbibresource{\DTK@tempa}%
  }%
  \renewcommand*\printbibliography[1][]{}%
  \def\DTK@@usepackage#1#2[#3]{%
    \edef\@tempb{\zap@space#2 \@empty}%
    \@for\@tempa:=\@tempb\do{%
      \immediate\write\User@Packages{%
        \string\usepackage\ifx\relax#1\relax\else[#1]\fi{\@tempa}%
          \ifx\relax#3\relax\else[#3]\fi
            \@percentchar\space From file: \DTK@local@inputname
      }%
    }%
  }%
\else
  \ifDTK@Author@
    % Falls \bibliography{...} in traditioneller Weise nach \begin{document}.
    % (2xLaTeX-Lauf + biber + 1xLaTeX-Lauf)
    \AfterEndPreamble{%
      \renewcommand*\bibliography[1]{%
        \immediate\write\@mainaux{\string\bibliography{#1}}%
        \printbibliography[heading=dtk]
      }%
    }%
    \AtBeginDocument{\let\maketitle=\DTK@maketitle}%
  \else
    % Gesamtlauf
    \def\DTK@@usepackage#1#2[#3]{}%
    \newcommand*\DTK@addbibresource[2][]{}%
    \renewcommand*\printbibliography[1][]{\DTK@bib@true}%
    \newcommand*\DTK@bibliography[1]{\DTK@bib@true}%
    \AtBeginDocument{%
      \renewcommand\maketitle[1][]{%
        \thispagestyle{dtk-title}%
        \global\let\maketitle=\DTK@maketitle
        \null\newpage
      }%
    }
  \fi
\fi

%%% Laden eines Einzeldokuments
\newcommand*\DTKinput[1]{%
  \begingroup
    \filename@parse{#1}%
    \edef\jobname{\filename@base}%
    \@ifundefined{filename@ext}%
      {\IfFileExists{\jobname.tex}%
        {\edef\DTK@local@inputname{\jobname.tex}}{}}%
      {\edef\DTK@local@inputname{#1}}%
    \let\AtBeginDocument=\@gobble
    \let\AtEndDocument=\@gobble
    \let\pagestyle=\@gobble
    \let\thispagestyle=\@gobble
    \let\listfiles=\relax
    \let\nofiles=\relax
    \let\documentclass=\DTK@documentclass
    \let\usepackage=\DTK@usepackage
    \let\addbibresource=\DTK@addbibresource
    \let\bibliography=\DTK@bibliography
    \DTK@bib@false
    \c@footnote=\z@
    \c@lstlisting=\z@
    \c@figure=\z@
    \c@table=\z@
    \c@equation=\z@
    \renewenvironment*{document}%
      {\DTK@embedded@begindocumenthook}%
      {\ifDTK@bib@\ORIG@printbibliography[heading=dtk]\fi
       \DTK@embedded@enddocumenthook\endinput}%
    \refsection[\the\c@refsection]%
      \input{\DTK@local@inputname}%
    \endrefsection
  \endgroup
}

\newcommand*\DTK@keywords{}
\newcommand*\keywords[1]{\gdef\DTK@keywords{#1}}% ???

% Kompakte Listen
\RequirePackage[neverdecrease]{paralist}
\newcommand*\DTK@begin@list[1]{%
  \DTK@tempdima=\parindent
  \DTK@tempdimb=\parskip
  \@nameuse{#1}%
  \parindent=\DTK@tempdima
  \parskip=\DTK@tempdimb
}
\def\enumerate{\DTK@begin@list{compactenum}}
\def\itemize{\DTK@begin@list{compactitem}}
\def\description{\DTK@begin@list{compactdesc}}
\let\enditemize\endcompactitem
\let\endenumerate\endcompactenum
\let\enddescription\endcompactdesc
\pltopsep=\medskipamount
\plitemsep=1pt %
\plparsep=1pt %

\renewcommand\title[2][]{%
  \gdef\@title{#2}%
  \ifx\relax#1\relax\gdef\@@title{#2}\else\gdef\@@title{#1}\fi%
}

\newcommand\DTK@maketitle[1][]{%
  \begingroup
    \dimen0=\vsize
    \advance\dimen0 by -\pagetotal
    \ifdim\dimen0<100pt %
      \newpage
      %\global\FirstArticletrue
    \fi
    \chapter[\@@title]{\@title}%
    \ifx\@author\@empty\else\par
      \begingroup
        \usekomafont{section} \@author
      \endgroup
    \fi
    \@thanks
    \let\thanks\@gobble
  \endgroup
  \let\@title=\@empty
  \let\@author=\@empty
  \let\@thanks=\@empty
  \medskip\par
}

\newcommand\address[3]{}
\newcommand*\addressname{Autoren/Organisatoren}

\ifDTKrecord
  \renewcommand*\listofaddresses{}% nötig?
\else
  \ifDTK@Author@\else
    \renewcommand\address[3]{% TODO: Auch "!" und "|" maskieren?
      \begingroup
        \def\url##1{\escape@atsign##1\relax}%
        \def\escape@atsign##1@##2\relax{%
          \noexpand\url\string{##1\string"@##2\string}%
        }
        \makeatletter
        \scantokens{\protected@edef\x{%
          \noexpand\sindex[addresses]{#2#1@#1 #2!#3}}}\x
      \endgroup
    }
    \RequirePackage[split,protected]{splitidx} \makeindex
    \newindex[\addressname]{addresses}
    \newcommand*\listofaddresses{%
      \clearpage
      \begingroup
        %\language\langwohyphens
        \renewenvironment{theindex}{\theaddresses}{\endtheaddresses}%
        \printindex[addresses]%
      \endgroup
    }
    \let\indexspace=\relax
    \renewcommand*\idx@heading{%
      \chapter{\indexname}%
      \ifx\index@preamble\relax
      \else\index@preamble\let\index@preamble=\relax\fi
    }%
    \def\DTK@scan@item#1\subitem#2\relax#3\@nil{%
      \def\DTK@tempa{#1}\def\DTK@tempb{#2}\def\DTK@tempc{#3}%
    }
    \newenvironment{theaddresses}{%
      \columnseprule=\z@ \columnsep=10\p@
      \begin{multicols}{2}[\idx@heading]%
        \makeatletter
        \parindent\z@
        \setlength{\parskip}{\z@ \@plus .3\p@}%
        \setlength{\parfillskip}{\z@ \@plus 1fil}%
        \raggedright
        \def\item##1\@nil{\DTK@scan@item##1\@nil
          \par\parbox{\columnwidth}{%
            \textbf{\DTK@tempa}\hfill[\DTK@tempc]\par\DTK@tempb
          }%
        }%
    }{%
      \end{multicols}%
    }
    \let\lettergroup=\indexsection
  \fi
\fi

\addtokomafont{caption}{\small}
\addtokomafont{captionlabel}{\bfseries\sffamily}
\setcapindent{1em}
\setcapwidth[c]{.8\textwidth}

\defbibheading{dtk}{\section{\bibname}}
\renewcaptionname{ngerman}{\bibname}{Literatur und Software}

\renewcommand\thefigure{\arabic{figure}}
\renewcommand\thetable{\arabic{table}}
\renewcommand\theequation{\arabic{equation}}

\newcommand*\DTK@toc@head{%
  \raisebox{0mm}[0pt][0pt]{%
    \parbox[t]{\textwidth}{%
      \normalfont\nointerlineskip
      \begingroup
        \Huge\raggedright
        \DTK@fancyJournalname \\
      \endgroup
      \addvspace{\dimexpr5mm-\baselineskip}%
      \rule{\textwidth}{2pt}\\[0.5mm]%
      \begingroup
        \footnotesize\raggedleft
        \DTK@fullEdition \\
      \endgroup
    }%
  }%
}

\RequirePackage{pict2e}
\RequirePackage{picture}
\newcommand\DTK@title@content{%
  \begin{picture}(0,0)(0,-\ht\strutbox)%
    \put(24mm,-.5\paperheight){%
      \makebox(0,0)[c]{\rotatebox[origin=c]{90}{%
        \resizebox{14cm}{!}{\Huge\DTK@fancyJournalname}}}%
      \put(8mm,0){%
        \makebox(0,0)[c]{\rule{0.85mm}{\textheight}}}%
    }%
    \put(53mm,-68mm){%
      \parbox[t]{78mm}{%
        \raggedleft
        %\Huge\dantelogo % ???
        \Huge DANTE \\
        \Large Deutschsprachige \\
        Anwendervereinigung \TeX\ \eV \\
        \addvspace{4mm}%
        \begingroup
          \raggedright\footnotesize
          \DTK@fullEdition \\
        \endgroup
        \addvspace{40mm}%
        \makebox(0,0)[r]{\Large\DTK@corrVersion}
      }%
    }%
    \put(86mm,-186mm){%
      \begingroup
        \color[gray]{.8}\resizebox{45mm}{!}{\Huge\DTK@date}%
      \endgroup
    }%
  \end{picture}%
}

\RequirePackage[automark]{scrlayer-scrpage}
\pagestyle{scrheadings}
\clearpairofpagestyles
\ihead{\headmark}
\ohead{\pagemark}
\cfoot*{\DTK@corrVersion}
\ifoot*{\journalname~~\DTK@date}
\automark[chapter]{chapter}

\defpagestyle{dtk-toc}{{\DTK@toc@head}{}{}}%
  {{\hfill\DTK@corrVersion\hfill\null}{}{}}
\defpagestyle{dtk-title}{}{}
\DeclareNewLayer[foreground,contents={%\layercontentsmeasure
  \DTK@title@content}]{dtk-title-content}
\AddLayersToPageStyle{dtk-title}{dtk-title-content}

\renewcommand*\l@part[2]{%
  \begingroup
    \addpenalty{-\@highpenalty}%
    \usekomafont{partentry}%
    \addvspace{0.5em plus 0pt}% space above part line
    \@tempdima=1.5em %
    \advance\leftskip\@tempdima
    \hskip -\leftskip
    #1\par
    \penalty\@highpenalty
  \endgroup
  \addvspace{0.2em}%
}
\renewcommand*\l@chapter[2]{%    TODO: Abstände richtig?
  \begingroup
    \usekomafont{chapterentry}%
    \vskip \z@ \@plus.2\p@
    \@afterindenttrue
    \interlinepenalty\@M
    \@tempdimb 2.5em\relax % indent
    \advance\leftskip \@tempdimb
    \advance\rightskip \@tempdimb
    \noindent\hskip -\leftskip
    \hbox to\@tempdimb{\usekomafont{chapterentrypagenumber}#2\hss}%
    #1\par
  \endgroup
}

\setkomafont{chapterentry}{\normalfont\small}
\setkomafont{chapterentrypagenumber}{\usekomafont{chapterentry}}
\setkomafont{partentry}{\usekomafont{chapterentry}\bfseries}

\deftocheading{toc}{%
  \cleardoubleevenpageusingstyle{empty}%
  \thispagestyle{dtk-toc}%
  \vspace*{16pt minus 8pt}%
  \let\\=\relax
  \raggedright
}

\setkomafont{disposition}{\normalfont\sffamily}
\setkomafont{part}{\usekomafont{disposition}\huge}
\setkomafont{chapter}{\usekomafont{disposition}\Large}
\setkomafont{section}{\usekomafont{disposition}\large}
\setkomafont{pagenumber}{\normalfont\sffamily}
\setkomafont{pagehead}{\sffamily\slshape}% \itshape?
\setkomafont{pagefoot}{\footnotesize\sffamily\slshape}% \itshape?

\newcommand\Part[2][]{%
  \def\DTK@tempa{\part[#1]{#2}}\DTK@Part
}
\newcommand\DTK@Part[1][]{%
  \ifx\relax#1\relax\else
    \setpartpreamble{%
      \noindent\rule{\textwidth}{2pt}
      \par\smallskip
      { \usekomafont{section} #1\par }%
    }%
  \fi
  \DTK@tempa\bigskip\par
}

\def\partheadstartvskip{% 12.0pt plus 1.0fil
  \null\vskip-\baselineskip\vskip 10pt %
}
\def\partheadendvskip{%
  \bigskip\bigskip\par
}
\let\partheademptypage=\relax% ???
\let\raggedpart\raggedright
\def\partpagestyle{plain.scrheadings}

\def\chapterheadstartvskip{}
\def\chapterheadstartvskip{} %\vspace {\@tempskipa }
\def\chapterpagestyle{scrheadings}
\xpatchcmd{\scr@startchapter}{\clearpage}{\relax}{}{\PaTchFaiLED}% ???

\endinput

