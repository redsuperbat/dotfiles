function k8s_purge_pods
    echo 'Deleting all pods which do not have status "Running"...'
    set NS $(kc get ns -o json | jq -r '.items[].metadata.name')
    for ns in $NS
        kc get pods -n $ns -o json \
            | jq -r '.items[] | select(.status.phase != "Running") | .metadata.name' \
            | xargs kubectl delete pod -n $ns
    end
    echo 'Pods deleted'
end

function k8s_temp_pod
    echo 'creating temp pod'
    set RAND (random)
    kubectl run tmp-debian-$RAND -i --tty --image debian:bullseye --restart=Never -- bash
end
