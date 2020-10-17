all: cache/american-english_2019.10.06-1_all.txt

cache/wamerican_2019.10.06-1_all.deb:
	mkdir -p cache
	curl https://mirrors.edge.kernel.org/ubuntu/pool/main/s/scowl/wamerican_2019.10.06-1_all.deb -o $@

cache/american-english_2019.10.06-1_all.txt: cache/wamerican_2019.10.06-1_all.deb
	mkdir -p tmp
	cd tmp && ar x ../$< && tar xf ./data.tar.xz ./usr/share/dict/american-english
	cp tmp/usr/share/dict/american-english $@
