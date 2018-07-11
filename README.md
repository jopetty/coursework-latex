# The `coursework` Classes

This repository contains the latest versions of two LaTeX 3 classes: `pset` and `notes`. These are designed to be used by college students or instructors to typeset materials relating to primarily Science and Mathematics courses, although they can be easily used in the Humanities and Social Sciences as well, if you are so inclined. They share common functionality and a unified design.

## Goals
The goals of the two projects have not really changed; these classes are designed to be

- **Easy to Use:** Ideally, you shouldn't need to do *any* extra work to use these classes. Just load the class, provide the requisite data, and start writing. The class should take care of loading most commonly used packages and defining macros so that you can maintain consistent functionality and formatting for all of your documents;

- **Unicode Compatible:** These documents should be able to handle whatever text you throw at them, in any langauge you need. In addition to being fully `xelatex` and `lualatex` compatible, the classes define custom font families, macros, and document environments for Arabic and Persian text;

- **LaTeX 3 Compatible:** These classes are created using `expl3` and use the `LaTeX 3` engine. This is partially because the LaTeX project will ultimately move to LaTeX 3 which makes it prudent to adopt this technology as soon as possible, partially because I find `expl3` much easier to program in that LaTeX 2ε (or plain TeX), and partially as an excercise for myself to learn a new language;

- **Adaptable:** Early versions of the `homework` class (now called `pset`) required the use of `xelatex`, the classes are now fully compatible with `pdflatex` as well. While I still like to use `xelatex` in a lot of circumstances, `pdflatex` is much faster and has better support for `microtype` adjustments, which makes it a really useful choice. The `coursework` classes also are fully compatible with `lualatex`, which is needed to create Feynman diagrams.

## Shared Features
The two class repositories were merged because I found that in while the they were separate, I was writing and maintaining almost identical code to provide the 'back end' of the class --- things like common macros, loading the same packages, and so on. In unifying the repositories, I hope to maintain less code while making both classes more functional. I also want to strive to maintain full backwards compatability with the previous classes, up to a point. 

Both classes have a similar document layout. The page is slightly asymmetric, with more space on the right side of the page than on the left. This allows for notes (both footnotes and margin notes) to be placed in the margin, directly adjacent to the citing text. This means that the eye has to travel less distance and the pace of reading is not so jarringly interrupted when you want to see the note. Footnotes are automatically placed in the margin, and the `\note{}` command will place any other text in the margin as well.

### Mathematics
These classes define the following theorem-like environments for consistent formatting.

- `problem`, `exercise`: This is the most useful environment for problem sets. Any text inside is set within a light grey box to differentiate it from solutions, proofs, and any surrounding text.
	- Also useful here is the `parts` environment and the `\part` command which lets you define multiple steps for a given problem. `\part` allows for an optional argument which becomes the internal reference label of that step, allowing you to reference the part later in the document. E.g., `\part[4a]` and `\ref{4a}`.
- `example`: This is identical to the problem environment, except the background is a light gold instead of grey.
- `proof`: The regular proof environment provided by `amstex`. Ends with a QED symbol, which is by default a black square.
- `solution`: Identical to the proof environment, execept it has the word *Solution* in place of the word *Proof*. Provided just to save  time and keystrokes.
- `lemma`, `theorem`, `corollary`, `conjecture`: These environments have a bold header with italic body text.
- `definition`, `notation`, `abuse`: The Definition, Notaiton, and Abuse of Notation environments have unformatted body text with a bold header, and are indented by a centimeter on either side.

The `\final{}` command draws a box around whatever expression it encloses, providing a visually distinctive way to identify the final step or result in a proof or solution.

### Physics
By default, we load the `siunitx` package to provide formatting for units. The classes also define the following non-SI (but still useful) units:

- `\mile`
- `\gallon`
- `\pound`
- `\foot`
- `\atmosphere`
- `\fahrenheit`
- `\atom`
- `\molecule`
- `\calorie`
- `\Calorie`
- `\inch`

There is also the `\unit{}` command, which is meant to typeset a unit vector. The expression inside will be bolded, and have a circumflex accent attached, so `\unit{a}` becomes **â**.

The `coursework` classes also provide the option to load the `tikz-feynman` and `circuitikz` packages for creating Feynman diagrams and circuit schematics. These packages require the `[diagram]` option be passed to the document class.

### Chemistry
The `coursework` classes load the `mhchem` package by default. They also provide the option to load the `chemfig` package to create chemical structure diagrams. This requires the `[diagram]` option be passed to the document class.

### Linguistics
These classes provide the following commands to aid in typesetting Linguistics documents:

- `\phon{}`: Specifies a particular phoneme. The relevant symbol is placed between slashes, so `\phon{j}` becomes `/j/`.
- `\allo{}`: Specifies an allophone of a particular sound. The relevant symbol is placed between braces, so `\allo{j}` becomes `[j]`.
- `\orth{}`: Specifies an orthographic character. The relevant symbol is placed between angle brackets, so `\orth{j}` becomes `〈j〉`.

In addition, there is also the `\ipafont` command, which typesets the particular group in a font which is fully capable of redering IPA symbols. Be default, this is just the main body font of the document, but you can redefine it if you want to choose a distinct font for IPA text. This will affect all instances of the above three commands.

We also provide the `\where` command, which renders as a large slash. This is meant to be used when defining sound change rules, so `\phon{j} \to \phon{y} \where \text{C\_}` becomes `/j/ → /y/ ／ C_`.

### Class Options
#### Fonts
There are two options for fonts; Libertine and Computer Modern (Unicode). By default, the document will be typeset in Libertine. To load the Computer Modern font family, pass the `cmu` option to the document class. This will load either the `lmodern` package if you compile with `pdflatex` or attempt to load the `Computer Modern Unicode` font, which must be separately installed on your computer.

If you don't like either of these font choices, you can of course load your own font with `xelatex` or find a suitable package for `pdflatex`, and simply set these in the document preamble, after you have loaded the relevant class.

#### Source Code
If you want to include source code or algorithms in you document, pass the `code` option to the document class. This will load the following packages:

- `minted`
- `algorithm`
- `algpseudocode`

You must have the Python package `pygments` installed separately to use this feature. Note that since `minted` requires executing code outside the `latex` kernel, you'll need to pass the `-shell-escape` flag when you compile. Additionally, if you are compiling with `xelatex` you may also need to pass the `-8bit` flag after the `-shell-escape` flag to correct a formatting issue wherein tab literals are improperly displayed.

#### Diagrams
If you want to draw any kinds of diagrams, including circuits, chemical figures, and Feynman diagrams, pass the `[diagram]` option to the class. This will load the following packages:

- `tikz`
- `pgfplots`
- `circuitikz` with the `[american]` and `[siunitx]` options
- `chemfig`
- `tikz-feynman`

### Class Options
- `[cmu]`: tells the class to use the Computer Modern fonts instead of the Libertine fonts
- `[diagram]`: loads the `tikz`, `pgfplots`, `circuitikz`, and `tikz-feynman` packages
- `[code]`: loads the `minted`, `algorithm`, and `algpseudocode` packages. 

## Installation
To install the `coursework` classes, download the latest release from GitHub. Create a new directory named `coursework/` in the `texmf/tex/generic/` directory, and symlink `notes.cls`, `pset.cls`, and `coursework.tex` into this new directory.









