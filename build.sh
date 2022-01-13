compile(){
	./gradlew clean pkg
	rm -rf packages
	mkdir -p packages
	mv build/pkg/*.jar packages/
	mv packages/*.jar packages/all.jar
}
extract(){
	rm -rf extract
	mkdir -p extract
	unzip packages/all.jar -d extract/ > /dev/null
}
linux-x86_64(){
  target=target/linux-x86_64
  name=linux-x86_64.jar

	mkdir -p $target/extract $target/tmp
	cp -r extract $target
	# rocksdb
	mv $target/extract/librocksdbjni-linux64.so $target/tmp
	rm $target/extract/librocksdbjni*
	mv $target/tmp/librocksdbjni-linux64.so $target/extract
	# package
	jar -c -f packages/$name -C $target/extract/ .
	rm -rf $target
}
linux-x86(){
  target=target/linux-x86
  name=linux-x86.jar

	mkdir -p $target/extract $target/tmp
	cp -r extract $target
	# rocksdb
	mv $target/extract/librocksdbjni-linux32.so $target/tmp
	rm $target/extract/librocksdbjni*
	mv $target/tmp/librocksdbjni-linux32*.so $target/extract
	# package
	jar -c -f packages/$name -C $target/extract/ .
	rm -rf $target
}
linux-aarch64(){
  target=target/linux-aarch64
  name=linux-aarch64.jar

	mkdir -p $target/extract $target/tmp
	cp -r extract $target
	# rocksdb
	mv $target/extract/librocksdbjni-linux-aarch64.so $target/tmp
	rm $target/extract/librocksdbjni*
	mv $target/tmp/*.so $target/extract
	# package
	jar -c -f packages/$name -C $target/extract/ .
	rm -rf $target
}
windows-x86_64(){
  target=target/windows-x86_64
  name=windows-x86_64.jar

	mkdir -p $target/extract $target/tmp
	cp -r extract $target
	# rocksdb
	mv $target/extract/librocksdbjni-win64.dll $target/tmp
	rm $target/extract/librocksdbjni*
	mv $target/tmp/librocksdbjni-win64.dll $target/extract
	# package
	jar -c -f packages/$name -C $target/extract/ .
	rm -rf $target
}
mac-x86_64(){
  target=target/mac-x86_64
  name=mac-x86_64.jar

	mkdir -p $target/extract $target/tmp
	cp -r extract $target
	# rocksdb
	mv $target/extract/librocksdbjni-osx.jnilib $target/tmp
	rm $target/extract/librocksdbjni*
	mv $target/tmp/librocksdbjni-osx.jnilib $target/extract
	# package
	jar -c -f packages/$name -C $target/extract/ .
	rm -rf $target
}
all_target(){
	linux-x86_64
	linux-x86
	linux-aarch64
	windows-x86_64
	mac-x86_64
	cd packages
	prefix=kato-
	for files in $(ls *.jar)
		do mv $files $prefix$files
	done
	cd ..
}
clean(){
	rm -rf extract target
}
build(){
	compile
	extract
	all_target
	clean
}
build

