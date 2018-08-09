%% notes.cls
%%
%% A (Xe)LaTeX 3 class for lecture notes.

\RequirePackage{expl3, xparse, iftex}

\ExplSyntaxOn

%% Define Class Metadata
%% ---------------------
%% Provides information to the LaTeX3 compiler
%% about what our class does.
\tl_const:Nn \c__notes_class_name_tl            {notes}
\tl_const:Nn \c__notes_class_version_tl         {1.0.0}
\tl_const:Nn \c__notes_class_date_tl            {2018/07/04}
\tl_const:Nn \c__notes_class_description_tl     {A~LaTeX3~class~for~lecture~notes.}
\tl_const:Nn \c__coursework_class_parent_class_tl    {article}

\ProvidesExplClass{\c__notes_class_name_tl}         % Class
                  {\c__notes_class_date_tl}         % Date
                  {\c__notes_class_version_tl}      % Version
                  {\c__notes_class_description_tl}  % Description

%% Define Class Data
%% -----------------
%% Data set by the user about the course or lecture.
%% Used to create headers, title page, etc.
\tl_new:N \g_notes_title_tl       % Document Title (Course Name, Lecture Name, etc)
\tl_new:N \g_notes_subtitle_tl    % Document Short Title (for headers)
\tl_new:N \g_notes_speaker_tl     % Speaker (Professor, Lecturer, etc)
\tl_new:N \g_notes_spkemail_tl    % Speaker Email
\tl_new:N \g_notes_scribe_tl      % Scribe (you, person taking notes)
\tl_new:N \g_notes_scremail_tl    % Scribe Email
\tl_new:N \g_notes_courseid_tl    % Course ID (e.g., MATH 230)
\tl_new:N \g_notes_term_tl        % Course Term (Spring, Michaelmas, etc)
\tl_new:N \g_notes_year_tl        % Year
\tl_new:N \g_notes_place_tl       % Place

% Set default values for data commands
\tl_gset:Nn	\g_notes_title_tl       {Course~Title}
\tl_gset:Nn	\g_notes_speaker_tl     {Lecturer}
\tl_gset:Nn \g_notes_subtitle_tl {
	\tl_if_empty:NF \g_notes_courseid_tl {\g_notes_courseid_tl{},~}
	\tl_if_empty:NF \g_notes_place_tl {\g_notes_place_tl{},~}
	\tl_if_empty:NF \g_notes_term_tl {\g_notes_term_tl{}~}
	\tl_if_empty:NF \g_notes_year_tl {\g_notes_year_tl{}}
}
% \tl_clear_new:N \g_notes_subtitle_tl
\tl_clear_new:N	\g_notes_spkemail_tl
\tl_clear_new:N	\g_notes_scribe_tl
\tl_clear_new:N	\g_notes_scremail_tl
\tl_clear_new:N	\g_notes_courseid_tl
\tl_clear_new:N	\g_notes_term_tl
\tl_clear_new:N	\g_notes_year_tl
\tl_clear_new:N	\g_notes_place_tl

% Provide user-facing interface to document commands
\RenewDocumentCommand\title{ m }{\tl_gset:Nn \g_notes_title_tl {#1}}
\NewDocumentCommand\subtitle{ m }{\tl_gset:Nn \g_notes_subtitle_tl {#1}}
\NewDocumentCommand\speaker{ m }{\tl_gset:Nn \g_notes_speaker_tl {#1}}
\NewDocumentCommand\speakeremail{ m }{\tl_gset:Nn \g_notes_spkemail_tl {#1}}
\NewDocumentCommand\scribe{ m }{\tl_gset:Nn \g_notes_scribe_tl {#1}}
\NewDocumentCommand\scribeemail{ m }{\tl_gset:Nn \g_notes_scremail_tl {#1}}
\NewDocumentCommand\courseid{ m }{\tl_gset:Nn \g_notes_courseid_tl {#1}}
\NewDocumentCommand\term{ m }{\tl_gset:Nn \g_notes_term_tl {#1}}
\NewDocumentCommand\place{ m }{\tl_gset:Nn \g_notes_place_tl {#1}}

% Options specific to notes
\bool_new:N \g_notes_coverpage_bool
\bool_gset_false:N \g_notes_coverpage_bool
\DeclareOption{cover}{\bool_gset_true:N \g_notes_coverpage_bool}


%% Load shared definitions
\input{coursework}

% Wait to redefine \year until after we have loaded Tikz,
% Since pgf uses the default \year command to generate a
% seed for its random-number code.
\RenewDocumentCommand\year{ m }{\tl_gset:Nn \g_notes_year_tl {#1}}


%% Customization for Notes Only
%% ============================


% Table of Contents
\renewcommand{\cfttoctitlefont}{\relax\centering\widekern}
\renewcommand{\cftsecfont}{}
\renewcommand{\cftsecpagefont}{}
\renewcommand{\cftsubsecfont}{\itshape}

% Format Sections
\titleformat{\section}                          % Level
            {\bfseries\Large}                   % Formatting
            {\thesection}                       % Label
            {1em}                               % Label Spacing
            {}                                  % Before Code

\titleformat{\subsection}                       % Level
            {\bfseries\large}                   % Formatting
            {\thesubsection}                    % Label
            {1em}                               % Label Spacing
            {}                                  % Before Code

\titleformat{\subsubsection}
            {\bfseries}
            {\thesubsubsection}
            {1em}
            {}

% Section spacing
\titlespacing\section{0ex}{4ex plus 0.2ex minus 0.2ex}{0ex}
\titlespacing\subsection{0ex}{2ex plus 0.2ex minus 0.2ex}{0ex}
\titlespacing\subsubsection{0ex}{1ex plus 0.1ex minus 0.1ex}{0ex}

% Header/Footer on title page
\fancypagestyle{firstpage}{
	\fancyfoot[L]{
		\tl_if_empty:NTF \g_notes_scremail_tl {} {$^\dagger$\url{\g_notes_scremail_tl}}
	}
	\fancyfoot[C]{}
	\fancyfoot[R]{
		\tl_if_empty:NTF \g_notes_spkemail_tl {} {$^\ast$\url{\g_notes_spkemail_tl}}
	}
	\fancyhead{}
	\renewcommand{\headrulewidth}{0pt}
}

% Title Page
\RenewDocumentCommand\maketitle{}{
	\newpage
	\begin{titlepage}
		\pagenumbering{gobble}
		\thispagestyle{firstpage}
		\raggedright
		\null
		\vskip 4ex
		{\noindent\Huge \g_notes_title_tl{}}
		\tl_if_empty:NF \g_notes_subtitle_tl {
			\vskip 4ex
			{\noindent\large\bfseries \g_notes_subtitle_tl{} }
		}
		\vskip 1ex
		{\noindent\slshape
			\tl_if_empty:NF \g_notes_speaker_tl {
				Taught~by~\g_notes_speaker_tl{}
				\tl_if_empty:NF \g_notes_spkemail_tl {$^\ast$}.~
			}
			\tl_if_empty:NF \g_notes_scribe_tl {
				Transcribed~by~\g_notes_scribe_tl{}
				\tl_if_empty:NF \g_notes_scremail_tl {$^\dagger$}.
			}
		}
		\vskip 7ex
		\noindent\tableofcontents{}
	\end{titlepage}
	\pagenumbering{arabic}
}

% Cover Page
\NewDocumentCommand\makecover{}{
	\newpage
	\begin{titlepage}
		\pagenumbering{gobble}
		\raggedright
		\newpagecolor{cover}
		\afterpage{\restorepagecolor}
		\vspace*{\fill}
		{\noindent\Huge \textcolor{white}{\g_notes_title_tl{}}}
		\tl_if_empty:NF \g_notes_subtitle_tl {
			\vskip 4ex
			{\noindent\large\bfseries \textcolor{white}{\g_notes_subtitle_tl{}} }
		}
		\vspace*{\fill}
	\end{titlepage}
}
                

%% Beginning of Document
\AtBeginDocument{

	% Cover & title pages
	\hypersetup{pageanchor=false}
	\bool_if:NT \g_notes_coverpage_bool{
		\usepackage{pagecolor}
		\usepackage{afterpage}
		\makecover
	}
	\maketitle
	\hypersetup{pageanchor=true}

	% Paragraph formatting
	\usepackage{silence}
	\WarningFilter[parskip]{latex}{Command}
	\ActivateWarningFilters[parskip]
	\usepackage{parskip}
	\DeactivateWarningFilters[parskip]

	% Math spacing
	\abovedisplayshortskip=-\parskip
}

\ExplSyntaxOff