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
sh "$basedir/scripts/extract.sh" "$distdir/gtk-3.24.38.tar.xz" -s ',^[^/]*,src,'
