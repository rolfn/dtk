
\listfiles
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\RequirePackage{hyphsubst}% Trennregeln austauschen
\HyphSubstIfExists{ngerman-x-latest}{%
  \HyphSubstLet{ngerman}{ngerman-x-latest}}{}
\HyphSubstIfExists{german-x-latest}{%
  \HyphSubstLet{german}{german-x-latest}}{}

\ProvidesClass{dtk2}%
  [2015/07/14 v0.1b dtk document class (RN)]

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

\LoadClass[
,fontsize=10pt
]{scrbook}

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

\@fptop=\z@
\renewcommand\topfraction{.9}
\renewcommand\bottomfraction{.9}
\renewcommand\textfraction{.1}

\RequirePackage{xcolor,listings,multicol}
%\RequirePackage{etex} % ???

\newdimen\DTK@tempdima
\newdimen\DTK@tempdimb
\newdimen\DTK@tempdimc

\newcommand*\DTK@tempa{}
\newcommand*\DTK@tempb{}

\ifnum\DTK@engine < 3 %
  \input{dtk2-old-engines.clo}% pdfTeX oder TeX+dvips oder VTeX
\else
  \input{dtk2-new-engines.clo}% LuaTeX oder XeTeX
\fi

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

\RequirePackage[main=ngerman]{babel}

\RequirePackage[autostyle=true,babel=once,german=guillemets,maxlevel=3]{csquotes}%
\MakeAutoQuote{»}{«}
\defineshorthand{"`}{\openautoquote}%
\defineshorthand{"'}{\closeautoquote}%

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

\begingroup
  \ifluatex
    \catcode`\%=12\relax
    \xdef\DTK@today{\directlua{tex.print(os.date("%Y-%m-%d %H:%M:%S"))}}
  \else
    \count@\time
    \divide\count@ 60 %
    \count2=-\count@
    \multiply\count2 60 %
    \advance\count2 \time
    \xdef\DTK@today{\the\year-\two@digits{\the\month}-\two@digits{\the\day} %
      \space\two@digits{\the\count@}:\two@digits{\the\count2}}
  \fi
\endgroup

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
  \DTK@embedded@documentclasshook
  \DTK@eat@version
}

\@ifundefined{ifDTKrecord}{\newif\ifDTKrecord \DTKrecordfalse}{}
\ifDTKrecord
  % Testlauf zum Aufsammeln von Paket- und bib-Dateinamen
  \@ifdefinable\User@Packages{%
    \newwrite\User@Packages
    \immediate\openout\User@Packages userpackages.tex\relax
    \immediate\write\User@Packages{\@percentchar\space *** \DTK@today\space ***}%
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
        \printbibliography
      }%
    }
  \else
    % Gesamtlauf
    \def\DTK@@usepackage#1#2[#3]{}%
    \newcommand*\DTK@addbibresource[2][]{}%
    \renewcommand*\printbibliography[1][]{\DTK@bib@true}%
    \newcommand*\DTK@bibliography[1]{\DTK@bib@true}%
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
      {\ifDTK@bib@\ORIG@printbibliography\fi
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

\c@secnumdepth=\z@
\c@tocdepth=\z@

\renewcommand\title[2][]{%
  \gdef\@title{#2}%
  \ifx\relax#1\relax\gdef\@@title{#2}\else\gdef\@@title{#1}\fi%
}

\renewcommand\maketitle[1][]{%
  %%%\ifDTK@Author@ \thispagestyle{part}\fi
  \begingroup % ???
    \dimen0=\vsize
    \advance\dimen0 by -\pagetotal
    %\ifdim\dimen0<\NewpageThreshold
    \ifdim\dimen0<100pt %
      \newpage
      %\global\FirstArticletrue
    \fi
  \endgroup
  %\Advance@Label@Prefix % ???
  \markboth{}{}%
  \begingroup
    \begin{minipage}{\textwidth}
      \raggedright
      %\TitleFont
      \@title
      \ifx\@author\@empty\else
        \bigskip\par
        %\AuthorFont
        \@author
      \fi
    \end{minipage}%
    \@thanks
    \let\thanks\@gobble
    \addcontentsline{toc}{chapter}{\@@title}%
    \markboth{\@@title}{\@@title}% ???
  \endgroup
  \let\@title=\@empty
  \let\@author=\@empty
  \let\@thanks=\@empty
  \medskip\par}

\newcommand*\addressname{Autoren/Organisatoren}

\RequirePackage[split,protected]{splitidx} \makeindex
%\newindex[\addressname]{addresses}
%\newindex[\listofplacesname]{places}
\newindex{addresses}
\edef\index@addresses@name{\addressname}

\newcommand*\listofaddresses{%
  \markboth{\addressname}{\addressname}%
  %\thispagestyle{empty}%
  \begingroup
    %\language\langwohyphens
    %\show\printsubindex
    \printsubindex[addresses]%
  \endgroup
}
%\newcommand\address[3]{}
\newcommand\address[3]{%\glossary{\STRIP@*#1 #2!#3}%
  \begingroup
  \let\url=\relax
  %\sindex[addresses]{#1 #2 #3}%
  %\catcode`\@=\active
  \sindex[addresses]{#2, #1@@#3}%
  \endgroup
}
\newcommand*{\indexdelim}{\ \hspace{0pt plus 1fil}\penalty100\null\dotfill~}
\renewcommand*\idx@heading{%
  \addchap{\indexname}%
  \markright{\indexname}%
  \ifx\index@preamble\relax
  \else\index@preamble\let\index@preamble=\relax\fi
}%
\renewenvironment{theindex}{%
  %\setchapterpreamble{\index@preamble}
  %\idx@heading
  %\index@preamble
  \columnseprule \z@
  %\columnsep 35\p@
  \columnsep 24\p@% 2em bei 12pt
  \begin{multicols}{2}[\idx@heading\vspace{-1\baselineskip}]%
  \parindent\z@
  \setlength{\parskip}{\z@ \@plus .3\p@}%
  \setlength{\parfillskip}{\z@ \@plus 1fil}%
  \let\item\@idxitem
  \renewcommand\subitem[1]{##1}%
  \small\raggedright
}{%
  \end{multicols}%
}

\let\lettergroup=\indexsection

\endinput
