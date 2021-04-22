LIBDIR := lib
include $(LIBDIR)/main.mk

all:	draft-iab-path-signals-collaboration.txt \
	old/draft-arkko-arch-path-signals-information.txt

$(LIBDIR)/main.mk:
ifneq (,$(shell grep "path *= *$(LIBDIR)" .gitmodules 2>/dev/null))
	git submodule sync
	git submodule update $(CLONE_ARGS) --init
else
	git clone -q --depth 10 $(CLONE_ARGS) \
	    -b main https://github.com/martinthomson/i-d-template $(LIBDIR)
endif

#	cat draft-iab-path-signals-collaboration.md  | kramdown-rfc2629 --v3 | lib/add-note.py | xml2rfc -q --cache=$(HOME)/.cache/xml2rfc --v2v3 /dev/stdin -o draft-iab-path-signals-collaboration.xml

# draft-iab-path-signals-collaboration.txt draft-iab-path-signals-collaboration.html

compile actually-working-compile-without-v3-garbage: draft-iab-path-signals-collaboration.md
	-@ssh jar@levy4.arkko.eu 'cd /tmp; rm *.txt *.md *.xml'
	scp draft-iab-path-signals-collaboration.md old/draft-arkko-path-signals-information.md jar@levy4.arkko.eu:/tmp
	ssh jar@levy4.arkko.eu 'cd /tmp; cat draft-iab-path-signals-collaboration.md  | kramdown-rfc2629 | lib/add-note.py > draft-iab-path-signals-collaboration-pre.xml'
	ssh jar@levy4.arkko.eu 'cd /tmp; xml2rfc -q --cache=/home/jar/.cache/xml2rfc --v2v3 draft-iab-path-signals-collaboration-pre.xml -o draft-iab-path-signals-collaboration.xml'
	ssh jar@levy4.arkko.eu 'cd /tmp; xml2rfc -q --cache=/home/jar/.cache/xml2rfc draft-iab-path-signals-collaboration.xml -o draft-iab-path-signals-collaboration.txt --text'
	ssh jar@levy4.arkko.eu 'cd /tmp; xml2rfc -q --cache=/home/jar/.cache/xml2rfc draft-iab-path-signals-collaboration.xml -o draft-iab-path-signals-collaboration.html --html'
	scp jar@levy4.arkko.eu:/tmp/draft-iab-path-signals-collaboration.txt .
	scp jar@levy4.arkko.eu:/tmp/draft-iab-path-signals-collaboration.html .
	ssh jar@levy4.arkko.eu 'cd /tmp; cat draft-arkko-path-signals-information.md  | kramdown-rfc2629 | lib/add-note.py > draft-arkko-path-signals-information-pre.xml'
	ssh jar@levy4.arkko.eu 'cd /tmp; xml2rfc -q --cache=/home/jar/.cache/xml2rfc --v2v3 draft-arkko-path-signals-information-pre.xml -o draft-arkko-path-signals-information.xml'
	ssh jar@levy4.arkko.eu 'cd /tmp; xml2rfc -q --cache=/home/jar/.cache/xml2rfc draft-arkko-path-signals-information.xml -o draft-arkko-path-signals-information.txt --text'
	ssh jar@levy4.arkko.eu 'cd /tmp; xml2rfc -q --cache=/home/jar/.cache/xml2rfc draft-arkko-path-signals-information.xml -o draft-arkko-path-signals-information.html --html'
	scp jar@levy4.arkko.eu:/tmp/draft-arkko-path-signals-information.txt ./old
	scp jar@levy4.arkko.eu:/tmp/draft-arkko-path-signals-information.html ./old
	scp jar@levy4.arkko.eu:/tmp/draft-iab-path-signals-collaboration.txt .
	scp jar@levy4.arkko.eu:/tmp/draft-iab-path-signals-collaboration.html .
	scp draft-*-path-signals-*.txt draft-*-path-signals-*.html root@cloud3.arkko.eu:/var/www/www.arkko.com/html/ietf/iab
