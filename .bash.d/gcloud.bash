# Source gcloud sdk bash setup scripts
if [[ -r /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc ]]; then
  source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
fi

gcp_completion=("/usr/lib64/google-cloud-sdk/completion.bash.inc" "/usr/share/google-cloud-sdk/completion.bash.inc" "/usr/local/share/google/google-cloud-sdk/completion.bash.inc" "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc" "/snap/google-cloud-sdk/current/completion.bash.inc")

for file in ${gcp_completion[@]}; do
  [[ -r $file ]] && source $file
done
