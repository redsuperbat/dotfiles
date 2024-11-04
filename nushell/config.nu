# More config here


$env.config = {
  edit_mode: vi
}

def greet [name] {
  $"Hello, ($name)!"
}

def purge_pods [] {
    echo 'Deleting all pods which do not have status "Running"...'
    kubectl get ns -o json
     | from json
     | get items.metadata.name
     | each { |ns|
      let pods = kubectl get pods -n $ns -o json | from json | get items | where status.phase != "Running" | get metadata.name;
      let has_pods = $pods | is-not-empty;
      if $has_pods {
        kubectl -n $ns delete pod ...$pods
        $"Deleted ($pods | length) pods"
      } else {
        $"All pods is ($ns) is running"
      }
     }
}
