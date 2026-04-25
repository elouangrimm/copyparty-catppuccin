<h3 align="center">
<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/logos/exports/1544x1544_circle.png" width="100" alt="Catppuccin logo"/>
<br/>
<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/misc/transparent.png" height="30" width="0px"/>
Catppuccin for <a href="https://github.com/9001/copyparty">Copyparty</a>
<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/misc/transparent.png" height="30" width="0px"/>
</h3>

<!--
<p align="center">
<a href="https://github.com/elouangrimm/copyparty-catppuccin/stargazers"><img src="https://img.shields.io/github/stars/elouangrimm/copyparty-catppuccin?style=for-the-badge&colorA=1e1e2e&colorB=cba6f7" alt="Stars"></a>
<a href="https://github.com/elouangrimm/copyparty-catppuccin/issues"><img src="https://img.shields.io/github/issues/elouangrimm/copyparty-catppuccin?style=for-the-badge&colorA=1e1e2e&colorB=f38ba8" alt="Issues"></a>
<a href="https://github.com/elouangrimm/copyparty-catppuccin/contributors"><img src="https://img.shields.io/github/contributors/elouangrimm/copyparty-catppuccin?style=for-the-badge&colorA=1e1e2e&colorB=a6e3a1" alt="Contributors"></a>
</p>
-->

## Previews

<details>
<summary>🌻 Latte</summary>
<br/>
<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/previews/latte.webp" alt="Latte preview"/>
</details>

<details>
<summary>🪴 Frappe</summary>
<br/>
<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/previews/frappe.webp" alt="Frappe preview"/>
</details>

<details>
<summary>🌺 Macchiato</summary>
<br/>
<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/previews/macchiato.webp" alt="Macchiato preview"/>
</details>

<details>
<summary>🌿 Mocha</summary>
<br/>
<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/previews/mocha.webp" alt="Mocha preview"/>
</details>

## Usage

### One-command install (no clone required)

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/elouangrimm/copyparty-catppuccin/main/install.sh)
```

### Local install

```bash
git clone https://github.com/elouangrimm/copyparty-catppuccin.git
cd copyparty-catppuccin
./install.sh
```

The installer:
- Lets you pick any Catppuccin flavor.
- Lets you pick any official Catppuccin accent name.
- Backs up any previous installed CSS file.
- Installs to a path Copyparty can actually serve.
- Prints exact post-install flags and URL hints.

### Copyparty configuration

To use this as a custom theme, configure Copyparty with:

```bash
--css-browser=/.cpr/w/catppuccin-copyparty.css --themes=11 --theme=10
```

Or, add it to your config, somewhere in `global`:

```conf
[global]
  # more options
  css-browser: /.cpr/w/catppuccin-copyparty.css
  themes: 11
  theme: 10
  # more options
```

Then you can select it from the UI theme picker or open Copyparty with:

```text
?theme=10
```

Notes:
- If you install to a custom file path instead, use the matching URL in `--css-browser`.
- A wrong URL causes Copyparty to return HTML instead of CSS, which triggers strict MIME errors in the browser.

## Customization

Each flavor file exposes a single top-level accent selector:

```css
--ACCENT_NAME: var(BLUE);
```

Change it to any official accent option:

```text
ROSEWATER, FLAMINGO, PINK, MAUVE, RED, MAROON, PEACH, YELLOW,
GREEN, TEAL, SKY, SAPPHIRE, BLUE, LAVENDER
```

Example:

```css
--ACCENT_NAME: var(MAUVE);
```

The installer can also set this interactively for you.

## Troubleshooting

### Theme not loading and browser says MIME type is text/html

Your `--css-browser` URL points to a file Copyparty cannot serve, so it returns an HTML page (often a directory page or 404) instead of CSS.

Fix:
1. Put the CSS file in a path Copyparty serves.
2. Ensure `--css-browser` matches that URL exactly.
3. Hard-refresh (`Ctrl+Shift+R`).

### Theme option missing in UI

Set enough theme slots:

```bash
--themes=11
```

If you use `?theme=10`, the index must exist in your configured theme count.

## 🙋 FAQ

- Q: Why install into `/.cpr/w/` by default?
- A: It avoids most path-mapping mistakes and prevents MIME issues from missing CSS URLs.

- Q: Can I keep using my own webroot path?
- A: Yes. Install the file there and set `--css-browser` to the exact URL that serves it.

## 💝 Thanks to

- [Copyparty](https://github.com/9001/copyparty)
- [Catppuccin](https://github.com/catppuccin)

<p align="center">
<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" />
</p>

<p align="center">
Copyright &copy; 2021-present <a href="https://github.com/catppuccin" target="_blank">Catppuccin Org</a>
</p>

<p align="center">
<a href="https://github.com/catppuccin/catppuccin/blob/main/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&logoColor=d9e0ee&colorA=363a4f&colorB=b7bdf8"/></a>
</p>
