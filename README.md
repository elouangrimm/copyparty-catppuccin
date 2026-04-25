<h3 align="center">
<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/logos/exports/1544x1544_circle.png" width="100" alt="Logo"/><br/>
<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/misc/transparent.png" height="30" width="0px"/>
Catppuccin for <a href="https://github.com/90-proof/copyparty">copyparty</a>
<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/misc/transparent.png" height="30" width="0px"/>
</h3>

## Previews

<details>
<summary>🌻 Latte</summary>
<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/previews/latte.webp"/>
</details>

<details>
<summary>🪴 Frappé</summary>
<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/previews/frappe.webp"/>
</details>

<details>
<summary>🌺 Macchiato</summary>
<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/previews/macchiato.webp"/>
</details>

<details>
<summary>🌿 Mocha</summary>
<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/previews/mocha.webp"/>
</details>

## Usage

### Automatic Installation (Recommended)

The easiest way to install is using the provided installation script:

```bash
# Clone or download this repository
git clone https://github.com/catppuccin/copyparty.git
cd copyparty

# Run the installer
./install.sh
```

The script will:
- Auto-detect your copyparty installation
- Let you choose your preferred flavor
- Optionally customize the accent color
- Backup any existing customstyles.css

### Manual Installation

1. Download the theme file for your preferred flavor:
  - `catppuccin-latte.css` - Lightest theme
  - `catppuccin-frappe.css` - Light theme
  - `catppuccin-macchiato.css` - Dark theme
  - `catppuccin-mocha.css` - Darkest theme

3. Copy the CSS file to your copyparty directory as `customstyles.css`:
   ```bash
   cp catppuccin-macchiato.css ~/copyparty/customstyles.css
   ```

4. Refresh your copyparty browser tab to apply the theme

## Customization

### Changing Accent Colors

You can easily customize the accent color by editing your `customstyles.css`:

Find these lines and replace the hex colors:
```css
--ctp-accent: #8aadf4;        /* Primary accent color */
--ctp-accent-alt: #7dc4e4;    /* Secondary/hover accent */
--ctp-accent-hi: #91d7e3;     /* Highlighted accent */
```

**Recommended accent colors from Catppuccin palette:**
- **Blue**: `#8aadf4`, `#7dc4e4`, `#91d7e3`
- **Lavender**: `#b7bdf8`, `#89dceb`, `#b4befe`
- **Mauve**: `#c6a0f6`, `#ca9ee6`, `#cba6f7`
- **Pink**: `#f5bde6`, `#f5c2e7`, `#f5bde6`
- **Peach**: `#f5a97f`, `#fab387`, `#f5a97f`
- **Green**: `#a6da95`, `#a6e3a1`, `#94e2d5`

You can also use the interactive accent color selection in the installer:
```bash
./install.sh
# Select "yes" when asked about customizing accent color
```

## Uninstallation

To revert to the default copyparty theme:

```bash
# Remove the custom CSS file
rm ~/copyparty/customstyles.css

# Or restore from backup if you have one
cp ~/copyparty/customstyles.css.backup.* ~/copyparty/customstyles.css
```

## Features

✨ **Four Beautiful Flavors** - Choose from light or dark themes
🎨 **Easy Customization** - Change accent colors in seconds
🚀 **Simple Installation** - Automated setup script included
💾 **Safe Installation** - Automatic backup of existing settings
🎯 **Complete Coverage** - All UI elements properly themed

## Configuration

The theme uses CSS custom properties (variables) for all colors, making it easy to customize. All variables are documented in the CSS files:

- `--fg`: Foreground/text color
- `--bg`: Background color
- `--ctp-accent`: Primary accent color
- `--ctp-accent-alt`: Secondary accent for hover states
- `--ctp-accent-hi`: Highlight accent color

See the CSS files for the complete list of customizable properties.

## Troubleshooting

### Theme not applying?
- Clear your browser cache (Ctrl+Shift+Delete or Cmd+Shift+Delete)
- Hard refresh the page (Ctrl+F5 or Cmd+Shift+R)
- Make sure the CSS file is in the correct location

### Wrong copyparty path detected?
- Run: `./install.sh` and manually enter your copyparty directory
- Or copy the CSS file manually to your copyparty installation

### Want to modify colors?
- Edit the `customstyles.css` file in your copyparty directory
- Update the CSS variables for your desired colors
- Refresh your browser to see changes

## 💝 Thanks to

- [copyparty](https://github.com/90-proof/copyparty) - Amazing file sharing application
- [Catppuccin](https://github.com/catppuccin) - Beautiful color palette

---

<p align="center">
<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" />
</p>

<p align="center">
Copyright &copy; 2024-present <a href="https://github.com/catppuccin" target="_blank">Catppuccin Org</a>
</p>

<p align="center">
<a href="https://github.com/catppuccin/catppuccin/blob/main/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&logoColor=d9e0ee&colorA=363a4f&colorB=b7bdf8"/></a>
</p>
