set -e
. ./paths.sh
dir=$1
cd "$distdir"

if ! sh "$basedir/scripts/checksum.sh" -c "$basedir/$dir/sha256" 2>/dev/null ; then
	curl -fL -K "$basedir/$dir/url" -O
	sh "$basedir/scripts/checksum.sh" -c "$basedir/$dir/sha256"
fi

cd "$basedir/$dir"

rm -rf src protobuf-2.6.1
sh "$basedir/scripts/extract.sh" "$distdir/protobuf-2.6.1.tar.bz2" -s ',^[^/]*,protobuf-2.6.1,'
mv protobuf-2.6.1/src src
rm -rf protobuf-2.6.1

if [ -d patch ] ; then
	git apply -v --whitespace=nowarn --directory "$dir/src" patch/*.patch
fi
