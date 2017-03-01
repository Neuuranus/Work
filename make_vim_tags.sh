#!/bin/sh
maketags()
{
    if [ -f tags ]; then
        rm tags;
    fi
    if [ -f filenametags ]; then
        rm filenametags
    fi
    ctags -R --exclude="out" --exclude="cts" --exclude="developers" --exclude="development" --exclude="docs" --exclude="flashing-files" --exclude="ndk" --exclude="oem-release" --exclude="prebuilts" --exclude="sdk" --exclude="*git" --exclude=".repo" --languages=Java,C,C++,Make,Sh
    (echo '!'"_TAG_FILE_SORTED        2       /2=foldcase/";(find . \( -name out -o -name cts -o -name developers -o -name development -o -name docs -o -name flashing-files -o -name ndk -o -name oem-release -o -name prebuilts -o -name sdk -o -name .repo -o -wholename '*\/.git' \) -prune -o -regex '.*\.\(java\|cpp\|c\|cc\|h\|hh\|mk\|Makefile\|sh\|prop\|rc\|aidl\)' -type f -printf "%f\t%p\t1\n" | sort -f)) > ./filenametags
}

listdirs()
{
    for file in $(ls)
    do
        if [ -f $file/tags ]; then
            cd $file;
            pwd;
            maketags;
            cd ..;
        fi
    done
}

cd /home/liuzhigang/Code/
listdirs
cd /home/liuzhigang/Ext/Code/
listdirs
