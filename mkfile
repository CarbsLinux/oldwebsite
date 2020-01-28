MKSHELL=/usr/local/plan9/bin/rc
MARKDOWNOPTS="-html5 -squash"

all:Q: html repository static
	echo Built website

html:V: header footer repository wiki blog
	for(dir in `{find src -type d}) mkdir -p `{ echo $dir | sed 's/src/site/'}
	for(md in `{find src -name '*.md'})\
	outputhtml=`{echo $md | sed -e 's/src/site/' -e 's/.md/.html/'}{\
	mkdir -pv `{dirname $outputhtml} ; \
	TITLE=`{basename $md | cut -d . -f 1} sh ./header; \
	markdown -f toc -html5 -squash $md; \
	sh ./footer} > $outputhtml

static: html
	for(file in `{find src -type f}){
	if ( echo $file | grep -q '.md' ) true
	if not cp $file `{echo $file | sed 's/src/site/'}}

header:
	cat `{find templates -name '*.header' | sort } > \
		header
	chmod +x header

footer:
	cat `{find templates -name '*.footer' | sort } > \
		footer
	chmod +x footer

repository:V:
	sh -c 'scripts/gen-db ./src'

blog:V:
	sh -c 'scripts/gen-blog ./blog ./src'

wiki:V:
	git clone --quiet --depth 1 git://git.carbslinux.org/wiki wiki
	mv wiki/wiki.carbslinux.org src/wiki
	rm -rf wiki
	sh -c 'scripts/gen-wiki-index'

clean:V:
	rm -rf site footer header src/blog src/rss.xml \
	src/packages src/wiki site.tar.gz \
		website-master.tar.gz

dist:V: clean
	mkdir website-master
	cp -R README mkfile blog scripts src templates \
		website-master
	tar -cf website-master.tar website-master
	gzip website-master.tar
	rm -rf website-master

pkg:QV: clean all
	tar -cf site.tar site
	gzip site.tar

install:V: all
	[ $#DESTDIR -eq 1 ]
	cp -r site $DESTDIR
