
\listfiles
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\RequirePackage{hyphsubst}% Trennregeln austauschen
\HyphSubstIfExists{ngerman-x-latest}{%
  \HyphSubstLet{ngerman}{ngerman-x-latest}}{}
\HyphSubstIfExists{german-x-latest}{%
  \HyphSubstLet{german}{german-x-latest}}{}

\ProvidesClass{dtk2}%
  [2015/05/02 v0.1a dtk document class (RN)]

\RequirePackage{ifxetex,ifluatex,ifpdf,ifvtex}
\newcommand*\DTK@engine{}
\ifxetex
  \def\DTK@engine{3}% XeTeX
\else
  \ifluatex
    \def\DTK@engine{4}% LuaTeX
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

\DeclareOption{10pt}{\OptionNotUsed}
\DeclareOption{11pt}{\OptionNotUsed}
\DeclareOption{12pt}{\OptionNotUsed}
\DeclareOption{twoside}{\OptionNotUsed}
\DeclareOption{oneside}{\OptionNotUsed}
\DeclareOption{full}{\DTK@Author@false}
\DeclareOption{draft}{\PassOptionsToClass{scrbook}}
%\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}%
\DeclareOption*{\OptionNotUsed}
\ProcessOptions\relax
\PassOptionsToPackage{paper=a4,pagesize,twoside=false,headinclude}{typearea}
\LoadClass[
,fontsize=10pt
]{scrbook}

\ifDTK@Author@\setcounter{errorcontextlines}{100}\fi

\paperwidth  = 148mm %
\paperheight = 210mm %
\textheight = 485pt %
\textwidth  = 333pt %
\oddsidemargin  = -35.89157pt %
\evensidemargin = -17.70235pt %
\topmargin  = -55.66684pt %
\headheight = 17pt %
\headsep    = 17pt %
\footskip = 24pt %
\parskip   = 0.3\baselineskip
\advance\parskip by 0pt plus 2pt %
\parindent = 0pt %
\renewcommand\topfraction{.9}
\renewcommand\bottomfraction{.9}
\renewcommand\textfraction{.1}
\columnsep = 5pt %
\emergencystretch = 1.5em %
\raggedbottom
\clubpenalty  = 10000 %
\widowpenalty = 10000 %
\marginparwidth = 1cm %

\@fptop= \z@{}

\let\DTK@tempdima=\@ovxx
\let\DTK@tempdimb=\@ovyy

\RequirePackage{xcolor}
\RequirePackage{etex}

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
\AtEndOfClass{\shorthandon{"}}

\AtBeginDocument{%
  \ifDTK@Author@\else
    \InputIfFileExists{userpackages.tex}{%
      \typeout{*************************************^^J%
               * File `userpackages.tex' used.^^J%
               *************************************}%
    }{}%
  \fi
}

%%% Laden eines Einzeldokuments

\newcommand*\DTK@embedded@documentclasshook{}
\newcommand*\AtEmbeddedDocumentclass{%
  \g@addto@macro\DTK@embedded@documentclasshook}
\AtEmbeddedDocumentclass{%
  \edef\jobname{\DTK@local@jobname}%
}
\newcommand*\DTK@embedded@begindocumenthook{}
\newcommand*\AtEmbeddedBeginDocument{%
  \g@addto@macro\DTK@embedded@begindocumenthook}
\newcommand*\DTK@embedded@enddocumenthook{}
\newcommand*\AtEmbeddedEndDocument{%
  \g@addto@macro\DTK@embedded@enddocumenthook}

%%%\ifDTK@Author@\edef\DTK@jobname{komoedie}\else\edef\DTK@jobname{\jobname}\fi

\newcommand*\DTK@jobname{}
\newcommand*\DTK@local@jobname{}
\newcommand*\DTK@local@inputname{}
\newcommand*\DTK@eat@version[1][]{\ignorespaces}

\@ifundefined{ifDTKrecordPackages}{%
  \newif\ifDTKrecordPackages \DTKrecordPackagesfalse}{}
\ifDTKrecordPackages
  \@ifdefinable\User@Packages{%
    \newwrite\User@Packages
    \immediate\openout\User@Packages userpackages.tex\relax
    \newcommand*\RecordPackage[4]{%
      \immediate\write\User@Packages{%
        \string\usepackage\ifx\relax#1\relax\else[#1]\fi{#2}%
          \ifx\relax#3\relax\else[#3]\fi\@percentchar\space From file: #4}%
    }%
    \AtEndDocument{\immediate\closeout\User@Packages\relax}%
  }
\else
  \newcommand*\RecordPackage[4]{}
\fi

\newcommand*\DTK@usepackage[2][]{%
  \@ifnextchar[%]
    {\DTK@@usepackage{#1}{#2}}%
    {\DTK@@usepackage{#1}{#2}[]}%
}%
\newcommand*\DTK@@usepackage{}
\def\DTK@@usepackage#1#2[#3]{%
  \edef\@tempb{\zap@space#2 \@empty}%
  \@for\@tempa:=\@tempb\do{%
    \RecordPackage{#1}\@tempa{#3}\DTK@local@inputname
  }
}%

\newcommand*\DTK@AtBeginDocument[1]{%
  \ClassWarning{dtk2}{\string\AtBeginDocument\space ignored!}
}
\newcommand*\DTK@AtEndDocument[1]{%
  \ClassWarning{dtk2}{\string\AtEndDocument\space ignored!}
}

\newcommand*\DTK@documentclass[2][]{%
  \DTK@embedded@documentclasshook
  \DTK@eat@version
}

\newcommand*\DTKinput[1]{%
  \begingroup
    \filename@parse{#1}%
    \edef\DTK@local@jobname{\filename@base}%
    \@ifundefined{filename@ext}%
      {\IfFileExists{\DTK@local@jobname.tex}%
        {\edef\DTK@local@inputname{\DTK@local@jobname.tex}}{}}%
      {\edef\DTK@local@inputname{#1}}%
    \let\AtBeginDocument=\DTK@AtBeginDocument
    \let\AtEndDocument=\DTK@AtEndDocument
    \let\pagestyle\@gobble
    \let\thispagestyle\@gobble
    \let\nocite\@gobble
    \let\listfiles\relax
    \let\nofiles\relax
    \let\documentclass=\DTK@documentclass
    \let\usepackage=\DTK@usepackage
    \renewenvironment*{document}%
      {\DTK@embedded@begindocumenthook}%
      {\DTK@embedded@enddocumenthook\endinput}%
    \input{\DTK@local@inputname}%
  \endgroup
}

\newcommand*\DTK@keywords{}
\newcommand*\keywords[1]{\gdef\DTK@keywords{#1}}
\newcommand\address[3]{%
}

% Kompakte Listen
\RequirePackage[neverdecrease]{paralist}
\newcommand*\DTK@begin@list[1]{%
  \DTK@tempdima=\parindent
  \DTK@tempdimb=\parskip
  \@nameuse{#1}%
  \parindent=\DTK@tempdima
  \parskip=\DTK@tempdimb
}
\def\enumerate{%
  \DTK@begin@list{compactenum}%
}
\def\itemize{%
  \DTK@begin@list{compactitem}%
}
\def\description{%
  \DTK@begin@list{compactdesc}%
}
\let\enditemize\endcompactitem
\let\endenumerate\endcompactenum
\let\enddescription\endcompactdesc
\pltopsep=\medskipamount
\plitemsep=1pt %
\plparsep=1pt %

\endinput
