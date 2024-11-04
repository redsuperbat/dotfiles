
# Modules
use ~/.config/nushell/k8s.nu
use ~/.config/nushell/theme.nu

# Sources
source ~/.config/nushell/aliases.nu

def watch [cmd: closure] {
  loop {
    let result = do $cmd
    clear
    print $result
    sleep 1sec
  }
}

def kill_port [port: string] {
  let pid = lsof $"-ti:($port)"
  if ($pid | is-not-empty) {
    $pid | into int | do { kill -9 $in }
  } else {
    $"No service running on port ($port)"
  }
}

def cl [] {
  clear
  tmux clear-history
}

def clw [] {
  tmux list-panes -F '#{pane_id}' | each {
    print $in
    tmux send-keys -t $in C-z cl Enter
  }
}

let color_config = theme kawanaga_dragon
$env.config = {
  edit_mode: vi
  color_config: $color_config
  show_banner: false
};

