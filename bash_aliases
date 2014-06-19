PATH=$HOME/.cabal/bin:$PATH
alias lxceant='ant -Dhemi.platform=lxce-release'
alias s7ant='ant -Dhemi.platform=S700-release'
alias a8ant='ant -Dhemi.platform=cortexA8-release'
alias i686ant='ant -Dhemi.platform=i686-nptl-release'
alias a8hfant='ant -Dhemi.platform=cortexA8hf-release'
alias maxant='ant -Dhemi.platform=maxintel-release'
alias toolsant='ant -Dhemi.platform=tools-release'
alias 64ant='ant -Dhemi.platform=x86_64_4.8.3-release'
alias devgrep="grep --color --exclude-dir='.svn'"
alias lxcegdb="$HOME/hemi_platform_tools/compilers/arm-CodeSourcery-2010q1-202/bin/arm-none-linux-gnueabi-gdb"
alias make='make -j8'
setterm -blength 0
set bell-style none

rdgrep() {
    devgrep -Rn "$*" .
}

n() {
    gvim + ~/.notes/"$*".md
}

nls() {
    ls -c ~/.notes/ | grep "$*"
}

r() {
    t=$(mktemp --suffix=.html)
    pandoc -f markdown -t html ~/.notes/"$*".md > $t
    google-chrome $t
}

ngrep() {
    grep -C10 --color $1 ~/.notes/$2.md
}

allant() {
    lxceant "$*"
    a8ant "$*"
    i686ant "$*"
    toolsant "$*"
    maxant "$*"
}

export MAKE_CPU_COUNT=8
