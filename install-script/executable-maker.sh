#!/usr/bin/env bash
# make_scripts_executable.sh
# Makes every script file in ~/.config executable (recursively)
 
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
count=0
 
echo "Scanning: $CONFIG_DIR"
echo "---"
 
# Files with known script extensions — chmod unconditionally
while IFS= read -r -d '' file; do
    chmod +x "$file"
    echo "  [+] $file"
    count=$(( count + 1 ))
done < <(find "$CONFIG_DIR" \
    -type f \
    \( -name "*.sh" -o -name "*.bash" -o -name "*.zsh" -o -name "*.fish" \
       -o -name "*.py" -o -name "*.rb" -o -name "*.pl" -o -name "*.lua" \) \
    -print0)
 
# Extensionless files — only chmod if they have a shebang
while IFS= read -r -d '' file; do
    if head -c 4 "$file" 2>/dev/null | grep -qP '^#!'; then
        chmod +x "$file"
        echo "  [+] $file"
        count=$(( count + 1 ))
    fi
done < <(find "$CONFIG_DIR" \
    -type f \
    ! -name "*.*" \
    -print0)
 
echo "---"
echo "Done. Made $count file(s) executable."
