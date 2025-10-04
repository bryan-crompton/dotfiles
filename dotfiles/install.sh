#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# --- config ---------------------------------------------------------------
# Things you want to install: [source_in_repo]=[target_in_home]
declare -A DOTS=(
  [".bashrc"]=".bashrc"
  [".bashrc.d"]=".bashrc.d"
  [".tmux.conf"]=".tmux.conf"
)

# --- flags ----------------------------------------------------------------
DRY_RUN=false
VERBOSE=true
for arg in "$@"; do
  case "$arg" in
    -n|--dry-run) DRY_RUN=true ;;
    -v|--verbose) VERBOSE=true ;;
    -h|--help)
      echo "Usage: $0 [--dry-run|-n] [--verbose|-v]"
      exit 0
      ;;
    *) echo "Unknown option: $arg" >&2; exit 2 ;;
  esac
done

log() { printf '%s\n' "$*" >&2; }
vlog() { $VERBOSE && log "$*"; }

do_run() {
  if $DRY_RUN; then
    echo "DRY-RUN: $*"
  else
    eval "$@"
  fi
}

# --- paths ----------------------------------------------------------------
# Resolve repo dir even if called via symlink
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)"
REPO_ROOT="$SCRIPT_DIR"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d-%H%M%S)"

# --- helpers --------------------------------------------------------------
backup_if_exists() {
  local target="$1"
  if [ -e "$target" ] || [ -L "$target" ]; then
    do_run "mkdir -p -- '$BACKUP_DIR'"
    vlog "Backing up '$target' -> '$BACKUP_DIR/'"
    do_run "mv -- '$target' '$BACKUP_DIR/'"
  fi
}

link_path() {
  local src_rel="$1"          # e.g., .bashrc or .bashrc.d
  local src="$REPO_ROOT/$src_rel"
  local dst="$HOME/${DOTS[$src_rel]}"

  # sanity
  if [ ! -e "$src" ]; then
    log "WARN: source '$src' does not exist, skipping."
    return 0
  fi

  # If already a symlink to the correct source, skip
  if [ -L "$dst" ]; then
    local current
    current="$(readlink -f -- "$dst" || true)"
    local expect="$(readlink -f -- "$src")"
    if [ "$current" = "$expect" ]; then
      vlog "OK: '$dst' already links to '$src' – skipping."
      return 0
    fi
  fi

  # Backup any existing file/dir/symlink
  backup_if_exists "$dst"

  # Ensure parent exists
  do_run "mkdir -p -- '$(dirname -- "$dst")'"

  # Create symlink (use absolute path for resilience)
  vlog "Linking '$dst' -> '$src'"
  do_run "ln -s -- '$src' '$dst'"
}

# --- main -----------------------------------------------------------------
log "Installing dotfiles from: $REPO_ROOT"
$DRY_RUN || mkdir -p -- "$HOME/.dotfiles_backup" >/dev/null 2>&1 || true

for key in "${!DOTS[@]}"; do
  link_path "$key"
done

if $DRY_RUN; then
  log "Dry run complete. No changes made."
else
  log "Done. Backups (if any) are in: $BACKUP_DIR"
  # Optional: source new bashrc for current shell if it’s interactive
  if [[ $- == *i* ]] && [ -f "$HOME/.bashrc" ]; then
    # shellcheck disable=SC1090
    . "$HOME/.bashrc"
    vlog "Sourced ~/.bashrc"
  fi
fi
