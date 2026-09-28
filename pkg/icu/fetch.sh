set -e

. ./paths.sh
dir=$1

cd "$distdir"

if ! sh "$basedir/scripts/checksum.sh" -c "$basedir/$dir/sha256" 2>/dev/null ; then
	curl -fL -K "$basedir/$dir/url" -O
	sh "$basedir/scripts/checksum.sh" -c "$basedir/$dir/sha256"
fi

cd "$basedir/$dir"
rm -rf src

sh "$basedir/scripts/extract.sh" "$distdir/icu4c-78.2-sources.tgz" -s ',^icu/source,src,'

# the sed only lifts icu/source; drop the rest the tarball leaves next to
# src/ (as_is, testdata, packaging, reports)
rm -rf icu

if [ -d patch ] ; then
	cd src
	git init -q .
	git apply -v --whitespace=nowarn ../patch/*.patch
fi
