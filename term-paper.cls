%% term-paper.cls
%%
%% A (Xe)LaTeX 3 class for term papers.

\RequirePackage{expl3, xparse, iftex}

\ExplSyntaxOn

%% Define Class Metadata
%% ---------------------
%% Provides information to the LaTeX3 compiler
%% about what our class does.
\tl_const:Nn \c__pset_class_name_tl            {term-paper}
\tl_const:Nn \c__pset_class_version_tl         {1.0.0}
\tl_const:Nn \c__pset_class_date_tl            {2019/10/29}
\tl_const:Nn \c__pset_class_description_tl     {A~LaTeX3~class~for~term~papers.}
\tl_const:Nn \c__pset_class_parent_class_tl    {article}

\ProvidesExplClass{\c__pset_class_name_tl}         % Class
                  {\c__pset_class_date_tl}         % Date
                  {\c__pset_class_version_tl}      % Version
                  {\c__pset_class_description_tl}  % Description

%% Define Class Data
%% -----------------
%% Data set by the user about the assignment.
%% Used to create headers, title page, etc.
\tl_new:N \g_pset_title_tl     % Title of the assignment
\tl_new:N \g_pset_author_tl    % Your name
\tl_new:N \g_pset_duedate_tl   % When the assignment is due
\tl_new:N \g_pset_course_tl    % What course the assignment is for
\tl_new:N	\g_pset_byline_tl    % The default byline

% Clear and set default values
\tl_clear_new:N \g_pset_title_tl
\tl_clear_new:N \g_pset_author_tl
\tl_clear_new:N \g_pset_course_tl
\tl_clear_new:N \g_pset_duedate_tl 
\tl_gset:Nn \g_pset_byline_tl {
	\large {\scshape \MakeTextLowercase{\g_pset_author_tl},~\MakeTextLowercase{\g_pset_duedate_tl},}~{\small\textit{for}}~{\scshape \MakeTextLowercase{\g_pset_course_tl}}
}

% Provide user-facing interface to the data
\RenewDocumentCommand\title{ m }{ \tl_gset:Nn \g_pset_title_tl {#1} }
\NewDocumentCommand\assignment{ m }{ \title{#1} }
\RenewDocumentCommand\author{ m }{ \tl_gset:Nn \g_pset_author_tl {#1} }
\NewDocumentCommand\name{ m }{ \author{#1} }
\NewDocumentCommand\due{ m }{ \tl_gset:Nn \g_pset_duedate_tl {#1} }
\RenewDocumentCommand\date{ m }{ \due{#1} }
\NewDocumentCommand\course{ m }{ \tl_gset:Nn \g_pset_course_tl {#1} }
\NewDocumentCommand\byline{ m }{ \tl_gset:Nn \g_pset_byline_tl {#1} }

% Class Options
\bool_new:N \g_pset_coverpage_bool
\tl_new:N \g_pset_loadcode_tl
\tl_new:N \g_pset_loaddiag_tl

\bool_gset_false:N \g_pset_coverpage_bool
\tl_clear_new:N \g_pset_loadcode_tl
\tl_clear_new:N \g_pset_loaddiag_tl

\DeclareOption{cover}{\bool_gset_true:N \g_pset_coverpage_bool}
\DeclareOption{code}{\tl_gset:Nn \g_pset_loadcode_tl {code}}
\DeclareOption{diagram}{\tl_gset:Nn \g_pset_loaddiag_tl {diagram}}

\DeclareOption*{ \PassOptionsToClass{\CurrentOption}{\c__pset_class_parent_class_tl} }

\ProcessOptions\relax

%% Process Options and Load Base Class
\LoadClass[letterpaper, 10pt]{\c__pset_class_parent_class_tl}

%% Load shared definitions
\RequirePackage[
	\g_pset_loadcode_tl ,
	\g_pset_loaddiag_tl,
	nothmnum
]{coursework}

%% Customization for Term Papers Only
%% ==================================

%% Load Packages
\RequirePackage{fancyhdr}
\RequirePackage{textcase}
\RequirePackage{afterpage}
\RequirePackage{geometry}
\usepackage[]{footmisc}

%% Create Page Formats
\fancypagestyle{normal}{
	\renewcommand{\headrulewidth}{0pt}
	\fancyfoot{}
	\fancyfoot[L]{
		\footnotesize \thepage
	}
	\fancyhead[C]{
		\ifXeTeX 
			\scshape\MakeTextLowercase{\g_pset_title_tl{}}
		\else 
			\lsstyle \footnotesize \MakeTextUppercase{\g_pset_title_tl{}}
		\fi
	}
	\fancyhead[R]{}
	\fancyhead[L]{}
	\fancyfoot[R]{
		\ifXeTeX \else \lsstyle \fi
		\footnotesize\scshape
		\tl_if_empty:NF \g_pset_author_tl {
			\g_pset_author_tl{}
		}
		\tl_if_empty:NF \g_pset_duedate_tl {
			,~\g_pset_duedate_tl{}	
		}
	}
}

%% Redefine \maketitle
\RenewDocumentCommand\maketitle{}{
	\newpage
	\thispagestyle{empty}
	\null
	\begin{flushleft}
		{\LARGE\bfseries\sffamily \g_pset_title_tl}
	\end{flushleft}
	
	\begin{flushleft}
		\g_pset_byline_tl
	\end{flushleft}
	\vspace*{4ex}
}

% Prevent the coloring of links
\hypersetup{ colorlinks = false }

% Make Page Symmetric
\geometry{
	letterpaper,
	top = 1.45in,
	bottom = 1.35in,
	inner = 1.9in,
	outer = 1.9in,
	marginparwidth=1.4in,
	marginparsep=0.25in,
	footnotesep = 1cm
}

% Footnotes
\let\footnote\oldfootnote
%\addtolength{\footnotesep}{10mm}



\AtBeginDocument{
	\maketitle
	\pagestyle{normal}
	\noindent
}

\ExplSyntaxOff
