set fisher_home ~/builds/fisherman
set fisher_config ~/.config/fisherman
source $fisher_home/config.fish
set -g -x fish_greeting "$fortune"

# LOCAL BIN
set PATH $PATH /home/thomas/bin
set EDITOR $EDITOR vim

. "$HOME/.config/fish/functions/aliases.fish"
. "$HOME/.config/fish/functions/function.fish"
. "$HOME/.config/fish/functions/pass.fish-completion"
. "$HOME/.config/fish/functions/pacman.fish"
. "$HOME/.config/fish/functions/yaourt.fish"
. "$HOME/.config/fish/functions/gcc.fish"
. "$HOME/.config/fish/functions/gdb.fish"
. "$HOME/.config/fish/functions/gpg.fish"
. "$HOME/.config/fish/functions/git.fish"
. "$HOME/.config/fish/functions/ls.fish"
. "$HOME/.config/fish/functions/make.fish"
. "$HOME/.config/fish/functions/man.fish"
. "$HOME/.config/fish/functions/md5sum.fish"
. "$HOME/.config/fish/functions/npm.fish"
. "$HOME/.config/fish/functions/node.fish"
. "$HOME/.config/fish/functions/ssh.fish"
. "$HOME/.config/fish/functions/vim.fish"
. "$HOME/.config/fish/functions/xsel.fish"
