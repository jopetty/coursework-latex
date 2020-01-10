%% lnotes.cls
%%
%% A LaTeX3 class for lecture notes.

\RequirePackage{expl3, xparse, iftex}

\ExplSyntaxOn

%% Define Class Metadata
%% ---------------------
%% Provides information to the LaTeX3 compiler
%% about what our class does.
\tl_const:Nn \c__lnotes_class_name_tl            {lnotes}
\tl_const:Nn \c__lnotes_class_version_tl         {1.0.0}
\tl_const:Nn \c__lnotes_class_date_tl            {2018/07/04}
\tl_const:Nn \c__lnotes_class_description_tl     {A~LaTeX3~class~for~lecture~notes.}
\tl_const:Nn \c__lnotes_class_parent_class_tl    {article}

\ProvidesExplClass{\c__lnotes_class_name_tl}         % Class
                  {\c__lnotes_class_date_tl}         % Date
                  {\c__lnotes_class_version_tl}      % Version
                  {\c__lnotes_class_description_tl}  % Description

%% Define Class Data
%% -----------------
%% Data set by the user about the course or lecture.
%% Used to create headers, title page, etc.
\tl_new:N \g_lnotes_title_tl       % Document Title (Course Name, Lecture Name, etc)
\tl_new:N \g_lnotes_subtitle_tl    % Document Subtitle (for headers)
\tl_new:N \g_lnotes_course_tl      % Course ID (e.g., MATH 230)
\tl_new:N \g_lnotes_term_tl        % Course Term (Spring, Michaelmas, etc)
\tl_new:N \g_lnotes_year_tl        % Year
\tl_new:N \g_lnotes_place_tl       % Place
\tl_new:N \g_lnotes_blurb_tl       % A short paragraph at the beginning of the document

% Set default values for data commands
\tl_gset:Nn	\g_lnotes_title_tl    {Course~Title}
\tl_gset:Nn \g_lnotes_subtitle_tl {
	\tl_if_empty:NF \g_lnotes_course_tl {\g_lnotes_course_tl{},~}
	\tl_if_empty:NF \g_lnotes_place_tl {\g_lnotes_place_tl{},~}
	\tl_if_empty:NF \g_lnotes_term_tl {\g_lnotes_term_tl{}~}
	\tl_if_empty:NF \g_lnotes_year_tl {\g_lnotes_year_tl{}}
}
\tl_clear_new:N	\g_lnotes_course_tl
\tl_clear_new:N	\g_lnotes_term_tl
\tl_clear_new:N	\g_lnotes_year_tl
\tl_clear_new:N	\g_lnotes_place_tl
\tl_clear_new:N \g_lnotes_blurb_tl

% Provide user-facing interface to document commands
\RenewDocumentCommand\title{ m }{\tl_gset:Nn \g_lnotes_title_tl {#1}}
\NewDocumentCommand\subtitle{ m }{\tl_gset:Nn \g_lnotes_subtitle_tl {#1}}
\NewDocumentCommand\course{ m }{\tl_gset:Nn \g_lnotes_course_tl {#1}}
\NewDocumentCommand\term{ m }{\tl_gset:Nn \g_lnotes_term_tl {#1}}
\NewDocumentCommand\place{ m }{\tl_gset:Nn \g_lnotes_place_tl {#1}}
\NewDocumentCommand\blurb{ m }{\tl_gset:Nn \g_lnotes_blurb_tl {#1}}

% Class Options
\bool_new:N \g_lnotes_coverpage_bool
\tl_new:N \g_lnotes_loadcode_tl
\tl_new:N \g_lnotes_loaddiag_tl

\bool_gset_false:N \g_lnotes_coverpage_bool
\tl_clear_new:N \g_lnotes_loadcode_tl
\tl_clear_new:N \g_lnotes_loaddiag_tl

\DeclareOption{cover}{\bool_gset_true:N \g_lnotes_coverpage_bool}
\DeclareOption{code}{\tl_gset:Nn \g_lnotes_loadcode_tl {code}}
\DeclareOption{diagram}{\tl_gset:Nn \g_lnotes_loaddiag_tl {diagram}}

\DeclareOption*{ \PassOptionsToClass{\CurrentOption}{\c__lnotes_class_parent_class_tl} }

\ProcessOptions\relax

%% Process Options and Load Base Class
\LoadClass[letterpaper]{\c__lnotes_class_parent_class_tl}

%% Load shared definitions
\RequirePackage[
	\g_lnotes_loadcode_tl ,
	\g_lnotes_loaddiag_tl
]{coursework}

% Wait to redefine \year until after we have loaded Tikz,
% Since pgf uses the default \year command to generate a
% seed for its random-number code.
\RenewDocumentCommand\year{ m }{\tl_gset:Nn \g_lnotes_year_tl {#1}}

%% Customization for Notes Only
%% ============================

% Load Packages
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage{textcase}
\RequirePackage[titles]{tocloft}

% Set up PDF data
\hypersetup{
  % linkcolor  = linkblue,
  % citecolor  = linkblue,
  % urlcolor   = linkblue,
  % colorlinks = true,
}

% Table of Contents
\renewcommand{\cfttoctitlefont}{\relax\centering\widekern}
\renewcommand{\cftsecfont}{}
\renewcommand{\cftsecpagefont}{}
\renewcommand{\cftsubsecfont}{\itshape}

% Starred sections now appear in the table of contents.
% This change, however, must not be applied until *after*
% the TOC is printed, to avoid the TOC appearing in itself.
% This code is therefore placed in the \AtBeginDocument{ ... }
% section below, instead of here.

% Format Sections
\titleformat{\section}                          % Level
            {\bfseries\Large}                   % Formatting
            {\thesection}                       % Label
            {1em}                               % Label Spacing
            {}                                  % Before Code

\titleformat{\subsection}                       % Level
            {\itshape\bfseries\large}           % Formatting
            {\thesubsection}                    % Label
            {1em}                               % Label Spacing
            {}                                  % Before Code

\titleformat{\subsubsection}
            {\bfseries}
            {\thesubsubsection}
            {1em}
            {}

% Section spacing
\titlespacing\section{0ex}{4ex plus 0.2ex minus 0.2ex}{2ex}
\titlespacing\subsection{0ex}{2ex plus 0.2ex minus 0.2ex}{1ex}
\titlespacing\subsubsection{0ex}{1ex plus 0.1ex minus 0.1ex}{0ex}

% Header/Footer

% Create var to store section names
% since \rightmark is doing some really
% weird things which prevent changing the case
\tl_new:N \l_lnotes_secname_tl
\tl_clear_new:N \l_lnotes_secname_tl
\bool_new:N \l_lnotes_showsecnum_bool
\bool_set_false:N \l_lnotes_showsecnum_bool

\fancypagestyle{normal}{
	\renewcommand{\headrulewidth}{0pt}
	\fancyhead{}
	\fancyfoot{}
	\fancyfoot[L]{
		\thepage
	}
	\fancyfoot[R]{
		\textsc{\MakeTextLowercase{\g_lnotes_title_tl{}}}
	}
	\fancyhead[C]{
		\textsc{\MakeTextLowercase{
			\IfBooleanTF{\l_lnotes_showsecnum_bool}{
				\thesection{}\hspace{0.5cm}
			}{}
			\l_lnotes_secname_tl{}
		}}
	}
}

% Title Page
\RenewDocumentCommand\maketitle{}{
	\newpage
	\begin{titlepage}
		\pagenumbering{gobble}
		\thispagestyle{empty}
		{\raggedright
		\null
		\vskip 4ex
		{
			\renewcommand{\baselinestretch}{0.8}
			\noindent\Huge\scshape \g_lnotes_title_tl{}\par
		}
		\tl_if_empty:NF \g_lnotes_subtitle_tl {
			\vskip 4ex
			{ \noindent\large\scshape \g_lnotes_subtitle_tl{} }
		}}

		{\noindent
			\tl_if_empty:NF \g_lnotes_blurb_tl {
				\vskip 4ex
				\g_lnotes_blurb_tl{}
			}
		}
		\vskip 7ex
		\noindent\tableofcontents{}
	\end{titlepage}
	\pagenumbering{arabic}
	\pagestyle{normal}
}

% Cover Page
\NewDocumentCommand\makecover{}{
	\newpage
	\begin{titlepage}
		\pagenumbering{gobble}
		\raggedright
		\newpagecolor{covergrey}
		\afterpage{\restorepagecolor}
		\vspace*{\fill}
		{\noindent\Huge \textcolor{white}{\g_lnotes_title_tl{}}}
		\tl_if_empty:NF \g_lnotes_subtitle_tl {
			\vskip 4ex
			{\noindent\large\scshape \textcolor{white}{\g_lnotes_subtitle_tl{}} }
		}
		\vspace*{\fill}
	\end{titlepage}
}
                

%% Beginning of Document
\AtBeginDocument{

	% Cover & title pages
	\hypersetup{pageanchor=false}
	\bool_if:NT \g_lnotes_coverpage_bool{
		\usepackage{pagecolor}
		\usepackage{afterpage}
		\makecover
	}
	\maketitle
	\hypersetup{pageanchor=true}

	% Starred sections which show up in TOC
	\let\oldsection\section
	\RenewDocumentCommand{\section}{som}{%
		\tl_set:Nn \l_lnotes_secname_tl {#3}
		\IfBooleanTF{#1}{%  Is it the starred command? Yes, then no \index
			\phantomsection
			\addcontentsline{toc}{section}{#3}
			\oldsection*{#3}
			\markboth{#3}{#3} % Set right and left marks
			\bool_set_false:N \l_lnotes_showsecnum_bool

		}{%
			\bool_set_true:N \l_lnotes_showsecnum_bool
			\IfValueTF{#2}{% Is it the optional argument version --> use #3
				\oldsection[#2]{#3}
			}{%
				\oldsection{#3} % Use #3 as well
			}
		}
	}
}

\ExplSyntaxOff