github-list-org() {
  local org_name="$1"

  echo "Retrieving repository list for $org_name"
  gh repo list "$org_name" --limit 4000 | cut -d$'\t' -f 1 | sort > "${org_name}-repo-list"
  cat "${org_name}-repo-list"
}

github-sync-org() {
  local org_name="$1"
  local repo_name

  # shellcheck disable=SC2002
  cat "${org_name}-repo-list" | while read -r repo _; do
    repo_name=$(echo "$repo" | cut -d '/' -f 2)
    echo "Checking $repo with name $repo_name"

    if [[ -d "./$repo_name" ]]; then
      echo "Repo exists. Fetching and pulling..."
      echo

      cd "$repo_name" || exit

      git fetch

      # Handle case where local checkout is on a non-main/master branch
      # - ignore checkout errors because some repos may have zero commits,
      # so no main or master
      git checkout -q main 2>/dev/null || true
      git checkout -q master 2>/dev/null || true

      git pull

      cd ../ || exit
    else
      echo "Repo not yet cloned. Cloning into $(pwd)/${repo_name}"
      echo

      gh repo clone "$repo" "$repo_name"
    fi

    echo
  done
}
