%% This is file `dtk.cls',
%%
%% LaTeX Class for ``Die TeXnische Komoedie''.
%%
%% Copyright (C) 2015-2024
%% Rolf Niepraschk, Herbert Voss
%%
%% It may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.

\listfiles

\InputIfFileExists{dtk-requirepackages.tex}{%
  \typeout{*************************************^^J%
           * File `dtk-requirepackages.tex' used.^^J%
           *************************************}%
}{}%

\NeedsTeXFormat{LaTeX2e}[1999/12/01]

\def\DTKversion{2.10e}
\def\DTKversiondate{2024/02/22}
\ProvidesClass{dtk}[\DTKversiondate v\DTKversion dtk documentclass (RN)]

\RequirePackage{iftex}

\ifluatex\else
  \ClassError{dtk}{%
    LuaLaTeX ist erforderlich.
  }{%
    Kompiliere mit LuaLaTeX.
  }
  \expandafter\stop
\fi

\RequirePackage{xkeyval}

\newif\ifDTK@Author@ \DTK@Author@true
\newif\ifDTKcolor \DTKcolorfalse % "@" ?
\newif\ifDTK@korr@ \DTK@korr@false

\newlength\DTK@tempdima
\newlength\DTK@tempdimb
\newlength\DTK@tempdimc
\newlength\DTK@tempdimd
\newlength\DTK@tempdime

\newlength\Linewidth
\AtBeginDocument{\Linewidth=\dimexpr\linewidth-2\fboxsep-2\fboxrule}

\newcommand*\journalname{Die \protect\TeX{}nische Kom\"odie}

\newcommand*\DTKyear{} \edef\DTKyear{\the\year}
\newcommand*\DTKmonth{0}
\newcommand*\DTKissue{0}
\newcommand*\DTKvolume{??}
\newcommand*\DTKdate{?/??}
\newcommand*\DTKcorrVersion{\mbox{}}
\newcommand*\DTKfullIssue{\mbox{}}
\newcommand*\DTKissn{1434-5897}

\DeclareOptionX{Ausgabe}{\def\DTKissue{#1}}
\DeclareOptionX{Jahr}{\def\DTKyear{#1}}
\DeclareOptionX{Monat}{\def\DTKmonth{#1}}
\DeclareOptionX{korr}[true]{\csname DTK@korr@#1\endcsname}
\DeclareOptionX{full}[true]{\csname @tempswa#1\endcsname
  \if@tempswa\DTK@Author@false\else\DTK@Author@true\fi}
\DeclareOptionX{color}[true]{\csname DTKcolor#1\endcsname}
\DeclareOptionX{draft}{\PassOptionsToClass{\CurrentOption}{scrbook}}

\DeclareOptionX*{\OptionNotUsed}
\ProcessOptionsX\relax

\PassOptionsToPackage{paper=a5,pagesize}{typearea}

\newdimen\DTK@tempdima
\newdimen\DTK@tempdimb
\newdimen\DTK@tempdimc

\newcommand*\DTK@tempa{}
\newcommand*\DTK@tempb{}
\newcommand*\DTK@tempc{}

\newsavebox\DTK@tempbox

\LoadClass[%
,twoside
,fontsize=10pt
,captions=oneline
,parskip=full-
,headings=small
,open=any
,pagesize
]{scrbook}

\RequirePackage{scrhack}% Andere Pakete KOMA-Script-freundlich machen

\RequirePackage[final]{listings}

\RequirePackage{hvextern}

% http://www.komascript.de/release3.18
\Ifstr{\KOMAScriptVersion}{2015/07/02 v3.18 KOMA-Script}{%
  \ifx\par@update\default@par@update\else
    \AtBeginDocument{\par@updaterelative}%
  \fi
}{}

\AtEndOfClass{%
  \InputIfFileExists{dtk.cfg}{}{}%
}

% *** Konstanten ***

\ifDTK@Author@\else\setcounter{errorcontextlines}{100}\fi

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

\setlength\textfloatsep{10.0pt plus 1pt minus 1pt}
\setlength\intextsep{6.0pt plus .5pt minus .5pt} 

\setcounter{secnumdepth}{\numexpr\partnumdepth-1\relax}
\ifDTK@Author@\else\setcounter{tocdepth}{\chapternumdepth}\fi

\@fptop=\z@
\renewcommand\topfraction{.9}
\renewcommand\bottomfraction{.9}
\renewcommand\textfraction{.1}

\RequirePackage[english,main=ngerman]{babel}

\defineshorthand{"|}{%
  \ClassError{dtk}{%
    Shorthand `\string"|' wird nicht unterstützt! Entferne `\string"|'%
  }{}%
}

\newcommand*\DTK@FontNameMissing{%
  \ClassError{dtk}{%
    Eines der Makros `\string\DTKrmFontName', `\string\DTKsfFontName',
    \MessageBreak
    `\string\DTKttFontName' oder `\string\DTKmathFontName'
    \MessageBreak
    ist nicht korrekt definiert%
  }{}%
}
\newcommand*\DTKrmFontName{}   \let\DTKrmFontName=\DTK@FontNameMissing
\newcommand*\DTKsfFontName{}   \let\DTKsfFontName=\DTK@FontNameMissing
\newcommand*\DTKttFontName{}   \let\DTKttFontName=\DTK@FontNameMissing
\newcommand*\DTKmathFontName{} \let\DTKmathFontName=\DTK@FontNameMissing

\input{dtk-fonts.clo}

\@ifpackagelater{csquotes}{2018/02/11}{}{%
  \def\@inpenc@undefined{}
}
\RequirePackage[autostyle=true,german=guillemets,maxlevel=3]{csquotes}%
\MakeAutoQuote{»}{«}
\defineshorthand{"`}{\openautoquote}%
\defineshorthand{"'}{\closeautoquote}%

\iftrue
  \newcommand*\EURO@scale@to@rm[2]{%
    \begingroup
    \fontsize{10}{0}\usefont{\encodingdefault}{\rmdefault}{m}{n}%
    #1%
    \xdef\eurosym@@Scale{%
      \strip@pt
      \dimexpr  1pt * \@tempdima / \dimexpr#2pt\relax }%
    \ClassInfo{dtk}{The eurosym family is scaled by \eurosym@@Scale}%
    \endgroup
  }
  \EURO@scale@to@rm{\setbox0\hbox{C}\@tempdima=\ht0}{6.92}% matchuppercase
  % Extrakt aus "eurosym.sty"
  \DeclareFontFamily{U}{DTK@eurosym}{}
  \DeclareFontShape{U}{DTK@eurosym}{m}{n}{ <-> s*[\eurosym@@Scale] feymr10 }{}
  \DeclareFontShape{U}{DTK@eurosym}{m}{sc}{ <-> s*[\eurosym@@Scale] ssub*DTK@eurosym/m/n }{}
  \DeclareFontShape{U}{DTK@eurosym}{m}{sl}{ <-> s*[\eurosym@@Scale] feymo10 }{}
  \DeclareFontShape{U}{DTK@eurosym}{m}{it}{ <-> s*[\eurosym@@Scale] ssub*DTK@eurosym/m/sl }{}
  \DeclareFontShape{U}{DTK@eurosym}{m}{ol}{ <-> s*[\eurosym@@Scale] feyml10 }{}
  \DeclareFontShape{U}{DTK@eurosym}{bx}{n}{ <-> s*[\eurosym@@Scale] feybr10 }{}
  \DeclareFontShape{U}{DTK@eurosym}{bx}{sc}{ <-> s*[\eurosym@@Scale] ssub*DTK@eurosym/bx/n }{}
  \DeclareFontShape{U}{DTK@eurosym}{bx}{sl}{ <-> s*[\eurosym@@Scale] feybo10 }{}
  \DeclareFontShape{U}{DTK@eurosym}{bx}{it}{ <-> s*[\eurosym@@Scale] ssub*DTK@eurosym/bx/sl }{}
  \DeclareFontShape{U}{DTK@eurosym}{bx}{ol}{ <-> s*[\eurosym@@Scale] feybl10 }{}
  \DeclareFontShape{U}{DTK@eurosym}{b}{n}{ <-> s*[\eurosym@@Scale] ssub*DTK@eurosym/bx/n }{}
  \DeclareFontShape{U}{DTK@eurosym}{b}{sl}{ <-> s*[\eurosym@@Scale] ssub*DTK@eurosym/bx/sl }{}
  \DeclareFontShape{U}{DTK@eurosym}{b}{it}{ <-> s*[\eurosym@@Scale] ssub*DTK@eurosym/bx/sl }{}
  \DeclareFontShape{U}{DTK@eurosym}{b}{sc}{ <-> s*[\eurosym@@Scale] ssub*DTK@eurosym/bx/n }{}
  \DeclareFontShape{U}{DTK@eurosym}{b}{ol}{ <-> s*[\eurosym@@Scale] ssub*DTK@eurosym/bx/ol }{}
  \DeclareRobustCommand\DTK@euro{{\fontencoding{U}\fontfamily{DTK@eurosym}\selectfont{}e}}
\else
  % Sobald das Paket Skalierung unterstützt
  \RequirePackage[right,scaled]{eurosym}
%%%\DeclareRobustCommand\DTK@euro{\scalebox{0.9}{\officialeuro}}
\fi

\let\texteuro=\DTK@euro

\ifxetex\else
\RequirePackage[%
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
,sorting=nyt
,sortlocale=auto
,backend=biber
]{biblatex}

\let\ORIGprintbibliography\printbibliography
\g@addto@macro\bibsetup{\RaggedRight}

%\RequirePackage{etex} % ???
\RequirePackage{ragged2e}
\RequirePackage{hvlogos}

\renewcommand\title[2][]{%
  \gdef\@title{#2}%
  \ifx\relax#1\relax\gdef\@@title{#2}\else\gdef\@@title{#1}\fi%
}

\let\DTK@thispagestyle=\thispagestyle

\newcommand*\DTK@Author@list@content{}
\newcommand\DTK@Author@list@exec{%
  \DTK@Author@list@content
  \global\let\DTK@Author@list@content=\@empty
}
\newcommand\DTK@maketitle[1][]{%
  \begingroup
    \dimen0=\textheight
    \advance\dimen0 by -\pagetotal
    \ifdim\dimen0<.2\textheight
      \newpage
    \fi
  \endgroup
  \def\and{\end{tabular}, \begin{tabular}[t]{@{}c@{}}}%
  \leavevmode% erzwingt \everypar (speziell: \DTK@Author@list@exec)
  \vspace*{-8mm}%
  \addchap[\@@title]{\@title}%
  \begingroup
    \usekomafont{author}\lineskip 0.75em %
    \begin{tabular}[t]{@{}c@{}}\@author\end{tabular}\par\medskip
  \endgroup
  \@thanks
  \global\let\@thanks=\@empty
  \global\let\@title=\@empty
  \global\let\@author=\@empty
  \global\let\@thanks=\@empty
  \global\let\and\relax
  \global\let\DTK@license=\@empty
}

\renewcaptionname{ngerman}{\bibname}{Literatur und Software}
\defbibheading{dtk}{\section{\bibname}}

\RequirePackage[automark,draft=false]{scrlayer-scrpage}
\pagestyle{scrheadings}
\clearpairofpagestyles
% https://komascript.de/node/2177
\ihead{\Ifstr{\righttopmark}{\rightbotmark}{\leftmark}{}}
\ohead{\Ifstr{\righttopmark}{\rightbotmark}{\pagemark}{}}
\ofoot*{\normalsize\DTKcorrVersion}
\ifoot*{\journalname~~\DTKdate}
\automark[chapter]{chapter}

\newcommand*\DTK@license{}
\newcommand*\license[1]{%
  \gdef\DTK@license{#1}%
}
\iffalse
\RedeclareSectionCommand[%
  ,style=part
  %,indent=\z@
  ,beforeskip=40mm
  ,afterskip=60mm %
  ,pagestyle=plain.scrheadings
  %,innerskip=\z@
]{part}
\fi

\RedeclareSectionCommand[%
  ,style=section
  ,indent=\z@
  ,beforeskip=-2\baselineskip \@plus -.2\baselineskip \@minus -.2\baselineskip
  ,afterskip=.4\baselineskip \@plus .04\baselineskip \@minus .04\baselineskip
]{chapter}

\RedeclareSectionCommand[%
  ,beforeskip=-2.4ex \@plus -1ex \@minus -.2ex % Betrag ist von Bedeutung!
  ,afterskip=0.8ex \@plus .1ex \@minus .1ex %
]{section}

\RedeclareSectionCommand[%
  ,afterskip=0.8ex \@plus .1ex %
]{subsection}

\RequirePackage{xcolor}

\ifDTKcolor
  \colorlet{DTK@marker}{red!30}
  \definecolor{DTK@fancy}{rgb}{.72,.525,.044}
\else
  \colorlet{DTK@marker}{black!20}
  \colorlet{DTK@fancy}{black!60}
\fi

\colorlet{DTKlstBackground}{black!5}
\colorlet{DTKlstKeys}{black}
%\colorlet{DTKlstIdentifiers}{black}
\colorlet{DTKlstComments}{black}
\colorlet{DTKlstStrings}{black}
\colorlet{DTKlstNumbers}{black}
\newcommand*\DTKlstKeywordfont{\bfseries}

\@ifundefined{ifDTKrecord}{\newif\ifDTKrecord \DTKrecordfalse}{}

\newcommand*\address[3]{%
  \ClassError{dtk}{%
    Das Makro \string\address\space existiert nicht mehr!\MessageBreak
    Nimm stattdessen \string\Author%
    \string{Vorn.\string}\string{Nachn.\string}\string{Adr.\string}}{}%
}%
\def\author#1{%
  \ClassError{dtk}{%
    Das Makro \string\author\space existiert nicht mehr!\MessageBreak
    Nimm stattdessen \string\Author%
    \string{Vorn.\string}\string{Nachn.\string}\string{Adr.\string}}{}%
}%

% Sternform: Autor-Eintrag im Verzeichnis, aber nicht im Artikel
\newcommand*\Author{% #1=Vorname, #2=Nachname, #3=Adresse
  \@ifstar\DTK@Author\DTK@@Author
}

\newcommand\DTK@Author[3]{}%

\newcommand\DTK@Author@article[3]{%
  \begingroup
    \ifx\@author\@empty\let\x=\@empty\else\def\x{\and}\fi
    \expandafter\g@addto@macro\expandafter\@author\expandafter{\x #1 #2}%
  \endgroup
}%

\let\@author=\@empty

\ifDTK@Author@
  \input{dtk-author.clo}
\else
  \input{dtk-full.clo}
\fi

\AfterEndPreamble{% "etoolbox"
  \def\bibliography#1{%
    \ClassError{dtk}{%
      Das Makro `\string\bibliography' wird nicht unterstützt!\MessageBreak
      Verwende stattdessen `\string\addbibresource\string{#1.bib\string}'
      \MessageBreak
      und `\string\printbibliography' (siehe biblatex-Dokumentation)
    }{}%
  }%
}

%%%\ifDTKrecord \expandafter \endinput \fi % lohnt es?

\addtokomafont{caption}{%\RaggedRight
  \small}
\setkomafont{captionlabel}{\sffamily}
\setcapindent{0pt}
%\setcapwidth[c]{\textwidth}
\renewcaptionname{ngerman}{\figurename}{Abb.}
\renewcaptionname{ngerman}{\tablename}{Tab.}
\def\thefigure{\@arabic\c@figure}
\def\thetable{\@arabic\c@table}
\def\theequation{\@arabic\c@equation}
\def\thelstlisting{\@arabic\c@lstlisting}

\setkomafont{disposition}{\normalfont\sffamily}
\setkomafont{part}{\usekomafont{disposition}\huge}
\setkomafont{chapter}{\usekomafont{disposition}\Large}
\setkomafont{section}{\usekomafont{disposition}\large}
\setkomafont{pagenumber}{\normalfont\sffamily}
\setkomafont{pagehead}{\sffamily\slshape}% \itshape?
\setkomafont{pagefoot}{\footnotesize\sffamily\slshape}% \itshape?
\setkomafont{author}{\usekomafont{section}}

\RequirePackage{marginnote}
\renewcommand*{\marginfont}{\normalfont\itshape\small} 
\renewcommand*{\sectionlinesformat}[4]{%
  % reagiert auf \addchap in \maketitle (wegen "style=section")
  \@hangfrom{%
    \ifx\DTK@license\@empty\else
      \marginnote{\rotatebox{90}{\makebox[.5em][r]{%
        Lizenz:~\DTK@license
      }}}%
    \fi
    \hskip #2#3%
  }{#4}%
}

%\addtokomafont{footnote}{\RaggedRight}
\deffootnote[1.2em]{1.2em}{1.2em}{\textsuperscript{\thefootnotemark}\,}
\newcommand*\DTK@footnote{}
\let\DTK@footnote=\footnote
\newcommand*\DTK@@footnote[2][]{%
  \edef\DTK@tempa{\ifx\relax#1\relax\else[#1]\fi}%
  \expandafter\DTK@footnote\DTK@tempa{\RaggedRight #2}%
}
\def\footnote{%
  \@ifstar\DTK@@footnote\DTK@footnote
}
%\setfootnoterule{.15\textwidth}

\RequirePackage{enumitem}
\setlist{leftmargin=*,nosep}
\setlist[1]{labelindent=1em}
\iffalse
\setlist[itemize,1]{label=\raisebox{-.1ex}{\Large\textbullet}}
\setlist[itemize,2]{label=\raisebox{-.1ex}{\Large$\m@th\circ$}}
\setlist[itemize,3]{label=\raisebox{-.7ex}{\large\textasteriskcentered}}
\setlist[itemize,4]{label=\raisebox{.4ex}{\tiny$\m@th\triangleright$}}
\fi

\PassOptionsToPackage{hyphens}{url}
\RequirePackage{dtk-url}
\RequirePackage{hvqrurl}%   Spät laden!

% Listings
\newcommand*\DTKlstfont{\small\ttfamily}

\let\lstlisting=\relax
\let\lstlisting@=\relax
% Correct wrong vertical spaces
\lstnewenvironment{lstlisting}[2][]{%
  %%%%\leavevmode%
  \lst@TestEOLChar{#2}%
  \lstset{#1}%
  \csname\@lst @SetFirstNumber\endcsname
}{\csname\@lst @SaveFirstNumber\endcsname}

% siehe ggf.: https://github.com/jez/latex-solarized

\lstdefinestyle{DTKlstSimple0}{%
,basicstyle=\DTKlstfont
,numbers=none
,backgroundcolor={}
,tabsize=2
,frame=none
}

\lstdefinestyle{DTKlstVerbatim}{
,style=DTKlstSimple0
,aboveskip=\smallskipamount
,belowskip=0pt plus .25pt minus .25pt %
}

\lstdefinestyle{DTKlstSimple1}{%
,style=DTKlstSimple0
,identifierstyle=\DTKlstfont
,stringstyle=\DTKlstfont
,commentstyle=\DTKlstfont
,basewidth=0.55em
,keepspaces
,backgroundcolor=\color{DTKlstBackground}
,numbers=none
,frame=single
,framesep=\fboxsep
,aboveskip=\medskipamount
,belowskip=1pt plus .5pt minus .5pt %
,xleftmargin=\fboxsep
,xrightmargin=\fboxsep
}

\newcommand*\DTK@lst@colorbox[2]{%
  \fboxsep=.3em %
  \settowidth\DTK@tempdima{#2}\settoheight\DTK@tempdimb{#2}%
  \makebox[\DTK@tempdima][c]{\colorbox{#1}{%
    \raisebox{0pt}[\DTK@tempdimb][\z@]{#2}}}%
}

\lstdefinestyle{DTKlstBase}{%
,style=DTKlstSimple1
%,identifierstyle=\color{DTKlstIdentifiers}
,keywordstyle=\DTKlstKeywordfont
,stringstyle=\itshape\color{DTKlstStrings}
,commentstyle=\itshape\color{DTKlstComments}
,columns=fullflexible
%,extendedchars=true
,showspaces=false
,showstringspaces=false
,breaklines=true
,breakindent=0.5em
,breakautoindent=true
,breakatwhitespace=false  % ???
,captionpos=t
,emphstyle=\DTK@lst@colorbox{DTKlstBackground!70!-DTKlstBackground}%
%,prebreak=
,postbreak=\mbox{$\hookrightarrow$}
}

\lstdefinestyle{number}{%  TODO: Evtl. doch besser Zeilennummern ganz ausrücken?
,style=DTKlstBase
,numbers=left
,numberstyle=\tiny\ttfamily
,numbersep=1.3em
,xleftmargin=1.5em
}

\lstdefinestyle{noNumber}{%
,style=DTKlstBase
,numbers=none
,xleftmargin=\fboxsep % ???
}

\lstset{style=noNumber}

% see: https://tex.stackexchange.com/questions/25391/the-listings-package-and-utf-8/25396#25396
\lst@InputCatcodes
\def\lst@DefEC{%
  \lst@CCECUse \lst@ProcessLetter
  ^^80^^81^^82^^83^^84^^85^^86^^87^^88^^89^^8a^^8b^^8c^^8d^^8e^^8f%
  ^^90^^91^^92^^93^^94^^95^^96^^97^^98^^99^^9a^^9b^^9c^^9d^^9e^^9f%
  ^^a0^^a1^^a2^^a3^^a4^^a5^^a6^^a7^^a8^^a9^^aa^^ab^^ac^^ad^^ae^^af%
  ^^b0^^b1^^b2^^b3^^b4^^b5^^b6^^b7^^b8^^b9^^ba^^bb^^bc^^bd^^be^^bf%
  ^^c0^^c1^^c2^^c3^^c4^^c5^^c6^^c7^^c8^^c9^^ca^^cb^^cc^^cd^^ce^^cf%
  ^^d0^^d1^^d2^^d3^^d4^^d5^^d6^^d7^^d8^^d9^^da^^db^^dc^^dd^^de^^df%
  ^^e0^^e1^^e2^^e3^^e4^^e5^^e6^^e7^^e8^^e9^^ea^^eb^^ec^^ed^^ee^^ef%
  ^^f0^^f1^^f2^^f3^^f4^^f5^^f6^^f7^^f8^^f9^^fa^^fb^^fc^^fd^^fe^^ff%
  ^^^^20ac^^^^0153^^^^0152%
  ^^^^0131% small letter dotless i
  ^^^^017f% latin small letter long s
  ^^^^03b1% greek small letter alpha
  ^^^^03b2% greek small letter beta
  ^^^^03b3% greek small letter gamma
  ^^^^2013% en dash
  ^^00%
}
\lst@RestoreCatcodes

% noHilit, latex ???

\ifDTKrecord\else% wegen Problem mit verbatim-Paket/dtkGLOBAL
\let\verbatim=\relax
\let\verbatim@=\relax
\lstnewenvironment{verbatim}
{\lstset{style=DTKlstVerbatim,language={}}}{}
\fi

\newlength\fullwidth
\setlength\fullwidth{\dimexpr\textwidth+\marginparwidth+\marginparsep\relax}
\newenvironment{Figure}[2][\fullwidth]
  {\figure[htb!]\setlength\columnsep{1.5em}%
   \captionbeside{#2}[o][#1][0pt]*}%
  {\endcaptionbeside\endfigure}
\newenvironment{Table}[2][\fullwidth]
  {\table[htb!]\setlength\columnsep{1.5em}%
   \begincaptionbeside{#2}[o][#1][0pt]*}%
  {\endcaptionbeside\endtable}

\newenvironment{abstract}
  {\quote\small}{\endquote\medskip\par}

\NewDocumentCommand\Macro{m}{\texttt{\textbackslash#1}}
\NewDocumentCommand\Code{m}{\texttt{#1}}
\NewDocumentCommand\Command{m}{\texttt{#1}}
\NewDocumentCommand\Environment{m}{\texttt{#1}}
\DeclareDocumentCommand\biblatex{m}{\texttt{biblatex}\xspace}
%%%\NewDocumentCommand\tex4ht{m}{\hologo{TeX4ht}}
\NewDocumentCommand\Paket{m}{\texttt{#1}}
\NewDocumentCommand\Package{m}{\texttt{#1}}
\NewDocumentCommand\Programm{m}{\texttt{#1}}
\NewDocumentCommand\Program{m}{\texttt{#1}}
\NewDocumentCommand\Env{m}{\texttt{#1}}
\NewDocumentCommand\Class{m}{\texttt{#1}}
\NewDocumentCommand\Klasse{m}{\texttt{#1}}

\endinput
