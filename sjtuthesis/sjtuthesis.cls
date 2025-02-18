%%==================================================
%% SJTU Thesis Template
%%==================================================

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{sjtuthesis}[2021/03/13 v0.20 SJTU Thesis Template]

\newif\ifsjtu@english\sjtu@englishfalse
\newif\ifsjtu@bachelor\sjtu@bachelorfalse
\newif\ifsjtu@master\sjtu@masterfalse
\newif\ifsjtu@doctor\sjtu@doctorfalse
\newif\ifsjtu@review\sjtu@reviewfalse
\newif\ifsjtu@submit\sjtu@submitfalse

\DeclareOption{english}{\sjtu@englishtrue}
\DeclareOption{bachelor}{\sjtu@bachelortrue}
\DeclareOption{master}{\sjtu@mastertrue}
\DeclareOption{doctor}{\sjtu@doctortrue}
\DeclareOption{review}{\sjtu@reviewtrue}
\DeclareOption{submit}{\sjtu@submittrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions\relax

\ifsjtu@english
  \PassOptionsToClass{scheme=plain}{ctexbook}
\else
  \PassOptionsToClass{scheme=chinese}{ctexbook}
\fi
\ifsjtu@bachelor
  \PassOptionsToClass{zihao=5}{ctexbook}
\else
  \PassOptionsToClass{zihao=-4}{ctexbook}
  \ifsjtu@master\relax\else
    \ifsjtu@doctor\relax\else
      \ClassError{sjtuthesis}%
        {Require one of options: bachelor/master/doctor.}{}
    \fi
  \fi
\fi
\PassOptionsToPackage{no-math}{fontspec}
\LoadClass[UTF8]{ctexbook}


%==========
% Segment 0. Import sjtuthesis.cfg and define values
%==========

\AtEndOfClass{\input{sjtuthesis.cfg}}

% Chinese title page
\newcommand\keywords[1]{\def\sjtu@value@keywords{#1}}
\newcommand\classification[1]{\def\sjtu@value@classification{#1}}
\newcommand\studentnumber[1]{\def\sjtu@value@studentnumber{#1}}
\newcommand\confidential[1]{\def\sjtu@value@confidential{#1}}
\newcommand\school[1]{\def\sjtu@value@school{#1}}
\newcommand\chinesedegree[1]{\def\sjtu@value@chinesedegree{#1}}
\newcommand\advisor[1]{\def\sjtu@value@advisor{#1}}
\newcommand\coadvisor[1]{\def\sjtu@value@coadvisor{#1}}
\newcommand\major[1]{\def\sjtu@value@major{#1}}
\newcommand\submitdate[1]{\def\sjtu@value@submitdate{#1}}
\newcommand\defensedate[1]{\def\sjtu@value@defensedate{#1}}
\newcommand\institute[1]{\def\sjtu@value@institute{#1}}
\newcommand\chairman[1]{\def\sjtu@value@chairman{#1}}
\renewcommand\title[1]{\def\sjtu@value@chinesetitle{#1}}
\renewcommand\author[1]{\def\sjtu@value@author{#1}}

% English title page
\newcommand\englishkeywords[1]{\def\sjtu@value@englishkeywords{#1}}
\newcommand\englishtitle[1]{\def\sjtu@value@englishtitle{#1}}
\newcommand\englishauthor[1]{\def\sjtu@value@englishauthor{#1}}
\newcommand\englishadvisor[1]{\def\sjtu@value@englishadvisor{#1}}
\newcommand\englishcoadvisor[1]{\def\sjtu@value@englishcoadvisor{#1}}
\newcommand\englishinstitute[1]{\def\sjtu@value@englishinstitute{#1}}
\newcommand\englishschool[1]{\def\sjtu@value@englishschool{#1}}
\newcommand\englishlocation[1]{\def\sjtu@value@englishlocation{#1}}
\newcommand\englishdate[1]{\def\sjtu@value@englishdate{#1}}
\newcommand\englishdegree[1]{\def\sjtu@value@englishdegree{#1}}
\newcommand\englishmajor[1]{\def\sjtu@value@englishmajor{#1}}


%==========
% Segment 1. Import LaTeX packages.
%==========

\if@twoside
  \PassOptionsToPackage{twoside,left=30mm,body={155mm,220mm}}{geometry}
\else
  \PassOptionsToPackage{centering,body={160mm,220mm}}{geometry}
\fi
\RequirePackage[a4paper]{geometry}
\RequirePackage{etoolbox}
\RequirePackage{fontspec}
\RequirePackage{mathtools, amsthm, amssymb}
\RequirePackage[%
  math-style=TeX,
  bold-style=TeX,
  sans-style=upright,
]{unicode-math}
\RequirePackage{fancyhdr}
\RequirePackage{pageslts}
\RequirePackage{metalogo}
\RequirePackage{array}
\RequirePackage{dcolumn}
\RequirePackage{multirow}
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{threeparttablex}
\RequirePackage{graphicx}
\RequirePackage{caption}
\RequirePackage[list=off]{bicaption}
\RequirePackage{subcaption}
\RequirePackage{csquotes}
\RequirePackage[%
  backend=biber,
  style=gb7714-2015,
]{biblatex}
\RequirePackage{xcolor}
\RequirePackage{wasysym}
\RequirePackage{listings}
\RequirePackage{textcomp}
\RequirePackage[inline]{enumitem}
\RequirePackage{pdfpages}
\RequirePackage{calc}
\RequirePackage{siunitx}
\RequirePackage{relsize}
\RequirePackage[nottoc]{tocbibind}
\RequirePackage[titles]{tocloft}
\RequirePackage{hyphenat}
\RequirePackage{xeCJKfntef} % for CJKfilltwosides

% Delay the execution of \hypersetup at \begin{document}.
% NOTE: Should be set before hyperref uses it.
\AtBeginDocument{
  \hypersetup{%
    breaklinks,
    colorlinks,
    urlcolor=blue,
    linkcolor=blue,
    citecolor=blue,
    pdfstartview=FitH,
    pdfborder={0 0 0},% No border around links
    pdfauthor={\sjtu@value@author},
    pdftitle={\sjtu@value@chinesetitle},
    pdfsubject={\sjtu@value@school \sjtu@value@chinesedegree \sjtu@label@thesis},
    pdfkeywords={\sjtu@value@keywords},
  }
}
\RequirePackage{hyperref}

\RequirePackage[
  open,
  openlevel=2,
  numbered,
  depth=subsubsection,
]{bookmark}

%==========
% Segment 2. Define general-purpose LaTeX commands.
%==========

\setcounter{secnumdepth}{4}  % 章节编号深度 (part 对应 -1)
\setcounter{tocdepth}{2}     % 目录深度 (part 对应 -1)

% Increase numbering width (requires 'tocloft')
\setlength\cftfignumwidth{3em}
\setlength\cfttabnumwidth{3em}

% A new column type
\newcolumntype{d}[1]{D{.}{.}{#1}}% or D{.}{,}{#1} or D{.}{\cdot}{#1}

% New 'cndash'
\newcommand{\cndash}{%
  \rule{0.0em}{0pt}\rule[0.35em]{1.4em}{0.05em}\rule{0.2em}{0pt}%
}

% Select text if review or not
\newcommand{\reviewornot}[2]{\ifsjtu@review{#1}\else{#2}\fi}

\patchcmd\cleardoublepage%
  {\newpage}%
  {\thispagestyle{blank}\newpage}%
  {}{}
\patchcmd\chapter%
  {\thispagestyle{\CTEX@chapter@pagestyle}}%
  {}{}{}
\patchcmd\@chapter%
  {\if@twocolumn}%
  {\addtocontents{loa}{\protect\addvspace{10\p@}}%
   \if@twocolumn}%
  {}{}
\patchcmd\tableofcontents%
  {\chapter}%
  {\cleardoublepage%
   \pdfbookmark[0]{\contentsname}{toc}%
   \chapter}%
  {}{}


%==========
% Segment 3. Configure packages and extend LaTeX commands
%==========

\linespread{1.3}

\ctexset{%
  contentsname={\sjtu@contentsname},
  listfigurename={\sjtu@listfigurename},
  listtablename={\sjtu@listtablename},
  autoindent=true,
  chapter={%
    format={\zihao{3}\bfseries\centering},
    nameformat={},
    titleformat={},
    aftername={\quad},
    afterindent=true,
    beforeskip={15\p@},
    afterskip={12\p@},
  },
  section={%
    format={\zihao{4}\bfseries},
    afterindent=true,
    afterskip={1.0ex \@plus 0.2ex},
  },
  subsection={%
    format={\zihao{-4}\bfseries},
    afterindent=true,
    afterskip={1.0ex \@plus 0.2ex},
  },
  subsubsection={%
    format={\normalsize\normalfont},
    afterindent=true,
    afterskip={1.0ex \@plus 0.2ex},
  },
  paragraph/afterindent=true,
  subparagraph/afterindent=true,
}

% Set indent in English mode
\ifsjtu@english\setlength{\parindent}{2\ccwd}\fi

% Graphics path & file extension
\graphicspath{{fig/}{figure/}{figures/}{logo/}{logos/}{graph/}{graphs/}}
\DeclareGraphicsExtensions{.pdf,.eps,.png,.jpg,.jpeg}

% Caption setting in caption and bicaption pacakge
\captionsetup{%
  format=plain,
  labelformat=simple,
  labelsep=period,
  justification=centering,
  textfont={small,sf},
  labelfont={small,bf},
}
\DeclareCaptionOption{bi-first}[]{
  \def\tablename{\sjtu@tablename}
  \def\figurename{\sjtu@figurename}
}
\DeclareCaptionOption{bi-second}[]{
  \def\tablename{Table}
  \def\figurename{Figure}
}
% \captionsetup[xxx] must be placed *after* \DeclareCaptionOption{xxx}
% Credit: https://github.com/mohuangrui/ucasthesis/issues/223#issuecomment-731495483
\captionsetup[bi-first]{bi-first}
\captionsetup[bi-second]{bi-second}
\captionsetup[sub]{font=footnotesize}

\renewcommand{\lstlistingname}{\sjtu@listingname}

% Set footnote font size in threeparttable
\appto\TPTnoteSettings{\footnotesize}

% Better control of floats
% Credit: https://aty.sdsu.edu/bibliog/latex/floats.html
% (for all pages)
\renewcommand{\topfraction}{0.9}  % max fraction of floats at top
\renewcommand{\bottomfraction}{0.8}  % max fraction of floats at bottom
% (for text pages)
\setcounter{topnumber}{2}
\setcounter{bottomnumber}{2}
\setcounter{totalnumber}{4}
\renewcommand{\textfraction}{0.07}  % allow minimal text with figs
% (for float pages)
\renewcommand{\floatpagefraction}{0.7}  % require fuller float pages

% 公式、图、表、代码的编号为"3-1"的形式
\AtBeginDocument{%
  \renewcommand{\theequation}{\thechapter--\arabic{equation}}
  \renewcommand{\thefigure}{\thechapter--\arabic{figure}}
  \renewcommand{\thetable}{\thechapter--\arabic{table}}
  \renewcommand{\thelstlisting}{\thechapter--\arabic{lstlisting}}
}

% 使用 enumitem 宏包配制列表环境
\setlist{nosep}
\setlist*{leftmargin=*} % 列表和段落头对齐
\setlist[1]{labelindent=\parindent} % Only the level 1
\setlist[itemize,1]{label=\ensuremath{\bullet}}
\setlist[itemize,2]{label=\ensuremath{\square}}

% Set listings/lstlistings
\lstset{
  tabsize=4,
  frame=shadowbox, %把代码用带有阴影的框圈起来
  commentstyle=\color{red!50!green!50!blue!50}, %浅灰色的注释
  rulesepcolor=\color{red!20!green!20!blue!20}, %代码块边框为淡青色
  keywordstyle=\color{blue!90}\bfseries, %代码关键字的颜色为蓝色，粗体
  showstringspaces=false, %不显示代码字符串中间的空格标记
  stringstyle=\ttfamily, %代码字符串的特殊格式
  keepspaces=true, %
  breakindent=22pt, %
  numbers=left, %左侧显示行号
  stepnumber=1, %
  numberstyle=\tiny, %行号字体用小号
  basicstyle={\footnotesize\ttfamily}, %
  showspaces=false, %
  flexiblecolumns=true, %
  breaklines=true, %对过长的代码自动换行
  breakautoindent=true, %
  breakindent=4em, %
  aboveskip=1em, %代码块边框
  %% added by http://bbs.ctex.org/viewthread.php?tid=53451
  fontadjust,
  captionpos=t,
  framextopmargin=2pt,
  framexbottommargin=2pt,
  abovecaptionskip=-9pt,
  belowcaptionskip=9pt,
  xleftmargin=4em,xrightmargin=4em, % 设定listing左右的空白
  texcl=true,
  % 设定中文冲突，断行，列模式，数学环境输入，listing数字的样式
  extendedchars=false,
  columns=flexible,
  mathescape=true,
  numbersep=-1em,
  % 改变双引号和单引号的样式
  literate={"}{\textquotedbl}1,
  upquote=true,
}


%==========
% Segment 4. Draw the sjtuthesis
%==========

% 标题页
%
\newcommand\makechinesetitle{%
  \cleardoublepage
  \pdfbookmark[0]{\sjtu@titlepage}{titlepage}
  \thispagestyle{empty}
  \begin{center}
    \vspace*{14mm}
    {\zihao{-2}\sjtu@label@statement}
    \vskip\stretch{5}
    {\zihao{2}\bfseries \sjtu@value@chinesetitle \vskip 1pt}
    \vskip\stretch{5}
    {\zihao{4}
      \def\tabcolsep{1pt}
      \def\arraystretch{1.5}
      \begin{tabular}{>{\begin{CJKfilltwosides}[t]{6.5\ccwd}\bfseries}r<{\end{CJKfilltwosides}}@{: }l}
        \ifsjtu@review
          \sjtu@label@author        & \underline{\makebox[10\ccwd]{}} \\
          \sjtu@label@studentnumber & \underline{\makebox[10\ccwd]{}} \\
          \sjtu@label@advisor       & \underline{\makebox[10\ccwd]{}} \\
          \ifx\sjtu@value@coadvisor\undefined\else
            \sjtu@label@coadvisor   & \underline{\makebox[10\ccwd]{}} \\
          \fi
        \else
          \sjtu@label@author        & \underline{\makebox[10\ccwd]{\sjtu@value@author}} \\
          \sjtu@label@studentnumber & \underline{\makebox[10\ccwd]{\sjtu@value@studentnumber}} \\
          \sjtu@label@advisor       & \underline{\makebox[10\ccwd]{\sjtu@value@advisor}} \\
          \ifx\sjtu@value@coadvisor\undefined\else
            \sjtu@label@coadvisor   & \underline{\makebox[10\ccwd]{\sjtu@value@coadvisor}} \\
          \fi
        \fi
        \sjtu@label@major           & \underline{\makebox[10\ccwd]{\sjtu@value@major}} \\
        \sjtu@label@defensedate     & \underline{\makebox[10\ccwd]{\sjtu@value@defensedate}}
      \end{tabular}}
    \vskip 9mm
  \end{center}
  \cleardoublepage
}

% Title page
%
\newcommand\makeenglishtitle{%
  \cleardoublepage
  \pdfbookmark[0]{Title page}{englishtitlepage}
  \thispagestyle{empty}
  \begin{center}
    \vspace*{10mm}
    {\zihao{4} \sjtu@label@englishstatement \vskip 1pt}
    \vskip\stretch{4}
    {\zihao{-2}\bfseries \sjtu@value@englishtitle \vskip 1pt}
    \vskip\stretch{5}
    {\zihao{4}
    \ifsjtu@review
      \vskip\stretch{1}
      \vskip 3pt
      \vskip\stretch{2}
    \else
      \sjtu@value@englishauthor
      \vskip\stretch{1}
      \sjtu@label@englishadvisor
      \vskip 2pt
      \sjtu@value@englishadvisor
      \vskip 5pt
      \ifx\sjtu@value@englishcoadvisor\undefined\else
        \sjtu@label@englishcoadvisor
        \vskip 2pt
        \sjtu@value@englishcoadvisor
      \fi
      \vskip\stretch{2}
    \fi
    \vskip 20pt
    \sjtu@value@englishinstitute \\
    \sjtu@value@englishschool \\
    \sjtu@value@englishlocation
    \vskip 20pt
    \sjtu@value@englishdate}
  \end{center}
  \vskip 9mm
  \cleardoublepage
}

% 本科学位论文 - 标题页
%
\newcommand\makechinesetitle@bachelor{%
  \cleardoublepage
  \pdfbookmark[0]{\sjtu@titlepage}{titlepage}
  \thispagestyle{empty}
  \begin{center}
    \vspace*{20pt} \vskip 7pt
    \includegraphics{sjtulogo}
    \vskip 30pt
    {\fontsize{32}{32}\sffamily\sjtu@value@chinesedegree\sjtu@label@thesis}
    \vskip 15pt
    {\zihao{-2}\MakeUppercase{Thesis of \sjtu@value@englishdegree}}
    \vskip 15pt
    \includegraphics{sjtubadge}
    \vskip \stretch{2}
    {\sffamily\zihao{2}
    \begin{tabular}{r@{：}l}
      \sjtu@label@title &
      {\zihao{-2}\underline{\begin{minipage}{360pt}\centering\sjtu@value@chinesetitle\end{minipage}}}
    \end{tabular}}
    \vskip \stretch{1}
    {\sffamily\zihao{3}
    \def\arraystretch{1.1}
    \begin{tabular}{>{\begin{CJKfilltwosides}{4\ccwd}}r<{\end{CJKfilltwosides}}@{：}l}
      \ifsjtu@review
        \sjtu@label@author        & \underline{\makebox[180pt]{}} \\
        \sjtu@label@studentnumber & \underline{\makebox[180pt]{}} \\
      \else
        \sjtu@label@author        & \underline{\makebox[180pt]{\sjtu@value@author}} \\
        \sjtu@label@studentnumber & \underline{\makebox[180pt]{\sjtu@value@studentnumber}} \\
      \fi
        \sjtu@label@major         & \underline{\makebox[180pt]{\sjtu@value@major}} \\
      \ifsjtu@review
        \sjtu@label@advisor       & \underline{\makebox[180pt]{}} \\
      \else
        \sjtu@label@advisor       & \underline{\makebox[180pt]{\sjtu@value@advisor}} \\
      \fi
        \sjtu@label@institute     & \underline{\makebox[180pt]{\sjtu@value@institute}}
    \end{tabular}}
  \end{center}
  \cleardoublepage
}

\renewcommand\maketitle{%
  \ifsjtu@bachelor
    \makechinesetitle@bachelor
  \else
    \makechinesetitle
    \makeenglishtitle
  \fi
}

% 原创性声明
%
\newcommand\makeDeclareOriginality{%
  \cleardoublepage
  \pdfbookmark[0]{\sjtu@label@originality}{originality}
  \thispagestyle{empty}
  \begin{center}
    \bfseries\zihao{3}
    \sjtu@value@school
    \vskip 10pt
    \sjtu@label@originality
  \end{center}
  \vskip 10pt
  \par
  {\zihao{-4} \sjtu@label@originalityContent}
  \par
  \vskip 60pt
  \hfill\sjtu@label@authorsign\rule{\widthof{\sjtu@label@dateinput}}{0.5pt}
  \vskip 15pt
  \hfill\sjtu@label@date\sjtu@label@dateinput
  \cleardoublepage
}

% 授权声明
%
\newcommand\makeDeclareAuthorization{%
  \cleardoublepage
  \pdfbookmark[0]{\sjtu@label@authorization}{authorization}
  \thispagestyle{empty}
  \begin{center}
    \bfseries\zihao{3}
    \sjtu@value@school
    \vskip 10pt
    \sjtu@label@authorization
  \end{center}
  \vskip 10pt
  \par
  {\zihao{-4} \sjtu@label@authorizationContent}
  \par
  \vskip 60pt
  \noindent%
  \sjtu@label@authorsign\rule{\widthof{\sjtu@label@dateinput}}{0.5pt} \hfill
  \sjtu@label@advisorsign\rule{\widthof{\sjtu@label@dateinput}}{0.5pt}
  \vskip 15pt
  \noindent%
  \makebox[\widthof{\sjtu@label@authorsign}][r]{\sjtu@label@date}%
    \sjtu@label@dateinput \hfill
  \makebox[\widthof{\sjtu@label@advisorsign}][r]{\sjtu@label@date}%
    \sjtu@label@dateinput
  \cleardoublepage
}

% 中英文页眉页脚设置
%
\ifsjtu@english
  \def\sjtu@value@titlemark{\sjtu@value@englishtitle}
  \newcommand\sjtu@fancyhead{\footnotesize\sffamily}
  \newcommand\sjtu@fancyfoot[2]{%
    \small --~~Page~~{\textbf{#1}}~~of~~{\textbf{#2}}~~--}
\else
  \def\sjtu@value@titlemark{\sjtu@value@chinesetitle}
  \newcommand\sjtu@fancyhead{\small\sffamily}
  \newcommand\sjtu@fancyfoot[2]{%
    \small 第~{\textbf{#1}}~页\,共~{\textbf{#2}}~页}
\fi
\def\markboxwidth{0.75\textwidth}
\AtBeginDocument{\pagenumbering{Alph}}

% 本科学位论文 - 页眉页脚设置
%
\ifsjtu@bachelor
  %% 前言页眉页脚
  \fancypagestyle{front}{%
    \fancyhf{}
    \fancyhead[L]{\includegraphics{sjtubanner}}
    \fancyhead[R]{%
      \parbox[b]{\markboxwidth}{%
        \raggedleft\nouppercase{\sjtu@fancyhead\sjtu@value@titlemark}}}
    \fancyfoot[C]{\sjtu@fancyfoot{\thepage}{\lastpageref{pagesLTS.Roman}}}
    \renewcommand{\headheight}{32pt}
  }
  %% 正文页眉页脚
  \fancypagestyle{main}{%
    \fancyhf{}
    \fancyhead[L]{\includegraphics{sjtubanner}}
    \fancyhead[R]{%
      \parbox[b]{\markboxwidth}{%
        \raggedleft\nouppercase{\sjtu@fancyhead\sjtu@value@titlemark}}}
    \fancyfoot[C]{\sjtu@fancyfoot{\thepage}{\lastpageref{pagesLTS.arabic}}}
    \renewcommand{\headheight}{32pt}
  }
  %% 英文大摘要
  \fancypagestyle{biglast}{%
    \fancyhf{}
    \fancyhead[L]{\includegraphics{sjtubanner}}
    \fancyhead[R]{%
      \parbox[b]{\markboxwidth}{%
        \raggedleft\nouppercase{\sjtu@fancyhead\sjtu@value@titlemark}}}
    \fancyfoot[C]{%
      \sjtu@fancyfoot{%
        \theCurrentPageLocal}{\lastpageref{pagesLTS.roman.local}}}
    \renewcommand{\headheight}{32pt}
  }

% 研究生学位论文 - 页眉页脚设置
%
\else
  %% 空白页
  \fancypagestyle{blank}{
    \fancyhf{}
    \fancyfoot[C]{\small ---~---}
    \renewcommand{\headrulewidth}{0pt}
  }
  \if@twoside  % 双面打印
    %% 开章页页眉页脚
    \fancypagestyle{front}{
      \fancyhf{}
      \fancyhead[LO,RE]{%
        \small\sffamily%
        \sjtu@value@school\sjtu@value@chinesedegree%
        \sjtu@label@thesis}
      \fancyhead[LE,RO]{\nouppercase{\sjtu@fancyhead\leftmark}}
      \fancyfoot[C]{\small ---~\textbf{\thepage}~---}
      \renewcommand{\headheight}{32pt}
    }
    %% 正文页眉页脚
    \fancypagestyle{main}{
      \fancyhf{}
      \fancyhead[LO,RE]{%
        \small\sffamily%
        \sjtu@value@school\sjtu@value@chinesedegree%
        \sjtu@label@thesis}
      \fancyhead[LE,RO]{\nouppercase{\sjtu@fancyhead\leftmark}}
      \fancyfoot[C]{\small ---~\textbf{\thepage}~---}
      \renewcommand{\headheight}{32pt}
    }
  \else  % 单面打印
    \fancypagestyle{front}{
      \fancyhf{}
      \fancyhead[L]{%
        \small\sffamily%
        \sjtu@value@school\sjtu@value@chinesedegree%
        \sjtu@label@thesis}
      \fancyhead[R]{\nouppercase{\sjtu@fancyhead\leftmark}}
      \fancyfoot[C]{\small ---~\textbf{\thepage}~---}
      \renewcommand{\headheight}{32pt}
    }
    \fancypagestyle{main}{
      \fancyhf{}
      \fancyhead[L]{%
        \small\sffamily%
        \sjtu@value@school\sjtu@value@chinesedegree%
        \sjtu@label@thesis}
      \fancyhead[R]{\nouppercase{\sjtu@fancyhead\leftmark}}
      \fancyfoot[C]{\small ---~\textbf{\thepage}~---}
      \renewcommand{\headheight}{32pt}
    }
  \fi
\fi

\renewcommand\frontmatter{%
  \cleardoublepage
  \@mainmatterfalse
  \ifsjtu@bachelor
    \pagestyle{front}
  \else
    \pagestyle{main}
  \fi
  \pagenumbering{roman}
}
\renewcommand\mainmatter{%
  \cleardoublepage
  \@mainmattertrue
  \pagestyle{main}
  \pagenumbering{arabic}
}

% 摘要+关键词
%
\newenvironment{abstract}{%
  \cleardoublepage
  \pdfbookmark[0]{\sjtu@label@abstract}{abstract}
  \chapter*{%
    \sjtu@value@chinesetitle
    \vskip 20pt
    \sjtu@label@chineseabstract}
  \markboth{\sjtu@label@chineseabstract}{}
}{%
  \vspace{2ex}
  \par\noindent
  {\zihao{4}%
    \textbf{\sjtu@label@keywords}
    \sjtu@value@keywords}
}

% Abstract + keywords
%
\newenvironment{englishabstract}{%
  \cleardoublepage
  \pdfbookmark[0]{Abstract}{englishabstract}
  \chapter*{%
    \sjtu@value@englishtitle
    \vskip 20pt
    \sjtu@label@englishabstract}
  \markboth{\sjtu@label@englishabstract}{}
}{%
  \vspace{2ex}
  \par\noindent
  {\zihao{4}\nohyphens{%
    \textbf{\sjtu@label@englishkeywords}
    \sjtu@value@englishkeywords}}
}

% 主要符号对照表
%
\newenvironment{nomenclaturename}{%
  \cleardoublepage
  \chapter{\sjtu@nomenclature}{}
}{}

% 发表论文
%
\newenvironment{publications}[1]{
  \chapter{\sjtu@label@publications}%
  \@mkboth{\MakeUppercase\sjtu@label@publications}
  {\MakeUppercase\sjtu@label@publications}%
  \list{%
    \@biblabel{\@arabic\c@enumiv}
  }{%
    \settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \@openbib@code
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \renewcommand\theenumiv{\@arabic\c@enumiv}
  }%
  \sloppy
  \clubpenalty4000
  \@clubpenalty \clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m%
}{%
  \def\@noitemerr
  {\@latex@warning{Empty `publications' environment}}%
  \endlist
}

% 申请专利
%
\newenvironment{patents}[1]{%
  \chapter{\sjtu@label@patents}%
  \@mkboth{\MakeUppercase\sjtu@label@patents}
  {\MakeUppercase\sjtu@label@patents}%
  \list{%
    \@biblabel{\@arabic\c@enumiv}
  }{%
    \settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \@openbib@code
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \renewcommand\theenumiv{\@arabic\c@enumiv}
  }%
  \sloppy
  \clubpenalty4000
  \@clubpenalty \clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m%
}{%
  \def\@noitemerr
  {\@latex@warning{Empty `patents' environment}}%
  \endlist
}

% 参与项目
%
\newenvironment{projects}[1]{%
  \chapter{\sjtu@label@projects}%
  \@mkboth{\MakeUppercase\sjtu@label@projects}
  {\MakeUppercase\sjtu@label@projects}%
  \list{%
    \@biblabel{\@arabic\c@enumiv}
  }{%
    \settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \@openbib@code
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \renewcommand\theenumiv{\@arabic\c@enumiv}
  }%
  \sloppy
  \clubpenalty4000
  \@clubpenalty \clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m%
}{%
  \def\@noitemerr
  {\@latex@warning{Empty `projects' environment}}%
  \endlist
}

% 简历
%
\newenvironment{resume}{%
  \chapter{\sjtu@label@resume}
}{}

\newenvironment{resumesection}[1]{%
  {\noindent\normalfont\bfseries #1}
  \list{}{%
    \labelwidth\z@
    \leftmargin 2\ccwd
  }
  \item\relax
}{\endlist}

\newenvironment{resumelist}[1]{%
  {\noindent\normalfont\bfseries #1}
  \list{}{%
    \labelwidth\z@
    \leftmargin 4\ccwd
    \itemindent -2\ccwd
    \listparindent\itemindent
  }
}{\endlist}

% 致谢
%
\renewenvironment{thanks}{%
  \chapter*{\sjtu@label@thanks\markboth{\sjtu@label@thanks}{}}
  \addcontentsline{toc}{chapter}{\sjtu@label@thanks}
}{}

% 全文总结
%
\newenvironment{summary}{%
  \chapter*{\sjtu@label@summary\markboth{\sjtu@label@summary}{}}
  \addcontentsline{toc}{chapter}{\sjtu@label@summary}
}{}

% 本科学位论文 - 英文大摘要
%
\newenvironment{bigabstract}{%
  \cleardoublepage
  \pagenumbering{roman}
  \pagestyle{biglast}
  \chapter*{\bfseries\MakeUppercase\sjtu@value@englishtitle}
  \vskip 20pt
}{\cleardoublepage}

\endinput

%% End of file `sjtuthesis.cls'.
