docker-fix() {
  sudo mkdir -m 775 /private/var/run/rancher-desktop-lima
}

docker-login-quay-io() {
  local babylon_quay_io_credentials_item_uuid="omzo4tukkjhxneatvjfyu2mita"
  local babylon_quay_io_username
  local babylon_quay_io_password

  babylon_quay_io_username="$(op item get "${babylon_quay_io_credentials_item_uuid}" --fields username)"
  babylon_quay_io_password="$(op item get "${babylon_quay_io_credentials_item_uuid}" --fields password)"

  echo "${babylon_quay_io_password}" | docker login quay.io \
    -u "${babylon_quay_io_username}" \
    --password-stdin
}

export PATH="$HOME/.rd/bin:$PATH"
