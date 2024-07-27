function purge_pods
    echo 'Deleting all pods which do not have status "Running"...'
    set NS $(kc get ns -o json | jq -r '.items[].metadata.name')
    for ns in $NS
        kc get pods -n $ns -o json \
            | jq -r '.items[] | select(.status.phase != "Running") | .metadata.name' \
            | xargs kubectl delete pod -n $ns
    end
    echo 'Pods deleted'
end
