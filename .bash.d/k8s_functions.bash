# Additional functions for managing and working with k8s

# get and decode a single key:value pair from a secret
# usage: kps <SECRET_NAME> <KEY_NAME>
function kps() {
 echo -n "$2: " ; k get secret -o json $1 | jq -r '.data' | jq -r '."'$2'"' | base64 -D && echo
}
