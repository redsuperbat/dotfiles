
# Modules
use ~/.config/nushell/k8s.nu

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

$env.config = {
  edit_mode: vi
};

