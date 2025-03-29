# Homebrew programs
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="/opt/homebrew/opt/bison/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="$(brew --prefix dnsmasq)/sbin:$PATH"

# Deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Scripts
export PATH="$HOME/Scripts:$PATH"

# Go
export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Set default editor to neovim
export EDITOR="nvim"

# Kill process on port
function kill_port
    kill -9 $(lsof -ti:$argv[1])
end

# Source k8s functions
source "$HOME/.config/fish/k8s.fish"

# Source theme
source "$HOME/.config/fish/kanagawa.fish"

# Source prompt
source "$HOME/.config/fish/fish_prompt.fish"

# Aliases
alias kc=kubectl
alias gap="git add :/ -Ap"
alias vim=nvim
alias ls='eza -la --group-directories-first --icons'
alias lg=lazygit

function cl
    clear
    tmux clear-history
end

# Clear all logs in all windows
function clw
    for pane in (tmux list-panes -F '#{pane_id}')
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
