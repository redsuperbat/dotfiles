use std log

export def purge_pods [] {
    log info 'Deleting all pods which do not have status "Running"'
    kubectl get ns -o json
      | from json
      | get items.metadata.name
      | each  { |ns|
        let pods = kubectl get pods -n $ns -o json | from json | get items | where status.phase != "Running" | get metadata.name
        let has_pods = $pods | is-not-empty
        if $has_pods {
          kubectl -n $ns delete pod ...$pods | ignore
          $"Deleted ($pods | length) pods in namespace ($ns)"
        } else {
          $"All pods in namespace ($ns) is Running"
        }
     }
}

