# Setup fzf
# ---------
if [[ ! "$PATH" == */home/tperale/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/tperale/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/tperale/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/tperale/.fzf/shell/key-bindings.bash"
