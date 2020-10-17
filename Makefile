test: cache/dictionary.txt
	bundle exec rspec

cache/dictionary.txt: cache/american-english_2019.10.06-1_all.txt \
	cache/american-english-huge_2019.10.06-1_all.txt \
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
