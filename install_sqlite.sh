#Install sqlite v 3.30.1 libs
#!/bin/bash
rm -rf ${WORKSPACE}/sqlite*
wget -q "https://www.sqlite.org/2019/sqlite-src-3300100.zip"
unzip "sqlite-src-3300100.zip" > /dev/null 2>&1 &&
cd /usr/sqlite-src-3300100
./configure --bindir=/usr/sqlite3301/bin --libdir=/usr/sqlite3301/lib --includedir=/usr/sqlite3301/include &&
make > /dev/null 2>&1 &&
make install > /dev/null 2>&1 || true
