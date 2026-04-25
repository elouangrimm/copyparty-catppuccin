import glob
import re

for file in glob.glob("catppuccin-*.css"):
    with open(file, "r") as f:
        content = f.read()
    
    # 1. Replace top comment and ACCENT_NAME/RGB
    content = re.sub(
        r"/\* Set accent by changing only this line, e\.g\. var\(MAUVE\), var\(LAVENDER\), var\(PEACH\)\. \*/\n\s*--ACCENT_NAME: var\([A-Z]+\);\n\s*--ACCENT_RGB: var\([A-Z]+-RGB\);\n\s*/\* Official Catppuccin accent options:.*?\*/",
        """/*
     * Catppuccin Theme for Copyparty
     *
     * To change the accent color, change the --ACCENT_NAME variable below.
     * Available options: var(--ROSEWATER), var(--FLAMINGO), var(--PINK), var(--MAUVE),
     * var(--RED), var(--MAROON), var(--PEACH), var(--YELLOW), var(--GREEN), var(--TEAL),
     * var(--SKY), var(--SAPPHIRE), var(--BLUE), var(--LAVENDER)
     */
    --ACCENT_NAME: var(--BLUE);""",
        content,
        flags=re.DOTALL
    )

    # 2. Remove all -RGB definitions
    content = re.sub(r"\s*--[A-Z]+-RGB:[^;]+;", "", content)

    # 3. Replace rgba for a-h-bg and btn-bg
    content = re.sub(
        r"--a-h-bg: rgba\(var\(--ctp-accent-rgb\), 0\.14\);",
        "--a-h-bg: color-mix(in srgb, var(--ctp-accent) 14%, transparent);",
        content
    )
    content = re.sub(
        r"--btn-bg: rgba\(var\(--ctp-accent-rgb\), 0\.14\);",
        "--btn-bg: color-mix(in srgb, var(--ctp-accent) 14%, transparent);",
        content
    )

    # 4. Remove --ctp-accent-rgb
    content = re.sub(r"\s*--ctp-accent-rgb:[^;]+;", "", content)

    with open(file, "w") as f:
        f.write(content)
