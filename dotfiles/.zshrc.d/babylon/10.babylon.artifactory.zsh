get-artifactory-user() {
  local babylon_artifactory_item_uuid="exz7qbxsgklb77bkruvr4ugtvq"

  op item get "${babylon_artifactory_item_uuid}" --fields username
}

get-artifactory-password() {
  local babylon_artifactory_item_uuid="exz7qbxsgklb77bkruvr4ugtvq"

  op item get "${babylon_artifactory_item_uuid}" --fields password
}

ARTIFACTORY_USER="$(get-artifactory-user)"
ARTIFACTORY_API_KEY="$(get-artifactory-password)"

ARTIFACTORY_PWD="${ARTIFACTORY_API_KEY}"

export ARTIFACTORY_USER
export ARTIFACTORY_API_KEY
export ARTIFACTORY_PWD
