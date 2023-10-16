#!/bin/bash

warn()    { printf '\E[33m'; echo "$@"; printf '\E[0m'; }
error()   { printf '\E[31m'; echo "$@"; printf '\E[0m'; }
success() { printf '\E[32m'; echo "$@"; printf '\E[0m'; }
abort()   { warn "$@"; error "Installation aborted."; exit 1; }

[[ -d "$HOME/.local/share/zsh" || -e "$HOME/.config/.zshrc" || -e "$HOME/.zshenv" ]] && abort ".local/share/zsh, .config/.zshrc and/or .zshenv found in $USER's home directory. Make sure these files don't already exist."

if hash exa git nano zsh 2>/dev/null; then
  success "exa git nano and zsh already installed, skipping installation."
else
  ls /root >/dev/null 2>&1  || abort "No root privileges. Run this script as sudo or install exa git nano and zsh manually."
  hash apt-get 2>/dev/null  || abort "apt-get not found. Install exa git nano and zsh with your system's package manager."
  apt-get update >/dev/null && apt-get -y install exa git nano zsh >/dev/null || abort "apt-get installation failed. After fixing the errors run 'apt-get install exa git nano zsh' or this script again."
  success "Installation of exa git nano and zsh successfull."
fi

git clone --recurse -q https://github.com/michael-stief/zsh "$HOME/.local/share/zsh" && success "git clone successfull." || abort "Could not clone git repository."
cp "$HOME/.local/share/zsh/zshenv" "$HOME/.zshenv"
mkdir -p "$HOME/.config"
ln -fs ../.local/share/zsh/zshrc "$HOME/.config/.zshrc"
test -x /bin/zsh && chsh -s /bin/zsh && success "Zsh set as default shell." || warn "Could not set Zsh as default shell. Run chsh or edit /etc/passwd."

success "Installation complete."
