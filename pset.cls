%% pset.cls
%%
%% A (Xe)LaTeX 3 class for problem sets.

\RequirePackage{expl3, xparse, iftex}

\ExplSyntaxOn

%% Define Class Metadata
%% ---------------------
%% Provides information to the LaTeX3 compiler
%% about what our class does.
\tl_const:Nn \c__pset_class_name_tl            {pset}
\tl_const:Nn \c__pset_class_version_tl         {1.0.0}
\tl_const:Nn \c__pset_class_date_tl            {2018/07/04}
\tl_const:Nn \c__pset_class_description_tl     {A~LaTeX3~class~for~problem~sets.}
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
\tl_new:N \g_pset_blurb_tl     % A short blurb on the first page
\tl_new:N \g_pset_professor_tl % The professor of the course

% Clear and set default values
\tl_clear_new:N \g_pset_title_tl
\tl_clear_new:N \g_pset_author_tl
\tl_clear_new:N \g_pset_course_tl
\tl_clear_new:N \g_pset_duedate_tl 
\tl_clear_new:N \g_pset_blurb_tl
\tl_clear_new:N \g_pset_professor_tl

% Provide user-facing interface to the data
\RenewDocumentCommand\title{ m }{ \tl_gset:Nn \g_pset_title_tl {#1} }
\NewDocumentCommand\assignment{ m }{ \title{#1} }
\RenewDocumentCommand\author{ m }{ \tl_gset:Nn \g_pset_author_tl {#1} }
\NewDocumentCommand\name{ m }{ \author{#1} }
\NewDocumentCommand\due{ m }{ \tl_gset:Nn \g_pset_duedate_tl {#1} }
\RenewDocumentCommand\date{ m }{ \due{#1} }
\NewDocumentCommand\course{ m }{ \tl_gset:Nn \g_pset_course_tl {#1} }
\NewDocumentCommand\blurb{ m }{ \tl_gset:Nn \g_pset_blurb_tl {#1} }
\NewDocumentCommand\professor{ m }{ \tl_gset:Nn \g_pset_professor_tl {#1} }

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

%% Customization for Pset Only
%% ============================

%% Remove section numbering in all numbered theorem-like environments
\renewcommand*{\thecproblem}{\arabic{cproblem}}
\renewcommand*{\thecexercise}{\arabic{cexercise}}
\renewcommand*{\thecexample}{\arabic{cexample}}
\renewcommand*{\thelemma}{\arabic{lemma}}
\renewcommand*{\thetheorem}{\arabic{theorem}}
\renewcommand*{\thecorollary}{\arabic{corollary}}
\renewcommand*{\theconjecture}{\arabic{conjecture}}
\renewcommand*{\theproposition}{\arabic{proposition}}
\renewcommand*{\thecremark}{\arabic{cremark}}
\renewcommand*{\thecwarning}{\arabic{cwarning}}
\renewcommand*{\thecclaim}{\arabic{cclaim}}
\renewcommand*{\thecquestion}{\arabic{cquestion}}

%% Load Packages
\RequirePackage{fancyhdr}
\RequirePackage{textcase}
\RequirePackage{afterpage}
\RequirePackage{geometry}

%% Create Page Formats
\fancypagestyle{normal}{
	\renewcommand{\headrulewidth}{0pt}
	\fancyfoot{}
	\fancyfoot[L]{
		\footnotesize \thepage
	}
	\fancyhead[C]{
		\ifXeTeX \else \lsstyle \fi
		\footnotesize \MakeTextUppercase{\g_pset_course_tl{}}
	}
	\fancyhead[R]{}
	\fancyhead[L]{}
	\fancyfoot[R]{
		\ifXeTeX \else \lsstyle \fi
		\footnotesize
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
	\begin{center}
		{\normalsize\bfseries\MakeTextUppercase{
			\ifPDFTeX \lsstyle \fi
			\g_pset_course_tl{}\quad\g_pset_title_tl{}
		}}\par
		\vskip 2ex
		{\small \ifPDFTeX \lsstyle \fi
			\tl_if_empty:NF \g_pset_author_tl {
				\g_pset_author_tl{}
				\tl_if_empty:NF \g_pset_duedate_tl {,\quad}
			}
			\tl_if_empty:NF \g_pset_duedate_tl {
				\g_pset_duedate_tl{}
			}
			\par
		}
	\end{center}

	\tl_if_empty:NTF \g_pset_blurb_tl {
		\vskip 8ex
	}{
		\vskip 2ex
		\g_pset_blurb_tl{}\par
		\vskip 4ex
	}
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
}


\AtBeginDocument{
	\maketitle
	\pagestyle{normal}
}

\ExplSyntaxOff
