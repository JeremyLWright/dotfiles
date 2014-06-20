#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir="$( cd "$( dirname "$0" )" && pwd )"
olddir=${dir}_old             # old dotfiles backup directory
files=$(find . -maxdepth 1 -type f \( -iname "*" ! -iname make.sh ! -iname ".*" \))   # list of files/folders to symlink in homedir

##########
mkdir -p $olddir

cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    if [ -e ~/.$file ]
    then
        echo "Moving .$file $olddir"
        mv ~/.$file $olddir
    fi
    f=$(basename $file)
    ln -s -f $dir/$f ~/.$(basename $f)
done
