### Manual installation
```
git clone --recurse https://git.sdf.org/michael/zsh ~/.local/share/zsh
cp ~/.local/share/zsh/zshenv ~/.zshenv
mkdir -p ~/.config
ln -s ../.local/share/zsh/zshrc ~/.config/.zshrc
```

### Installation script
```
curl -s https://git.sdf.org/michael/zsh/raw/branch/master/install.sh | bash
```

![Screenshot](https://michael.sdf.org/zsh.png)