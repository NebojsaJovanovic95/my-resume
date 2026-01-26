# Files (override from CLI if you want)
MD   ?= resume.md
HTML ?= resume.html
PDF  ?= resume.pdf
CSS  ?= resume.css
HEAD ?= header.html

PANDOC = pandoc
CHROME = chromium

.PHONY: all html pdf clean

all: pdf

html: $(HTML)

pdf: $(PDF)
	xdg-open $(PDF)

$(HTML): $(MD) $(CSS) $(HEAD)
	$(PANDOC) $(MD) \
		-s \
		-c $(CSS) \
		--include-in-header=$(HEAD) \
		-o $(HTML)

$(PDF): $(HTML)
	$(CHROME) \
		--headless \
		--disable-gpu \
		--print-to-pdf=$(PDF) \
		$(HTML)

clean:
	rm -f $(HTML) $(PDF)

