LIBDIR := lib
include $(LIBDIR)/main.mk

all: draft-iab-path-signals-collaboration.txt

$(LIBDIR)/main.mk:
ifneq (,$(shell grep "path *= *$(LIBDIR)" .gitmodules 2>/dev/null))
	git submodule sync
	git submodule update $(CLONE_ARGS) --init
else
	git clone -q --depth 10 $(CLONE_ARGS) \
	    -b main https://github.com/martinthomson/i-d-template $(LIBDIR)
endif

#	cat draft-iab-path-signals-collaboration.md  | kramdown-rfc2629 --v3 | lib/add-note.py | xml2rfc -q --cache=$(HOME)/.cache/xml2rfc --v2v3 /dev/stdin -o draft-iab-path-signals-collaboration.xml

draft-iab-path-signals-collaboration.txt draft-iab-path-signals-collaboration.html: draft-iab-path-signals-collaboration.md
	cat draft-iab-path-signals-collaboration.md  | kramdown-rfc2629 --v3 | lib/add-note.py > draft-iab-path-signals-collaboration-pre.xml
	xml2rfc -q --cache=$(HOME)/.cache/xml2rfc --v2v3 draft-iab-path-signals-collaboration-pre.xml -o draft-iab-path-signals-collaboration.xml
	xml2rfc -q --cache=$(HOME)/.cache/xml2rfc --css=lib/v3.css draft-iab-path-signals-collaboration.xml -o draft-iab-path-signals-collaboration.html --html
	xml2rfc -q --cache=$(HOME)/.cache/xml2rfc --css=lib/v3.css draft-iab-path-signals-collaboration.xml -o draft-iab-path-signals-collaboration.txt --text

copy:	draft-iab-path-signals-collaboration.txt draft-iab-path-signals-collaboration.html
	scp draft-iab-path-signals-collaboration.txt draft-iab-path-signals-collaboration.html root@cloud3.arkko.eu:/var/www/www.arkko.com/html/ietf/iab
