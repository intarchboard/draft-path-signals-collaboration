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

OLDREVNO=01
OLDREV=draft-iab-path-signals-collaboration-$(OLDREVNO).txt
PORT=-p 8820
SCPPORT=-P 8820
MACHINE=jar@cloud2.arkko.eu
VERSOPT=
#VERSOPT="--v2v3"

compile: draft-iab-path-signals-collaboration.md
	-@ssh $(PORT) $(MACHINE) 'cd /tmp; rm *.txt *.md *.xml'
	scp draft-iab-path-signals-collaboration.md $(OLDREV) draft-iab-path-signals-collaboration-beforejuly.txt old/draft-arkko-path-signals-information.md $(MACHINE):/tmp
	ssh $(PORT) $(MACHINE) 'cd /tmp; cat draft-iab-path-signals-collaboration.md  | kramdown-rfc2629 | lib/add-note.py > draft-iab-path-signals-collaboration-pre.xml'
	ssh $(PORT) $(MACHINE) 'cd /tmp; xml2rfc -q --cache=/home/jar/.cache/xml2rfc $(VERSOPT) draft-iab-path-signals-collaboration-pre.xml; cp draft-iab-path-signals-collaboration-pre.txt draft-iab-path-signals-collaboration.txt'
	scp $(SCPPORT) $(MACHINE):/tmp/draft-iab-path-signals-collaboration.txt .
	ssh $(PORT) $(MACHINE) 'cd /tmp; rfcdiff $(OLDREV) draft-iab-path-signals-collaboration.txt'
	scp $(SCPPORT) $(MACHINE):/tmp/draft-iab-path-signals-collaboration-pre.xml \
		./draft-iab-path-signals-collaboration.xml
	scp $(SCPPORT) $(MACHINE):/tmp/draft-iab-path-signals-collaboration.txt \
		$(MACHINE):/tmp/draft-iab-path-signals-collaboration-from-arkko-iab-path-signals-collaboration-$(OLDREVNO).diff.html \
		.
	scp draft-*-path-signals-*.txt draft-*-path-signals-*.html root@cloud3.arkko.eu:/var/www/www.arkko.com/html/ietf/iab
	ssh root@cloud3.arkko.eu rm /var/www/www.arkko.com/html/ietf/iab/draft-iab-path-signals-collaboration.html

oldcompile actually-working-compile-without-v3-garbage: draft-iab-path-signals-collaboration.md
	-@ssh $(PORT) $(MACHINE) 'cd /tmp; rm *.txt *.md *.xml'
	scp $(SCPPORT) draft-iab-path-signals-collaboration.md txt/$(OLDREV) txt/draft-iab-path-signals-collaboration-beforejuly.txt old/draft-arkko-path-signals-information.md $(MACHINE):/tmp
	ssh $(PORT) $(MACHINE) 'cd /tmp; cat draft-iab-path-signals-collaboration.md  | kramdown-rfc2629 | lib/add-note.py > draft-iab-path-signals-collaboration-pre.xml'
	ssh $(PORT) $(MACHINE) 'cd /tmp; xml2rfc -q --cache=/home/jar/.cache/xml2rfc $(VERSOPT) draft-iab-path-signals-collaboration-pre.xml -o draft-iab-path-signals-collaboration.txt'
	scp $(SCPPORT) $(MACHINE):/tmp/draft-iab-path-signals-collaboration.txt .
	ssh $(PORT) $(MACHINE) 'cd /tmp; rfcdiff $(OLDREV) draft-iab-path-signals-collaboration.txt'
	scp $(SCPPORT) $(MACHINE):/tmp/draft-iab-path-signals-collaboration.txt \
		$(MACHINE):/tmp/draft-iab-path-signals-collaboration-from--$(OLDREVNO).diff.html \
		.
	scp draft-*-path-signals-*.txt draft-*-path-signals-*.html root@cloud3.arkko.eu:/var/www/www.arkko.com/html/ietf/iab

#	scp $(SCPPORT) $(MACHINE):/tmp/draft-iab-path-signals-collaboration.html .
#	ssh $(PORT) $(MACHINE) 'cd /tmp; xml2rfc -q --cache=/home/jar/.cache/xml2rfc draft-iab-path-signals-collaboration.xml -o draft-iab-path-signals-collaboration.txt --text'
#	ssh $(PORT) $(MACHINE) 'cd /tmp; xml2rfc -q --cache=/home/jar/.cache/xml2rfc draft-iab-path-signals-collaboration.xml -o draft-iab-path-signals-collaboration.html --html'
#	ssh $(SCPPORT) $(MACHINE) 'cd /tmp; cat draft-arkko-path-signals-information.md  | kramdown-rfc2629 | lib/add-note.py > draft-arkko-path-signals-information-pre.xml'
#	ssh $(PORT) $(MACHINE) 'cd /tmp; xml2rfc -q --cache=/home/jar/.cache/xml2rfc --v2v3 draft-arkko-path-signals-information-pre.xml -o draft-arkko-path-signals-information.txt'
#	ssh $(PORT) $(MACHINE) 'cd /tmp; xml2rfc -q --cache=/home/jar/.cache/xml2rfc draft-arkko-path-signals-information.xml -o draft-arkko-path-signals-information.txt --text'
#	ssh $(PORT) $(MACHINE) 'cd /tmp; xml2rfc -q --cache=/home/jar/.cache/xml2rfc draft-arkko-path-signals-information.xml -o draft-arkko-path-signals-information.html --html'
