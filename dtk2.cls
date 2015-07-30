
\listfiles
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\RequirePackage{hyphsubst}% Trennregeln austauschen
\HyphSubstIfExists{ngerman-x-latest}{%
  \HyphSubstLet{ngerman}{ngerman-x-latest}}{}
\HyphSubstIfExists{german-x-latest}{%
  \HyphSubstLet{german}{german-x-latest}}{}

\ProvidesClass{dtk2}%
  [2015/07/29 v0.1c dtk document class (RN)]

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
\newif\ifDTKcolor \DTKcolorfalse % "@" ?

\DeclareOption{full}{\DTK@Author@false}
\DeclareOption{color}{\DTKcolortrue}
\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{scrbook}}
\DeclareOption*{\OptionNotUsed}
\ProcessOptions\relax

\PassOptionsToPackage{pagesize,twoside=true}{typearea}

\LoadClass[%
,fontsize=10pt
,captions=oneline
,parskip=full*
,headings=small
,open=any
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

\ifnum\DTK@engine < 3 %
  \input{dtk-old-engines.clo}% pdfTeX oder TeX+dvips oder VTeX
\else
  \input{dtk-new-engines.clo}% LuaTeX oder XeTeX
\fi

\RequirePackage[main=ngerman]{babel}
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
% TODO: Spezielle Angaben zu den Schriften?
\fi

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

\newcommand*\journalname{Die \TeX{}nische Kom\"odie}

\newcommand*\DTK@year{????}
\newcommand*\DTK@month{?????}
\newcommand*\DTK@issue{?}
\newcommand*\DTK@volume{??}
\newcommand*\DTK@date{?/??}
\newcommand*\DTK@corrVersion{}
\newcommand*\DTK@fullIssue{}

\RequirePackage{xpatch,listings}
%\RequirePackage{etex} % ???
\RequirePackage{dantelogo,hologo,dtklogos}

\newdimen\DTK@tempdima
\newdimen\DTK@tempdimb
\newdimen\DTK@tempdimc

\newcommand*\DTK@tempa{}
\newcommand*\DTK@tempb{}
\newcommand*\DTK@tempc{}

\renewcommand\title[2][]{%
  \gdef\@title{#2}%
  \ifx\relax#1\relax\gdef\@@title{#2}\else\gdef\@@title{#1}\fi%
}

\newcommand\DTK@maketitle[1][]{%
  \begingroup
    \dimen0=\textheight
    \advance\dimen0 by -\pagetotal
    \ifdim\dimen0<.2\textheight
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

\renewcaptionname{ngerman}{\bibname}{Literatur und Software}
\defbibheading{dtk}{\section{\bibname}}

\RequirePackage[automark,draft=false]{scrlayer-scrpage}
\pagestyle{scrheadings}
\clearpairofpagestyles
\ihead{\headmark}
\ohead{\pagemark}
\cfoot*{\DTK@corrVersion}
\ifoot*{\journalname~~\DTK@date}
\automark[chapter]{chapter}

\def\chapterheadstartvskip{}
\def\chapterheadstartvskip{} %\vspace {\@tempskipa }
\def\chapterpagestyle{scrheadings}
\xpatchcmd{\scr@startchapter}{\clearpage}{\relax}{}{\PaTchFaiLED}% ???

\RequirePackage{xcolor}
\ifDTKcolor
  \colorlet{DTK@markerColor}{red!30}
  \definecolor{DTKlstBackground}{rgb}{1,1,0.95}
  \definecolor{DTKlstKeys}{rgb}{0,0,1}
  \definecolor{DTKlstIdentifiers}{rgb}{0,0,0}
  \definecolor{DTKlstComments}{rgb}{1,0,0}
  \definecolor{DTKlstStrings}{rgb}{0,0.5,0}
\else
  \colorlet{DTK@markerColor}{black!20}
  \colorlet{DTKlstBackground}{black!5}
  \colorlet{DTKlstKeys}{black}
  \colorlet{DTKlstIdentifiers}{black}
  \colorlet{DTKlstComments}{black}
  \colorlet{DTKlstStrings}{black}
\fi

\ifDTK@Author@
  \input{dtk-author.clo}
\else
  \input{dtk-full.clo}
\fi

\ifDTKrecord \expandafter \endinput \fi % lohnt es?

\addtokomafont{caption}{\small}
\addtokomafont{captionlabel}{\bfseries\sffamily}
\setcapindent{1em}
\setcapwidth[c]{.8\textwidth}

\renewcommand\thefigure{\arabic{figure}}
\renewcommand\thetable{\arabic{table}}
\renewcommand\theequation{\arabic{equation}}

\setkomafont{disposition}{\normalfont\sffamily}
\setkomafont{part}{\usekomafont{disposition}\huge}
\setkomafont{chapter}{\usekomafont{disposition}\Large}
\setkomafont{section}{\usekomafont{disposition}\large}
\setkomafont{pagenumber}{\normalfont\sffamily}
\setkomafont{pagehead}{\sffamily\slshape}% \itshape?
\setkomafont{pagefoot}{\footnotesize\sffamily\slshape}% \itshape?

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

% Listings

% ..............

\endinput

