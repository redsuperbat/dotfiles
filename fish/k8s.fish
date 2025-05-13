function k8s_purge_pods
    echo 'Deleting all pods which do not have status "Running"...'
    set namespaces (kc get ns -o json | jq -r '.items[].metadata.name')
    for namespace in $namespaces
        kc get pods -n $namespace -o json \
            | jq -r '.items[] | select(.status.phase != "Running") | .metadata.name' \
            | xargs kubectl delete pod -n $namespace
    end
    echo 'Pods deleted'
end

function k8s_temp_pod
    echo 'creating temp pod'
    set random_number (random)
    kubectl run tmp-debian-$random_number -i --rm --tty --image debian:bullseye --restart=Never -- bash
end
