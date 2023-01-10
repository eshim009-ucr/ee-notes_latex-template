### DEFINITIONS ###
# LaTeX source files #
# The prefix is used to separate node documents from templates and subdocuments
PREFIX=ee_notes_
SRC=$(wildcard $(PREFIX)*.tex)

# Output PDF files #
PDF=$(subst .tex,.pdf,$(SRC))

# pdflatex build logs #
LOG=$(subst .pdf,.log,$(PDF))

# pdflatex temp files #
AUX=$(subst .pdf,.aux,$(PDF))
OUT=$(subst .pdf,.out,$(PDF))

# Spellcheck backup files #
BAK=$(wildcard *.tex.bak)


### TARGETS ###
all: $(PDF)

# Build PDF #
%.pdf: %.tex header.tex
	pdflatex --halt-on-error $< $@

# Spellcheck source files #
check:
	find . -type f -name '*.tex' -exec \
		aspell --extra-dicts ./local-dict.pws check -t {} \
	\;

# Generate a new notes document from the template #
new:
	NEW_FILENAME="$(PREFIX)$$(date -I).tex" && \
	cp -n template.tex $$NEW_FILENAME && \
	sed -i -e "s/\\\todo{DATE}/$$(date '+%B %-d, %Y')/g" $$NEW_FILENAME && \
	sed -i -e "s/\\\todo{DAY}/$$(date '+%A')/g" $$NEW_FILENAME

# Remove all output files #
clean: clean-tmp
	rm -f $(PDF)

# Remove temporary files #
clean-tmp:
	rm -f $(BAK) $(AUX) $(LOG) $(OUT)
