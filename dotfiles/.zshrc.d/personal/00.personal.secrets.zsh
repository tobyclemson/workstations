github-token () {
  local github_item_uuid="qz2fjat3dzdbnpurz4nmcxwbea"

  op item get "${github_item_uuid}" --fields token
}

export-github-token () {
  local token
  token="$(github-token)"

  export GITHUB_TOKEN="$token"
}