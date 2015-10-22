# FASD function for fish shell (https://github.com/clvv/fasd) {{{
function -e fish_preexec _run_fasd
  fasd --proc (fasd --sanitize "$argv") > "/dev/null" 2>&1
end

function j
    cd (fasd -d -e 'printf %s' "$argv")
end
# }}}

# FUCK (https://github.com/nvbn/thefuck) {{{
function fuck -d 'Correct your previous console command'
    set -l exit_code $status
    set -l eval_script (mktemp 2>/dev/null ; or mktemp -t 'thefuck')
    set -l fucked_up_command $history[1]
    thefuck $fucked_up_command > $eval_script
        . $eval_script
    rm $eval_script
    if test $exit_code -ne 0
        history --delete $fucked_up_command
    end
end
# }}}

# {{{
function memo
    echo "$argv" | openmail -b "thomas.perale@openmailbox.org"
end

function record
    ffmpeg -f x11grab -r 25 -s wxga -i :0.0 /tmp/$argv.mp4
end

function yt2mp3
    ytdl -c --restrict-filenames --extract-audio --audio-format mp3 -o "%(title)s.%(ext)s" $argv;
end
# }}}
