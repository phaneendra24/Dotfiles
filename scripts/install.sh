#!/bin/bash
# Dotfiles install script - sets up symlinks for custom scripts

set -e

DOTFILES_DIR="$HOME/Dotfiles"
LOCAL_BIN="$HOME/.local/bin"
BASH_COMPLETION_DIR="$HOME/.local/share/bash-completion/completions"

echo "Setting up Dotfiles..."

# Create directories if they don't exist
mkdir -p "$LOCAL_BIN"
mkdir -p "$BASH_COMPLETION_DIR"

# Symlink remind script
if [ -f "$DOTFILES_DIR/bin/remind" ]; then
    ln -sf "$DOTFILES_DIR/bin/remind" "$LOCAL_BIN/remind"
    chmod +x "$LOCAL_BIN/remind"
    echo "✓ Linked remind -> ~/.local/bin/remind"
else
    echo "✗ remind script not found in $DOTFILES_DIR/bin/"
fi

# Symlink completion script
if [ -f "$DOTFILES_DIR/bin/remind-completion.bash" ]; then
    ln -sf "$DOTFILES_DIR/bin/remind-completion.bash" "$BASH_COMPLETION_DIR/remind"
    echo "✓ Linked remind completion -> ~/.local/share/bash-completion/completions/remind"
else
    echo "✗ remind-completion.bash not found"
fi

# Check if ~/.local/bin is in PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo ""
    echo "⚠️  Warning: ~/.local/bin is not in your PATH"
    echo "   Add this to your ~/.bashrc or ~/.zshrc:"
    echo '   export PATH="$HOME/.local/bin:$PATH"'
fi

echo ""
echo "Done! Reload your shell or run: source ~/.bashrc"
