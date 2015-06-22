\setcounter{errorcontextlines}{100}
\listfiles
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{dtk2}%
  [2015/05/02 v0.1a dtk document class (RN)]

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

\@fptop= \z@

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

\RequirePackage[lining=true]{libertine}

\ifnum\DTK@engine < 3 %
  \input{dtk2-old-engines.clo}% pdfTeX oder TeX+dvips oder VTeX
\else
  \input{dtk2-new-engines.clo}% LuaTeX oder XeTeX
\fi
{}

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
\AtEmbeddedEndDocument{\endinput}

\newcommand*\DTK@jobname{}
\newcommand*\DTK@local@jobname{}
\newcommand*\DTK@local@inputname{}
\newcommand*\DTK@eat@version[1][]{\ignorespaces}
\newcommand*\DTK@usepackage{}

\newcommand*\DTKinput[1]{%
  \begingroup
     \filename@parse{#1}%
     \edef\DTK@local@jobname{\filename@base}%
     \@ifundefined{filename@ext}%
     {\IfFileExists{\DTK@local@jobname.tex}%
       {\edef\DTK@local@inputname{\DTK@local@jobname.tex}}{}%
     }{\edef\DTK@local@inputname{#1}}%
    \renewcommand*\documentclass[2][]{%
      \DTK@embedded@documentclasshook
      \DTK@eat@version}%
    \renewcommand*\usepackage[2][]{%
      \@ifnextchar[%]
        {\DTK@usepackage{##1}{##2}}%
        {\DTK@usepackage{##1}{##2}[]}%
    }%
    \def\DTK@usepackage##1##2[##3]{%
      \edef\@tempb{\zap@space##2 \@empty}%
      \@for\@tempa:=\@tempb\do{\def\@tempb{inputenc}%
        \ifx\@tempa\@tempb
          \edef\@tempa{##1}%
          \ifx\@tempa\@empty\else\inputencoding{##1}\fi
        \else
%          \ifx\@tempa\@empty\else\usepackage{\@tempa}%
%             \RecordPackage{##1}\@tempa{##3}\DTK@local@inputname
%          \fi
        \fi}}%
    \let\pagestyle\@gobble
    \let\thispagestyle\@gobble
    \let\nocite\@gobble
    \let\listfiles\relax
    \let\nofiles\relax
    \renewcommand*\AtBeginDocument[1]{%
       \typeout{\string\AtBeginDocument\space ignored!}}
    \renewcommand*\AtEndDocument[1]{%
       \typeout{\string\AtEndDocument\space ignored!}}
    \renewenvironment*{document}%
    {\DTK@embedded@begindocumenthook}%
    {\DTK@embedded@enddocumenthook}%
    \input{\DTK@local@inputname}%
  \endgroup
}

\endinput
