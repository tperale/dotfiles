# some more ls aliases
alias ll='ls -l'
alias sl='ls --color=auto'
alias lsl='ls --color=auto'
alias la='ls -A'
alias l='ls -CF'

alias v='vim'
alias vd='vimdiff'

alias g='git'
alias ga='git add'
alias gc='git commit'
alias gclo='git clone'
alias gl='git pull'
alias gup='git pull --rebase'
alias gp='git push'
alias gpsuom='git push --set-upstream origin master'
alias gsr='git svn rebase'
alias gsd='git svn dcommit'
alias gu="git reset --soft 'HEAD^'"

alias cp='cp -i'  # Warn when overwriting
alias mv='mv -i'  # Warn when overwriting
alias rm='rm -I'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias ulbmail='mutt -F ~/.mutt/muttrc.ulb'
alias hotmail='mutt -F ~/.mutt/muttrc.hotmail'
alias openmail='mutt -F ~/.mutt/muttrc.openmail'

alias launch_tor='sudo chroot --userspec=tor:tor /opt/torchroot /usr/bin/tor'

alias mountusb='udiskie-mount -a'
alias umountusb='udiskie-umount -a'

alias cfg_fish='vim ~/.config/config.fish'
alias cfg_i3='vim ~/.i3/config'
alias cfg_dunst='vim ~/.config/dunst/dunstrc'
alias cfg_htop='vim ~/.config/htop/htoprc'
alias cfg_qbit='vim ~/.config/qBittorrent/qBittorrent.conf'
alias cfg_mpv='vim ~/.config/mpv/mpv.conf'
alias cfg_zathura='vim ~/.config/zathura/zathurarc'
alias cfg_terminator='vim ~/.config/terminator/config'
alias cfg_vim='vim ~/.vimrc'
