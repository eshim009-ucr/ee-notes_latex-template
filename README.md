LaTeX Notes Template for Electrical Engineering
===============================================

People have asked me about my setup, so here's a generic template.


Features
--------

 - Spell checking with `aspell`.
 - Incremental builds with GNU Make.


Dependencies
------------

### Linux Packages

```shell
# Ubuntu
sudo apt update
sudo apt install texlive-latex-base texlive-latex-recommended texlive-latex-extra texlive-science texlive-pictures
```

### LaTeX Packages

#### `siunitx`

For SI unit formatting

 - [CTAN](https://www.ctan.org/pkg/siunitx)
 - [Documentation](http://mirrors.ctan.org/macros/latex/contrib/siunitx/siunitx.pdf)

#### `circuitikz`

For circuit diagrams. This also includes `tikz` for more general diagrams.

 - [CTAN](https://www.ctan.org/pkg/circuitikz)
 - [Documentation](https://texdoc.org/serve/circuitikz/0)

#### `hyperref`

For PDF metadata and hyperlinks.

 - [CTAN](https://www.ctan.org/pkg/hyperref)
 - [Documentation](http://mirrors.ctan.org/macros/latex/contrib/hyperref/doc/hyperref-doc.pdf)

#### `float`

For figure placement.

 - [CTAN](https://www.ctan.org/pkg/float)
 - [Documentation](http://mirrors.ctan.org/macros/latex/contrib/float/float.pdf)

#### `caption`

For more complete caption support.

 - [CTAN](https://www.ctan.org/pkg/caption)
 - [Documentation](http://mirrors.ctan.org/macros/latex/contrib/caption/caption.pdf)

#### `steinmetz`

For phasor notation.

 - [CTAN](https://www.ctan.org/pkg/steinmetz)
 - [Documentation](https://mirrors.ctan.org/macros/latex/contrib/steinmetz/README)

#### `subcaption`

For subfigure support.

 - [CTAN](https://www.ctan.org/pkg/subcaption)
 - [Documentation](https://mirror.math.princeton.edu/pub/CTAN/macros/latex/contrib/caption/subcaption.pdf)

#### `mdframed`

For theorem boxes and the like.

 - [CTAN](https://www.ctan.org/pkg/mdframed)
 - [Documentation](https://mirrors.rit.edu/CTAN/macros/latex/contrib/mdframed/mdframed.pdf)


Macros
------

 - `\warn` Prints "Remember!" in red text.
 - `\note` Prints "Note:" in blue text.
 - `\todo{...}` Prints text in red. Good for calling attention to something you
   want to fix later.


Getting Started
---------------

### Required

1. Install the dependencies. TeX Live is probably the best way if you're on
   Linux.

### Optional

1. Update the template with your relevant personal and class information.
	1. Uncomment `pdftitle` on line 5 of `template.tex` and update it with your
	   course number.
	2. Uncomment and update the `pdfauthor` and `pdfsubject` fields on lines 6
	   and 7 of `template.tex` with your own name and class information.
	3. Update the first argument in custom title on line 15 of `template.tex` to
	   include your course number.
2. Update `Makefile` to change the naming convention to include your course
   code. For example, change line 4 to include your course number.


Makefile
--------

The template uses `make` to update source files. If you're using an extension
like
[this one](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)
for VS Code, you don't need to use `make`.

### `make` and `make all`

Builds all PDFs matching the pattern in the `SRC` Makefile variable. By default,
this means any `.tex` files starting with `ee_notes_`. This will prevent
building templates, header files, and included files as separate PDFs.

If you do use include files, you should add a separate recipe for them so that
the files using them update properly. Something like:

```Makefile
ee000_notes_week-04a.pdf: ee000_notes_week-04a.tex header.tex fancy-diagram.tex
	pdflatex --halt-on-error $< $@
```

### `make check`

Uses `aspell` to spell check files. If there are any words that you want to
ignore for spellchecking, but don't want to add to your dictionary, you can add
them to `local-dict.pws`.

You'll probably have to use `local-dict.pws` a lot with long equations, because
`aspell` doesn't differentiate between equation environments and text
environments.

### `make clean-tmp`

Deletes temporary files that are generated during spell checking and PDF
generation.

### `make clean`

Deletes temporary files _and_ outputted PDF files.

If you run this, I'd recommend using `make -j` afterwards to speed up the
rebuilding. `-j` tells make to compile everything in parallel instead of one at
a time.

### `make new`

Copies over the template to a new note file. The name is set to the current ISO
8601 date and the title variables are updated accordingly.
