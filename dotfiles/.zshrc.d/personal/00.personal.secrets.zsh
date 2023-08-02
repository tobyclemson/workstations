github-token () {
  local org_name="$1"
  local github_item_uuid="qz2fjat3dzdbnpurz4nmcxwbea"

  op item get "${github_item_uuid}" --fields "${org_name}"
}

export-github-token () {
  local org_name="$1"
  local token
  token="$(github-token "${org_name}")"

  export GITHUB_TOKEN="${token}"
}