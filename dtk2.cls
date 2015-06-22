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

\endinput
