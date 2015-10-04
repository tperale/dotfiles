set -g -x fish_greeting "$fortune"

# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# LOCAL BIN
set PATH $PATH /home/thomas/bin

set EDITOR $EDITOR vim


# Theme
#set fish_theme simplevi
set fish_theme bobthefish
set -g theme_display_git yes
set -g theme_display_git_untracked no
set -g theme_display_git_ahead_verbose yes
set -g theme_display_hg yes
set -g theme_display_virtualenv no
set -g theme_display_ruby no
set -g theme_display_user yes
set -g default_user thomas

# All built-in plugins can be found at ~/.oh-my-fish/plugins/
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Enable plugins by adding their name separated by a space to the line below.
set fish_plugins theme

set fish_plugins vundle

# VI MODE
set fish_plugins vi-mode
set fish_plugins autojump vi-mode
set vi_mode_default vi_mode_insert

# Path to your custom folder (default path is ~/.oh-my-fish/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish
. "$HOME/.config/fish/functions/aliases.fish"
. "$HOME/.config/fish/functions/function.fish"

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish
