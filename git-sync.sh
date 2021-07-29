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

# default argument value
branch_target="master"
mode="worktree"
method="rebase"
options=""

# MyVar="${DEPLOY_ENV:-default_value}"
branch_target="${GIT_SYNC_BRANCH_TARGET:-$branch_target}"
mode="${GIT_SYNC_MODE:-worktree}"
method="${GIT_SYNC_METHOD:-rebase}"
options="${GIT_SYNC_OPTIONS:-}"

# read arguments from getopts https://wiki.bash-hackers.org/howto/getopts_tutorial https://stackoverflow.com/a/14203146/3706717
while getopts "hb:m:t:o:" opt; do
    case "$opt" in
    h)
        cat << EOF
usage: [-b branch_target] [-m mode] [-t rebase]
  -b branch_target = name of main/master/base branch
  -m mode = "worktree" or "checkout"
  -t method = "rebase" or "merge"
  -o options = for merge methods: "--ff-only", "--ff", "--no-ff", for rebase methods: none
will read from command line arguments, if not found then read from environment variable
  GIT_SYNC_BRANCH_TARGET (default "master"),
  GIT_SYNC_MODE (default "worktree"),
  GIT_SYNC_METHOD (default "rebase"),
  GIT_SYNC_OPTIONS (default "")
EOF
#-a anchor_relative = make the created worktree linked by relative path instead of absolute one, option anchor_relative must be set to a directory name to be used in anchoring them (if not set, default absolute path worktree will be used)
        exit 0
        ;;
    b)  branch_target=$OPTARG
        ;;
    m)  mode=$OPTARG
        ;;
    t)  method=$OPTARG
        ;;
    o)  options=$OPTARG
        ;;
    esac
done

if [ "$mode" = "worktree" ]; then
    directory_current=`pwd`
    worktree_target=`git rev-parse --show-toplevel`
    if ! repository_target=$(cat "$worktree_target"/.git); then
        echo 1>&2 "Could not read $worktree_target/.git, is this a worktree?"
        exit 1
    fi
    repository_target="${repository_target/gitdir: /}"
    repository_target=`readlink -f "$repository_target"`
    worktree_link_content=$repository_target
    string_slash_dot_git_slash="/.git/"
    repository_target="${worktree_link_content%%$string_slash_dot_git_slash*}"

    cd "$repository_target"
    git pull

    cd "$directory_current"
    git $method $branch_target $options
    cd "$directory_current"

elif  [ "$mode" = "merge" ]; then

    branch_current=`git rev-parse --abbrev-ref HEAD`

    git checkout $branch_target
    git pull
    git checkout $branch_current
    git $method $branch_target $options

fi
