#!/usr/bin/env bash

set -euo pipefail

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BOLD='\033[1m'
NC='\033[0m'

RAW_BASE="https://raw.githubusercontent.com/elouangrimm/copyparty-catppuccin/main"

declare -a FLAVORS=(
    "Latte|catppuccin-latte.css|Our lightest theme harmoniously inverting the essence of Catppuccin's dark themes."
    "Frappe|catppuccin-frappe.css|A less vibrant alternative using subdued colors for a muted aesthetic."
    "Macchiato|catppuccin-macchiato.css|Medium contrast with gentle colors creating a soothing atmosphere."
    "Mocha|catppuccin-mocha.css|The Original. Our darkest variant offering a cozy feeling with color-rich accents."
)

declare -a ACCENTS=(
    "ROSEWATER"
    "FLAMINGO"
    "PINK"
    "MAUVE"
    "RED"
    "MAROON"
    "PEACH"
    "YELLOW"
    "GREEN"
    "TEAL"
    "SKY"
    "SAPPHIRE"
    "BLUE"
    "LAVENDER"
)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMP_FILES=()

cleanup() {
    local f
    for f in "${TMP_FILES[@]:-}"; do
        [[ -n "$f" && -f "$f" ]] && rm -f "$f"
    done
}
trap cleanup EXIT

line() {
    printf '%b\n' "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

info() {
    printf '%b\n' "${BLUE}i${NC} $*"
}

ok() {
    printf '%b\n' "${GREEN}✓${NC} $*"
}

warn() {
    printf '%b\n' "${YELLOW}!${NC} $*"
}

die() {
    printf '%b\n' "${RED}x${NC} $*" >&2
    exit 1
}

ask() {
    local prompt="$1"
    local __outvar="$2"
    local answer
    read -r -p "$prompt" answer
    printf -v "$__outvar" '%s' "$answer"
}

find_copyparty() {
    local locations=(
        "$HOME/copyparty"
        "$HOME/.local/share/copyparty"
        "/opt/copyparty"
        "/usr/local/copyparty"
        "/var/lib/copyparty"
    )
    local loc

    for loc in "${locations[@]}"; do
        if [[ -d "$loc" ]] && [[ -f "$loc/copyparty.py" || -f "$loc/copyparty/__init__.py" ]]; then
            printf '%s\n' "$loc"
            return 0
        fi
    done

    return 1
}

pick_flavor() {
    local choice
    local idx

    printf '\n%b\n' "${BOLD}Available flavors:${NC}"
    idx=1
    while [[ $idx -le ${#FLAVORS[@]} ]]; do
        IFS='|' read -r flavor _ desc <<<"${FLAVORS[$((idx - 1))]}"
        printf '  %d) %s - %s\n' "$idx" "$flavor" "$desc"
        idx=$((idx + 1))
    done

    ask "Choose flavor (1-${#FLAVORS[@]}): " choice
    [[ "$choice" =~ ^[0-9]+$ ]] || die "Invalid choice: $choice"
    (( choice >= 1 && choice <= ${#FLAVORS[@]} )) || die "Invalid choice: $choice"

    printf '%s\n' "${FLAVORS[$((choice - 1))]}"
}

pick_accent() {
    local choice
    local idx

    printf '\n%b\n' "${BOLD}Official accent options:${NC}"
    idx=1
    while [[ $idx -le ${#ACCENTS[@]} ]]; do
        printf '  %2d) %s\n' "$idx" "${ACCENTS[$((idx - 1))]}"
        idx=$((idx + 1))
    done

    ask "Choose accent (1-${#ACCENTS[@]}), or press Enter for default BLUE: " choice
    if [[ -z "$choice" ]]; then
        printf 'BLUE\n'
        return 0
    fi

    [[ "$choice" =~ ^[0-9]+$ ]] || die "Invalid choice: $choice"
    (( choice >= 1 && choice <= ${#ACCENTS[@]} )) || die "Invalid choice: $choice"
    printf '%s\n' "${ACCENTS[$((choice - 1))]}"
}

resolve_theme_source() {
    local theme_file="$1"
    local local_path="$SCRIPT_DIR/$theme_file"
    local tmp

    if [[ -f "$local_path" ]]; then
        printf '%s\n' "$local_path"
        return 0
    fi

    command -v curl >/dev/null 2>&1 || die "Theme file not found locally and curl is not installed."

    tmp="$(mktemp)"
    TMP_FILES+=("$tmp")
    info "Downloading $theme_file from GitHub..."
    curl -fsSL "$RAW_BASE/$theme_file" -o "$tmp" || die "Failed to download $theme_file"
    printf '%s\n' "$tmp"
}

apply_accent() {
    local css_file="$1"
    local accent="$2"

    if ! grep -q '^\s*--ACCENT_NAME:' "$css_file"; then
        die "The selected theme file does not expose --ACCENT_NAME; please update theme files first."
    fi

    sed -E -i "s|^([[:space:]]*--ACCENT_NAME:[[:space:]]*)var\([A-Z-]+\);|\1var(${accent});|" "$css_file"
}

pick_install_target() {
    local copyparty_dir="$1"
    local default_target=""
    local target

    if [[ -d "$copyparty_dir/copyparty/web" ]] && [[ -w "$copyparty_dir/copyparty/web" ]]; then
        default_target="$copyparty_dir/copyparty/web/catppuccin-copyparty.css"
        warn "Detected writable Copyparty web assets directory."
        warn "Using this avoids MIME/path issues with /customstyles.css setups."
    else
        default_target="$copyparty_dir/customstyles.css"
        warn "Could not find a writable copyparty/web directory; falling back to legacy path."
    fi

    printf '\n'
    info "Install destination file (must be reachable by Copyparty):"
    printf '  default: %s\n' "$default_target"
    ask "Path [Enter for default]: " target
    if [[ -z "$target" ]]; then
        target="$default_target"
    fi

    mkdir -p "$(dirname "$target")"
    printf '%s\n' "$target"
}

print_post_install_notes() {
    local install_target="$1"
    local web_hint="/.cpr/w/catppuccin-copyparty.css"

    printf '\n'
    line
    printf '%b\n' "${BOLD}Post-install configuration${NC}"
    line

    printf '%s\n' "1) Make Copyparty load the CSS with --css-browser."
    if [[ "$install_target" == *"/copyparty/web/catppuccin-copyparty.css" ]]; then
        printf '   Suggested: --css-browser=%s\n' "$web_hint"
    else
        printf '   Use a URL path that maps to: %s\n' "$install_target"
    fi

    printf '%s\n' "2) Enable enough theme slots, then use the custom slot in browser:"
    printf '%s\n' "   --themes=11 --theme=10"
    printf '%s\n' "   and/or open your UI with ?theme=10"

    printf '%s\n' "3) If you ever see: Refused to apply style ... MIME type text/html"
    printf '%s\n' "   then your CSS URL points to a missing file (Copyparty returned HTML)."
    printf '%s\n' "   Fix the URL/path mapping and hard-refresh (Ctrl+Shift+R)."
}

main() {
    local copyparty_dir
    local flavor_meta
    local flavor_name
    local theme_file
    local _desc
    local accent_name
    local source_file
    local install_target
    local backup_file

    line
    printf '%b\n' "${BOLD}Catppuccin Theme Installer for Copyparty${NC}"
    line

    if copyparty_dir="$(find_copyparty)"; then
        ok "Found Copyparty at: $copyparty_dir"
    else
        warn "Could not auto-detect Copyparty installation."
        ask "Enter Copyparty directory path: " copyparty_dir
        [[ -d "$copyparty_dir" ]] || die "Directory not found: $copyparty_dir"
    fi

    flavor_meta="$(pick_flavor)"
    IFS='|' read -r flavor_name theme_file _desc <<<"$flavor_meta"

    accent_name="$(pick_accent)"
    source_file="$(resolve_theme_source "$theme_file")"
    install_target="$(pick_install_target "$copyparty_dir")"

    if [[ -f "$install_target" ]]; then
        backup_file="${install_target}.backup.$(date +%s)"
        cp -f "$install_target" "$backup_file"
        warn "Backed up existing file to: $backup_file"
    fi

    cp -f "$source_file" "$install_target"
    apply_accent "$install_target" "$accent_name"

    ok "Installed flavor: $flavor_name"
    ok "Selected accent: $accent_name"
    ok "Theme file path: $install_target"

    print_post_install_notes "$install_target"

    printf '\n'
    ok "Installation complete."
}

main "$@"
