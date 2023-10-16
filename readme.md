### Manual installation
```
git clone --recurse https://github.com/michael-stief/zsh ~/.local/share/zsh
cp ~/.local/share/zsh/zshenv ~/.zshenv
mkdir -p ~/.config
ln -s ../.local/share/zsh/zshrc ~/.config/.zshrc
```

### Installation script
```
curl -sL https://raw.github.com/michael-stief/zsh/master/install.sh | bash
```

![Screenshot](https://michael.sdf.org/zsh.png)