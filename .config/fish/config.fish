set fisher_home ~/builds/fisherman
set fisher_config ~/.config/fisherman
source $fisher_home/config.fish
set -g -x fish_greeting "$fortune"

# LOCAL BIN
set PATH $PATH /home/thomas/bin
set EDITOR $EDITOR vim

. "$HOME/.config/fish/functions/aliases.fish"
. "$HOME/.config/fish/functions/function.fish"
