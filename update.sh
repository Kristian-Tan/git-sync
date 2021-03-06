#! /bin/bash

OPTIND=1 # Reset in case getopts has been used previously in the shell.

# boilerplate
set -o errexit # exit when any command return non-zero exit code
set -o nounset # exit when using undeclared variables
exit_on_error() {
    if test $# -eq 1; then
        echo ">>> $1"
    fi
    exit 1
}

install_directory_target=""

if test $# -eq 0; then
    install_directory_target="/bin"
else
    install_directory_target="$1"
fi

install_directory_target=`readlink -f "$install_directory_target"`

echo ">>> uninstalling from $install_directory_target"

rm "$install_directory_target/git-sync.sh" || exit_on_error "cannot remove git-sync.sh, is it already installed?"
rm "$install_directory_target/git-sync" || exit_on_error "cannot remove git-sync, is it already installed?"

echo ">>> reinstalling to $install_directory_target"

cp "git-sync.sh" "$install_directory_target/git-sync.sh" || exit_on_error "cannot copy git-sync.sh, is it already installed?"
ln "$install_directory_target/git-sync.sh" "$install_directory_target/git-sync" || exit_on_error "cannot copy git-sync, is it already installed?"

chmod u+x,g+x,o+x "$install_directory_target/git-sync.sh"
chmod u+x,g+x,o+x "$install_directory_target/git-sync"

