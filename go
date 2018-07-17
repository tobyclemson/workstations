#!/bin/bash

set -e
set -o pipefail

INSTALL_ROOT="/usr/local"
BIN_ROOT="${INSTALL_ROOT}/bin"
BABUSHKA_ROOT="${INSTALL_ROOT}/babushka"

echo "Converging workstation..."

echo "-> Ensuring relevant parts of $INSTALL_ROOT exist, password may be required..."
echo "--> Checking $BIN_ROOT..."
if [ -d "$BIN_ROOT" ]; then
    echo "--> $BIN_ROOT exists, continuing..."
else
    echo "--> $BIN_ROOT does not exist, creating..."
    sudo mkdir "$BIN_ROOT"
    sudo chown -R "$(whoami)" "$BIN_ROOT"
fi

echo "-> Ensuring $BABUSHKA_ROOT exists, password may be required..."
if [ -d "$BABUSHKA_ROOT" ]; then
    echo "--> $BABUSHKA_ROOT exists, continuing..."
else
    echo "--> Babushka root does not exist, creating..."
    sudo mkdir "$BABUSHKA_ROOT"
    sudo chown -R "$(whoami)" "$BABUSHKA_ROOT"
fi

echo "-> Checking for babushka..."
if  hash babushka 2>/dev/null; then
    echo "--> Babushka found, continuing..."
else
    echo "--> Babushka missing, installing..."
    sh -c "`curl https://babushka.me/up`" </dev/null
fi

echo "-> Adding repository as babushka source..."
if ! babushka sources --list | grep workstations > /dev/null; then
    babushka sources --add workstations https://github.com/tobyclemson/workstations
fi

echo "-> Ensuring babushka sources are up to date..."
babushka sources --update

echo "-> Running default dep 'workstations:laptop'..."
babushka workstations:laptop

echo "-> Done."
