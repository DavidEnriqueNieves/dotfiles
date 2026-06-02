#!/usr/bin/env bash
# shamelessly generated using ChatGPT

set -euo pipefail

FILES_TO_INSTALL=(
    ".bashrc"
    ".vimrc"
    ".tmux.conf"
    ".gitconfig"
    ".inputrc"
    ".config/nvim"
    ".config/Code"
    ".bash-preexec.sh"
    "dark_mode.sh"
    "light_mode.sh"
)

DRYRUN=0
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"

############################################
# Logging helpers                          #
############################################

log() {
    if [[ "$DRYRUN" -eq 1 ]]; then
        echo "DRYRUN: $*"
    else
        echo "$*"
    fi
}

run() {
    if [[ "$DRYRUN" -eq 1 ]]; then
        echo "DRYRUN: $*"
    else
        eval "$@"
    fi
}

############################################
# Help                                     #
############################################

usage() {
    cat <<EOF
install.sh — Dotfiles installer

USAGE:
  ./install.sh [OPTIONS]

OPTIONS:
  -n, --dryrun     Perform a dry run (print actions without executing)
  -h, --help       Show this help message and exit

DESCRIPTION:
  This script installs a selected subset of dotfiles from the repository
  into your \$HOME directory by creating symbolic links.

  - Files to install are defined in the FILES_TO_INSTALL Bash array
    inside this script.
  - Existing files at the destination are backed up with a timestamp:
        <filename>.backup.<timestamp>
  - Directories are handled recursively via symlinks.

EXAMPLES:
  ./install.sh
  ./install.sh --dryrun
EOF
}

############################################
# Argument parsing                         #
############################################

while [[ $# -gt 0 ]]; do
    case "$1" in
        -n|--dryrun)
            DRYRUN=1
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use -h for help."
            exit 1
            ;;
    esac
done

############################################
# Installer logic                          #
############################################

for file in "${FILES_TO_INSTALL[@]}"; do
    SRC="${SCRIPT_DIR}/${file}"
    DEST="${HOME}/${file}"

    if [[ ! -e "$SRC" ]]; then
        log "Skipping ${file} (source does not exist)"
        continue
    fi

    # If destination exists and is not the correct symlink, back it up
    if [[ -e "$DEST" || -L "$DEST" ]]; then
        if [[ -L "$DEST" && "$(readlink "$DEST")" == "$SRC" ]]; then
            log "Already linked: ${DEST}"
            continue
        else
            BACKUP="${DEST}.backup.${TIMESTAMP}"
            log "Backing up ${DEST} -> ${BACKUP}"
            run "mv \"$DEST\" \"$BACKUP\""
        fi
    fi

    log "Linking ${SRC} -> ${DEST}"
    run "ln -s \"$SRC\" \"$DEST\""
done

log "Installation complete."
