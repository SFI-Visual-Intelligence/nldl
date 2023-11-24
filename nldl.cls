\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nldl}[NLDL Style Class]

%% Setup the class
\newif\ifabstract
\newif\iffinal

% Default full paper
\abstractfalse
% Default draft (no final)
\finalfalse

%% Options
\DeclareOption{abstract}{\abstracttrue}
\DeclareOption{fullpaper}{\abstractfalse}
\DeclareOption{final}{\finaltrue}
\DeclareOption{review}{\finalfalse}

\DeclareOption{onecolumn}{\OptionNotUsed}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[10pt,twocolumn,a4paper]{article}


%% Data holders
\newcommand{\paperID}[1]{\def\@paperID{#1}}
\newcommand{\confYear}[1]{\def\@confYear{#1}\updateNum}
\newcommand{\confNum}[1]{\def\@confNum{#1}}
\newcommand{\vol}[1]{\def\@vol{#1}}

\paperID{\#\#\#}
\vol{V}
\newcommand{\@confName}{NLDL}


\RequirePackage{pgfmath}
% Set the conference year to next year from current date
\pgfmathsetmacro{\@confYear}{int(\the\year+1)}
\newcommand{\updateNum}{\pgfmathsetmacro{\@confNum}{int(\@confYear-2019)}}
\updateNum

\newcommand{\@type}{\ifabstract Abstract\else Full Paper\fi}

%% Setup
\RequirePackage[dvipsnames, table]{xcolor}


%% Paper setup
\RequirePackage{geometry}
\geometry{margin=2.5cm}


%% Title

% author setup
\RequirePackage{authblk}
\renewcommand\Affilfont{\small}

\RequirePackage{tcolorbox}
\tcbuselibrary{skins}

\def\@maketitle{
  \begin{tcolorbox}[blanker,
    borderline west={2pt}{0pt}{black!75},
%    borderline north={2pt}{-10pt}{black}, borderline south={2pt}{-10pt}{black},
    left=10pt]
      \vspace*{10pt}
      {\Large \bf \@title\par}
      \vspace*{24pt}
      \iffinal\@author\else%
      Anonymous \@type\\
      Submission~\@paperID \fi
  \end{tcolorbox}
  \vspace*{15pt}
}

\RequirePackage{fancyhdr}% http://ctan.org/pkg/fancyhdr
\RequirePackage{etoolbox}

\newcommand\nomarkfootnote[1]{%
  \begingroup
  \renewcommand\thefootnote{}\footnote{#1}%
  \addtocounter{footnote}{-1}%
  \endgroup
}

\newcommand\flushnomarkfootnote[1]{%
  \begingroup
  \renewcommand\thefootnote{}\footnote{\hspace*{-1.8em}#1}%
  \addtocounter{footnote}{-1}%
  \endgroup
}


\ifabstract
\else
  \iffinal
    \RequirePackage{nth}
    \RequirePackage{fontawesome5}
    % Clean the authors from authblk
    % https://tex.stackexchange.com/a/620322/7561
    \newcommand*{\AB@cleanauthors}{%
      \begingroup
      \renewcommand\footnotemark[1][]{}% ignore \footnotemark
      \let\footnote\@gobble% ignore \footnote
      \let\thanks\@gobble% ignore \thanks
      \let\textsuperscript\@gobble% ignore protected \textsuperscript
      \expandafter\let\csname textsuperscript \endcsname\@gobble
      \let\Authfont\relax% do not use a special font
      \def\Authand{ \& }% shorten the and
      \def\Authands{, \& }% shorten the and with more than one
%      \ifnum\value{authors}<3 % one ore two authors
      \AB@authlist% show them all
%      \else% 3 or more authors
%      \ABgetauthor{1}\,et~al.
%      \fi
      \endgroup
    }

    \fancyhf{}% Clear all headers/footers
    \renewcommand{\headrulewidth}{0pt}% No header rule
    \renewcommand{\footrulewidth}{0pt}% No footer rule
    \lfoot{\scriptsize%
      Proceedings of the \nth{\@confNum} Northern Lights Deep Learning Conference (NLDL), PMLR~\@vol,  \@confYear.\newline\faIcon{creative-commons}\,\faIcon{creative-commons-by}\space\@confYear\space\AB@cleanauthors.  This is an open access article distributed under the terms and conditions of the Creative Commons Attribution license (\url{http://creativecommons.org/licenses/by/4.0/}).}
    % set the fancy style from the title as well
    \apptocmd{\maketitle}{\thispagestyle{fancy}}{}{}
  \fi
\fi


%% Define linenumber setup
\RequirePackage[switch, mathlines]{lineno}

% Number setup from ICCV/CVPR
% NUMBER with left flushed zeros  \fillzeros[<WIDTH>]<NUMBER>
\newcount\cv@tmpc@ \newcount\cv@tmpc
\def\fillzeros[#1]#2{\cv@tmpc@=#2\relax\ifnum\cv@tmpc@<0\cv@tmpc@=-\cv@tmpc@\fi
  \cv@tmpc=1 %
  \loop\ifnum\cv@tmpc@<10 \else \divide\cv@tmpc@ by 10 \advance\cv@tmpc by 1 \fi
  \ifnum\cv@tmpc@=10\relax\cv@tmpc@=11\relax\fi \ifnum\cv@tmpc@>10 \repeat
  \ifnum#2<0\advance\cv@tmpc1\relax-\fi
  \loop\ifnum\cv@tmpc<#1\relax0\advance\cv@tmpc1\relax\fi \ifnum\cv@tmpc<#1 \repeat
  \cv@tmpc@=#2\relax\ifnum\cv@tmpc@<0\cv@tmpc@=-\cv@tmpc@\fi \relax\the\cv@tmpc@}%

\renewcommand\thelinenumber{\fillzeros[3]{\arabic{linenumber}}}
\renewcommand\linenumberfont{\scriptsize\ttfamily\color{NavyBlue}}

\iffinal
\else
\linenumbers
\fi

% Shipout following the logic from ICCV/CVPR
\RequirePackage{eso-pic}
\AddToShipoutPicture{%
  \iffinal\else%
    \color{NavyBlue}%
    \def\pid{\parbox{1in}{\begin{center}\scriptsize\bf\sf{\@confName}\\\#\@paperID\end{center}}}%
    \AtTextUpperLeft{%paperID in corners
      \put(\LenToUnit{-65pt},\LenToUnit{1cm}){\pid}
      \put(\LenToUnit{\textwidth\kern-8pt},\LenToUnit{1cm}){\pid}
    }%
    \AtTextUpperLeft{%confidential
      \put(0,\LenToUnit{1cm}){\parbox{\textwidth}{\centering\ttfamily\scriptsize\@confName~\@confYear\quad \@type~Submission \#\@paperID. CONFIDENTIAL REVIEW COPY.  DO NOT DISTRIBUTE.}}
    }%
  \fi
}


%% Floats
% Caption setup
\RequirePackage[labelformat=simple]{subcaption}% note that the format needs to be on the package itself, and not on the caption setup
\captionsetup{font=small, labelfont={bf}, labelsep=period}
\renewcommand\thesubfigure{(\alph{subfigure})}
\renewcommand\thesubtable{(\alph{subtable})}


%% Extra macros
\RequirePackage{xspace}
\DeclareRobustCommand\onedot{\futurelet\@let@token\@onedot}
\def\@onedot{\ifx\@let@token.\else.\null\fi\xspace}

\def\eg{e.g\onedot} \def\Eg{E.g\onedot}
\def\ie{i.e\onedot} \def\Ie{I.e\onedot}
\def\cf{cf\onedot} \def\Cf{Cf\onedot}
\def\aka{a.k.a\onedot} \def\Aka{A.k.a\onedot}
\def\etc{etc\onedot} \def\vs{vs\onedot}
\def\iid{i.i.d\onedot} \def\wolog{w.l.o.g\onedot}
\def\wrt{w.r.t\onedot} \def\dof{d.o.f\onedot}
\def\etal{et al\onedot}
\def\adhoc{ad hoc\xspace}

%% Citations
\RequirePackage[
backend=biber,% you can change the backend to "bibtex" as well (remember to change the tool chain to use the correct backend)
style=numeric-comp,
sorting=noneyear,
natbib=true, % add citep and citet
maxbibnames=99, % authors on bibliography
maxcitenames=2, % authors on citations
giveninits=true, % abbreviate the authors names, i.e., put only the initials
]{biblatex}

% Sorts by appearance globally and by year within the citation
% https://tex.stackexchange.com/a/55451/7561
\DeclareSortingTemplate{noneyear}{
  \sort{\citeorder}
  \sort{\field{year}}
  \sort{\field{author}}
}

% Change the normal space to a non-breaking one between the names and the reference
% https://tex.stackexchange.com/a/74932/7561
\renewcommand\namelabeldelim{\addnbspace}

% genetive citations (possessives)
% https://tex.stackexchange.com/a/307461/7561
\DeclareNameFormat{labelname:poss}{% Based on labelname from biblatex.def
  \nameparts{#1}% Not needed if using Biblatex 3.4
  \ifcase\value{uniquename}%
  \usebibmacro{name:family}{\namepartfamily}{\namepartgiven}{\namepartprefix}{\namepartsuffix}%
  \or
  \ifuseprefix
  {\usebibmacro{name:first-last}{\namepartfamily}{\namepartgiveni}{\namepartprefix}{\namepartsuffixi}}
  {\usebibmacro{name:first-last}{\namepartfamily}{\namepartgiveni}{\namepartprefixi}{\namepartsuffixi}}%
  \or
  \usebibmacro{name:first-last}{\namepartfamily}{\namepartgiven}{\namepartprefix}{\namepartsuffix}%
  \fi
  \usebibmacro{name:andothers}%
  \ifnumequal{\value{listcount}}{\value{liststop}}{'s}{}}
\DeclareFieldFormat{shorthand:poss}{%
  \ifnameundef{labelname}{#1's}{#1}}
\DeclareFieldFormat{citetitle:poss}{\mkbibemph{#1}'s}
\DeclareFieldFormat{label:poss}{#1's}

\newrobustcmd*{\citealiaspos}{%
  \AtNextCite{%
    \DeclareNameAlias{labelname}{labelname:poss}%
    \DeclareFieldAlias{shorthand}{shorthand:poss}%
    \DeclareFieldAlias{citetitle}{citetitle:poss}%
    \DeclareFieldAlias{label}{label:poss}}}

\newrobustcmd*{\citepos}{%
  \citealiaspos%
  \textcite}

\newrobustcmd*{\Citepos}{\bibsentence\citepos}

\newrobustcmd*{\Citespos}{%
  \citealiaspos%
  \textcites}


%% Apendix
\RequirePackage{chngcntr}

\let\@oldappendix\appendix
\renewcommand{\appendix}{%
  \@oldappendix
  \counterwithin{figure}{section}
  \counterwithin{table}{section}
  \counterwithin{algorithm}{section}
}

%% Typesetting
\RequirePackage{microtype}
