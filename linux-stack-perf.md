
> uperf 使用记录 

  ./configure --enable-ssl=yes --enable-sctp=no --enable-debug=yes

  make -j

  ./src/uperf -v -a -i 3 -m ../uperf.profile.txt

  看起来有个 master  slave， 没看懂, slave 先启动，然后listen port=20000, master 来启动