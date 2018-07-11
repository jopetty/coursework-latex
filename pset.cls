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
\tl_const:Nn \c__coursework_class_parent_class_tl    {article}

\ProvidesExplClass{\c__pset_class_name_tl}         % Class
                  {\c__pset_class_date_tl}         % Date
                  {\c__pset_class_version_tl}      % Version
                  {\c__pset_class_description_tl}  % Description

%% Define Class Data
%% -----------------
%% Data set by the user about the assignment.
%% Used to create headers, title page, etc.
\tl_new:N \g_pset_title_tl    % Title of the assignment
\tl_new:N \g_pset_author_tl   % Your name
\tl_new:N \g_pset_duedate_tl  % When the assignment is due
\tl_new:N \g_pset_course_tl   % What course the assignment is for

% Clear and set default values
\tl_clear_new:N \g_pset_title_tl
\tl_clear_new:N \g_pset_author_tl
\tl_clear_new:N \g_pset_course_tl
\tl_gset:Nn \g_pset_duedate_tl {\today}

% Provide user-facing interface to the data
\RenewDocumentCommand\title{ m }{ \tl_gset:Nn \g_pset_title_tl {#1} }
\RenewDocumentCommand\author{ m }{ \tl_gset:Nn \g_pset_author_tl {#1} }
\NewDocumentCommand\name{ m }{ \author{#1} }
\NewDocumentCommand\due{ m }{ \tl_gset:Nn \g_pset_duedate_tl {#1} }
\RenewDocumentCommand\date{ m }{ \due{#1} }
\NewDocumentCommand\course{ m }{ \tl_gset:Nn \g_pset_course_tl {#1} }
\NewDocumentCommand\class{ m }{ \course{#1} }

%% Load shared definitions
\input{coursework.tex}

%% Customization for Pset Only
%% ============================

%% Redefine \maketitle
\RenewDocumentCommand\maketitle{}{
	\newpage
	\null
	\begin{flushright} \scshape
		\g_pset_author_tl{} \\
		\g_pset_course_tl{} \\
		\g_pset_duedate_tl{} \\
	\end{flushright}
	\begin{center}
		{\Large\scshape\g_pset_title_tl{}}
	\end{center}
	\vspace\baselineskip
}

\AtBeginDocument{
	\maketitle
}

\ExplSyntaxOff