#!/usr/bin/env fish

function download_and_print
    set article phrack$argv[1]
    
    echo "========> ARTICLE $article"

    mkdir $article; and cd $article
    wget --quiet -c http://phrack.org/archives/tgz/$article.tar.gz
    tar zxf $article.tar.gz
    enscript -p $article.ps (ls -v *.txt); and ps2pdf $article.ps $article.pdf
    rm -rf $article.ps
    cd ..
end

echo "========> Installing dependencies"
sudo apt-get -qq update; and sudo apt-get -qqy install enscript wget tar ghostscript

set from $argv[1]
set to $argv[2]

if not test "$from" -gt 0
    set from 1
    echo "Using default value for arg1 (from)"
end

if not test "$to" -gt "$from"
    set to 69 # last article number to date
    echo "Using default value for arg2 (to)"
end

echo "========> Will get articles from $from to $to"

rm -rf phrack-articles
mkdir phrack-articles; and cd phrack-articles

for i in (seq $from $to)
    download_and_print $i
end
