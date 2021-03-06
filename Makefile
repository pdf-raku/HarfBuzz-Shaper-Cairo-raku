SRC=src
DocProj=harfbuzz-raku.github.io
DocRepo=https://github.com/harfbuzz-raku/$(DocProj)
DocLinker=../$(DocProj)/etc/resolve-links.raku

all :

docs/index.md : README.md
	cp $< $@

README.md : lib/HarfBuzz/Shaper/Cairo.rakumod
	raku -I . --doc=Markdown $< \
	| TRAIL=HarfBuzz/Shaper/Cairo raku -p -n  $(DocLinker) \
        > $@

$(DocLinker) :
	(cd .. && git clone $(DocRepo) $(DocProj))

doc : $(DocLinker) README.md docs/index.md

test : all
	@prove6 -I . t

loudtest : all
	@prove6 -I . -v t

clean :
	echo cleaned

realclean : clean
	@rm -f Makefile README.md docs/*.md


