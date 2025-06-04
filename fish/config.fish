if type -q brew
    # Homebrew specific formulae
    fish_add_path --path (brew --prefix libpq)/bin
    fish_add_path --path (brew --prefix llvm)/bin
    # Homebrew system binaries
    fish_add_path --path (brew --prefix)/sbin
end

# Local user binaries
fish_add_path --path $HOME/.local/bin

# Scripts
fish_add_path --path $HOME/Scripts

# Rust
fish_add_path --path $HOME/.cargo/bin

# Set default editor to neovim
export EDITOR="nvim"
# Set default manpage viewer to neovim
export MANPAGER="nvim +Man!"

# Kill process on port
function kill_port
    kill -9 $(lsof -ti:$argv[1])
end

# Source k8s functions
source $HOME/.config/fish/k8s.fish

# Source theme
source $HOME/.config/fish/kanagawa.fish

# Source prompt
source $HOME/.config/fish/fish_prompt.fish

# Do not print fish greeting
function fish_greeting
end

# Ctrl + y to accept and execute suggestion
bind -M insert ctrl-y accept-autosuggestion execute

# Aliases
alias kc=kubectl
alias gap="git add :/ -Ap"
alias vim=nvim
alias ls="eza -1a --group-directories-first"
alias lg=lazygit
alias htop=btm

function lsa
    eza -la --group-directories-first --icons
end

function cowsay_centered
    set term_width (tput cols)
    set output (cowsay $argv)

    set max_length 0
    for line in $output
        set line_length (string length --visible -- "$line")
        if test $line_length -gt $max_length
            set max_length $line_length
        end
    end
    set padding (math --scale=0 "($term_width - $max_length) / 2")
    for line in $output
        printf "%*s%s\n" $padding "" "$line"
    end
end

function cl
    clear
    tmux clear-history
end

# Clear all logs in all windows
function clw
    for pane in (tmux list-panes -F "#{pane_id}")
        tmux send-keys -t $pane C-z clear Enter
        tmux clear-history -t $pane
    end
end

function nvim_clear
    rm -rf ~/.local/share/nvim
    rm -rf ~/.local/state/nvim
end

# Added by `rbenv init` on Sun Mar 30 00:31:37 CET 2025
status --is-interactive; and rbenv init - --no-rehash fish | source
