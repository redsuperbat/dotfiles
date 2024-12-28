export FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=numbers --line-range :300 {}'"
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --exclude .git'

# Opens a window and fuzzy finds for a file and then opens that file in nvim
function fzf_win
    export FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git . $HOME/Projects"
    set target_file (fzf)
    set target_dir (dirname $target_file)
    tmux new-window -c $target_dir
    tmux rename-window (basename $target_dir)
    tmux send-keys -t . "nvim $target_file" C-m
end
