SHIPCAT_MANIFEST_DIR="$HOME/Code/babylon/manifests"
export SHIPCAT_MANIFEST_DIR

PATH="$HOME/.rd/bin:$PATH"
export PATH

get-github-pat() {
  local babylon_github_pat_item_uuid="pe2djuv3evc2hfry4ubfayvmv4"

  op item get "${babylon_github_pat_item_uuid}" --fields password
}

setup-homebrew() {
  local babylon_github_pat

  babylon_github_pat="$(get-github-pat)"

  export HOMEBREW_GITHUB_API_TOKEN="${babylon_github_pat}"
}

vault-login() {
  local region_name="$1"
  local vault_name
  local vault_addr
  local babylon_github_pat

  babylon_github_pat="$(get-github-pat)"

  vault_addr="$(shipcat get vault-url --region "$region_name")"
  export VAULT_ADDR="$vault_addr"
  unset VAULT_TOKEN

  if [ -z "$1" ]; then
    vault_name=$(yq -y ".regions[].vault.folder" "${SHIPCAT_MANIFEST_DIR}/shipcat.conf"  | awk '{print $2}' | fzf +m)
  else
    vault_name="$region_name"
  fi
  # why do we need to do this?

  echo "Name: $vault_name"
  echo "Server: $vault_addr"

  vault login -method=github token="${babylon_github_pat}"
}

vault-edit() {
  local region_name="$1"
  local vault_addr
  local babylon_github_pat

  babylon_github_pat="$(get-github-pat)"

  vault_addr="$(shipcat get vault-url --region "$region_name")"

  echo "${babylon_github_pat}" | pbcopy
  open "${vault_addr}/ui/vault/secrets/secret/list/$region_name/"
}
