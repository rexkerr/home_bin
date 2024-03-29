alias vless='vim -u /home/rkerr/.local/share/vim/vim90/macros/less.vim'
alias cclip='xclip -selection clipboard'
alias make='make -j`nproc --all`'
alias mri='makeroot install'
alias gpg2clear='gpg-connect-agent reloadagent /bye'
alias bnclip='branchname | cclip'
alias pushup='git push -u origin $(branchname)'
alias d='cdbr >/dev/null && cdpr > /dev/null && cd ../debug'
alias r='cdbr >/dev/null && cdpr > /dev/null && cd ../release'
alias dbin='cdbr >/dev/null && cdpr > /dev/null && cd ../debug/install/bin'
alias rbin='cdbr >/dev/null && cdpr > /dev/null && cd ../release/install/bin'
alias dtest='cdbr >/dev/null && cdpr > /dev/null && cd ../debug/install/tests'
alias rtest='cdbr >/dev/null && cdpr > /dev/null && cd ../release/install/tests'
alias ls='ls --hyperlink=auto --color=auto'
alias icat='kitty +kitten icat'
alias kit='kitty +kitten'
alias mi='pushd .;cdbr;rm -f install/bin/dsm;make install;popd'
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"
