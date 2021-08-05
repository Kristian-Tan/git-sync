# git-sync


## Background

- I want to sync my current branch (or worktree) to master, so I used 
  - ```cd /path/to/main_worktree ; git pull ; cd /path/to/branch_worktree ; git rebase master```
  - or sometimes ```cd /path/to/main_worktree ; git pull ; cd /path/to/branch_worktree ; git merge --ff-only master```
- But it gets tedious to write such long command everytime, so I made this script

## Usage

- Execute the script with `-b branch_target` option in your repository
- usage: `git-worktree-create -b branch_target [-d directory_target] [-r repository_target] [-f] [-l linked_files] [-w wait_seconds] [-v]`
- Options:
  - `-b branch_target` = name of main/master/base branch
  - `-m mode` = "worktree" or "checkout"
  - `-t method` = "rebase" or "merge"
  - `-o options` = for merge methods: "--ff-only", "--ff", "--no-ff", for rebase methods: none
- will read from command line arguments, if not found then read from environment variable
  - `GIT_SYNC_BRANCH_TARGET` (default "master"),
  - `GIT_SYNC_MODE` (default "worktree"),
  - `GIT_SYNC_METHOD` (default "rebase"),
  - `GIT_SYNC_OPTIONS` (default "")

## Installation

#### Automatic Installation

- copy paste below command into your terminal:
```bash
git clone https://github.com/Kristian-Tan/git-sync.git
cd git-sync
sudo bash install.sh
```
- or this one-line: ```git clone https://github.com/Kristian-Tan/git-sync.git ; cd git-sync ; sudo bash install.sh```
- or another one-line: ```/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Kristian-Tan/git-sync/HEAD/get)"```

#### Manual Installation

- installation for all users:
  - copy `git-sync.sh` to `/usr/bin` or `/bin` (you can also remove the extension)
  - give other user permission to execute it
  - example:
  ```bash
    cp git-sync.sh /usr/bin/git-sync
    chown root:root /usr/bin/git-sync
    chmod 0755 /usr/bin/git-sync
  ```
- installation for one user:
  - copy it to any directory that is added to your PATH variable

#### Uninstallation

- just remove copied files (or just use uninstall.sh script: ```git clone https://github.com/Kristian-Tan/git-sync.git ; sudo bash git-sync/uninstall.sh```)
- or another one-line: ```/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Kristian-Tan/git-sync/HEAD/remove)"```

#### Update

- just uninstall and then install again
- or use update.sh script: ```git clone https://github.com/Kristian-Tan/git-sync.git ; sudo bash git-sync/update.sh```
- or another one-line: ```/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Kristian-Tan/git-sync/HEAD/upgrade)"```

## Contributing

- Feel free to create issue, pull request, etc if there's anything that can be improved
