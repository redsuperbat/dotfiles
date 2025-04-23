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
