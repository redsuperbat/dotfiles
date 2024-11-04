
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

$env.config = {
  edit_mode: vi
};

