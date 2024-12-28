# Homebrew programs
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="/opt/homebrew/opt/bison/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

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

# pnpm
export PNPM_HOME="/Users/maxnetterberg/Library/pnpm"

# Set default editor to neovim
export EDITOR="nvim"



# Kill process on port
function kill_port
    kill -9 $(lsof -ti:$argv[1])
end


# Prompt
function fish_prompt
    set -l last_status $status
    set -l normal (set_color normal)
    set -l status_color (set_color brgreen)
    set -l cwd_color (set_color $fish_color_cwd)
    set -l vcs_color (set_color brpurple)
    set -l prompt_status ""

    # Since we display the prompt on a new line allow the directory names to be longer.
    set -q fish_prompt_pwd_dir_length
    or set -lx fish_prompt_pwd_dir_length 0

    # Color the prompt differently when we're root
    set -l suffix '❯'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set cwd_color (set_color $fish_color_cwd_root)
        end
        set suffix '#'
    end

    # Color the prompt in red on error
    if test $last_status -ne 0
        set status_color (set_color $fish_color_error)
        set prompt_status $status_color "[" $last_status "]" $normal
    end

    echo -s (prompt_login) ' ' $cwd_color (prompt_pwd) $vcs_color (fish_vcs_prompt) $normal ' ' $prompt_status
    echo -n -s $status_color $suffix ' ' $normal
end


# Source k8s functions
source "$HOME/.config/fish/k8s.fish"

# Source theme
source "$HOME/.config/fish/kanagawa.fish"

# Source rvm
source "$HOME/.config/fish/rvm.fish"

# Load config for fzf
source "$HOME/.config/fish/fzf.fish"

# Aliases
alias kc=kubectl
alias gap="git add :/ -Ap"
alias vim=nvim
alias cl="clear && tmux clear-history"
alias ls='eza -la --group-directories-first --icons'

# Clear all logs in all windows
function clw
    for pane in (tmux list-panes -F '#{pane_id}')
        tmux send-keys -t $pane C-z cl Enter
    end
end
