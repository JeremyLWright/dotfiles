PATH=$HOME/.cabal/bin:$PATH
alias pmake='make -j8'
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

export MAKE_CPU_COUNT=8
