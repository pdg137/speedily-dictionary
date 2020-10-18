#  install instructions
#      	- ruby on the Mac is too old (2.3.7), so install it with "brew"
#	  and then put /usr/local/opt/ruby/bin on your path
#	- run "gem install bundle"
#	- run "bundle update --bundler"

all : cache/dictionary.txt cache/wamerican_2019.10.06-1_all.deb
all : cache/american-english_2019.10.06-1_all.txt
all : cache/wamerican-huge_2019.10.06-1_all.deb
all : cache/american-english-huge_2019.10.06-1_all.txt

clean : ; rm -rf tmp cache

check : 	cache/dictionary.txt					\
		cache/american-english_2019.10.06-1_all.txt		\
		cache/american-english-huge_2019.10.06-1_all.txt
	for w in qaid qadi ;							\
	do for i in $^ ;							\
	   do grep -q $$w $$i || ( echo "word $$w missing in $$i" >&2  ) ;	\
	   done									\
	done

test: cache/dictionary.txt
	bundle exec rspec

cache/dictionary.txt: cache/american-english_2019.10.06-1_all.txt	\
		cache/american-english-huge_2019.10.06-1_all.txt	\
		lib/dictionary_reader.rb lib/make_dictionary.rb
	bundle exec ruby lib/make_dictionary.rb

cache/wamerican_2019.10.06-1_all.deb:
	mkdir -p cache
	curl https://mirrors.edge.kernel.org/ubuntu/pool/main/s/scowl/wamerican_2019.10.06-1_all.deb -o $@

cache/american-english_2019.10.06-1_all.txt: cache/wamerican_2019.10.06-1_all.deb
	mkdir -p tmp
	cd tmp && ar x ../$< && tar xf ./data.tar.xz ./usr/share/dict/american-english
	cp tmp/usr/share/dict/american-english $@

cache/wamerican-huge_2019.10.06-1_all.deb:
	mkdir -p cache
	curl http://mirrors.edge.kernel.org/ubuntu/pool/universe/s/scowl/wamerican-huge_2019.10.06-1_all.deb -o $@

cache/american-english-huge_2019.10.06-1_all.txt: cache/wamerican-huge_2019.10.06-1_all.deb
	mkdir -p tmp
	cd tmp && ar x ../$< && tar xf ./data.tar.xz ./usr/share/dict/american-english-huge
	cp tmp/usr/share/dict/american-english-huge $@
