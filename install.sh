#!/bin/bash

# Colors for output
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Detect copyparty installation directory
find_copyparty() {
    # Check common locations
    local locations=(
        "$HOME/copyparty"
        "/opt/copyparty"
        "/usr/local/copyparty"
        "/var/copyparty"
    )
    
    for loc in "${locations[@]}"; do
        if [ -d "$loc" ] && [ -f "$loc/copyparty.py" ]; then
            echo "$loc"
            return 0
        fi
    done
    
    # If not found, ask user
    echo ""
    echo -e "${YELLOW}Could not auto-detect Copyparty installation.${NC}"
    read -p "Enter Copyparty directory path: " custom_path
    if [ -d "$custom_path" ] && [ -f "$custom_path/copyparty.py" ]; then
        echo "$custom_path"
        return 0
    else
        echo -e "${RED}Invalid path!${NC}"
        return 1
    fi
}

# Main installation
main() {
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}Catppuccin Theme Installer for Copyparty${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    
    COPYPARTY_DIR=$(find_copyparty)
    if [ $? -ne 0 ]; then
        exit 1
    fi
    
    echo -e "${GREEN}✓ Found Copyparty at: $COPYPARTY_DIR${NC}"
    echo ""
    
    # Backup existing customstyles.css if it exists
    if [ -f "$COPYPARTY_DIR/customstyles.css" ]; then
        BACKUP_FILE="$COPYPARTY_DIR/customstyles.css.backup.$(date +%s)"
        cp "$COPYPARTY_DIR/customstyles.css" "$BACKUP_FILE"
        echo -e "${YELLOW}⚠ Backed up existing customstyles.css to: $BACKUP_FILE${NC}"
    fi
    
    echo ""
    echo -e "${BLUE}Available flavors:${NC}"
    echo "  1) ${BLUE}Macchiato${NC} (Dark - Blue accent)"
    echo "  2) ${BLUE}Latte${NC} (Light - Blue accent)"
    echo "  3) ${BLUE}Mocha${NC} (Dark - Purple accent)"
    echo "  4) ${BLUE}Frappé${NC} (Light - Lavender accent)"
    echo ""
    
    read -p "Choose flavor (1-4): " flavor_choice
    
    case $flavor_choice in
        1) THEME_FILE="catppuccin-macchiato.css" ;;
        2) THEME_FILE="catppuccin-latte.css" ;;
        3) THEME_FILE="catppuccin-mocha.css" ;;
        4) THEME_FILE="catppuccin-frappe.css" ;;
        *) echo -e "${RED}Invalid choice!${NC}"; exit 1 ;;
    esac
    
    if [ ! -f "$SCRIPT_DIR/$THEME_FILE" ]; then
        echo -e "${RED}Theme file not found: $THEME_FILE${NC}"
        exit 1
    fi
    
    # Copy theme file
    cp "$SCRIPT_DIR/$THEME_FILE" "$COPYPARTY_DIR/customstyles.css"
    echo -e "${GREEN}✓ Installed theme: $THEME_FILE${NC}"
    echo ""
    
    echo -e "${YELLOW}Note: To apply the theme, refresh your Copyparty browser tab.${NC}"
    echo ""
    
    # Ask about accent color customization
    read -p "Would you like to customize the accent color? (y/n): " customize
    if [ "$customize" = "y" ] || [ "$customize" = "Y" ]; then
        customize_accent "$COPYPARTY_DIR/customstyles.css"
    fi
    
    echo -e "${GREEN}✓ Installation complete!${NC}"
    echo ""
}

customize_accent() {
    local css_file="$1"
    
    echo ""
    echo -e "${BLUE}Available accent colors:${NC}"
    echo "  1) Blue (Sapphire)"
    echo "  2) Lavender"
    echo "  3) Mauve (Purple)"
    echo "  4) Pink"
    echo "  5) Peach"
    echo "  6) Green"
    echo ""
    
    read -p "Choose accent color (1-6): " accent_choice
    
    local primary=""
    local secondary=""
    local highlight=""
    
    case $accent_choice in
        1) primary="#7dc4e4"; secondary="#8aadf4"; highlight="#91d7e3" ;;
        2) primary="#b7bdf8"; secondary="#89dceb"; highlight="#b4befe" ;;
        3) primary="#c6a0f6"; secondary="#ca9ee6"; highlight="#cba6f7" ;;
        4) primary="#f5bde6"; secondary="#f5c2e7"; highlight="#f5bde6" ;;
        5) primary="#f5a97f"; secondary="#fab387"; highlight="#f5a97f" ;;
        6) primary="#a6da95"; secondary="#a6e3a1"; highlight="#94e2d5" ;;
        *) echo -e "${RED}Invalid choice!${NC}"; return ;;
    esac
    
    # Simplified accent color replacement
    sed -i "s/--ctp-accent: #[0-9a-f]\{6\}/--ctp-accent: $primary/g" "$css_file"
    sed -i "s/--ctp-accent-alt: #[0-9a-f]\{6\}/--ctp-accent-alt: $secondary/g" "$css_file"
    sed -i "s/--ctp-accent-hi: #[0-9a-f]\{6\}/--ctp-accent-hi: $highlight/g" "$css_file"
    
    echo -e "${GREEN}✓ Accent color updated!${NC}"
}

main
