### Install [exa](https://the.exa.website) and [nano](https://www.nano-editor.org)
```
git clone --recurse https://git.sdf.org/michael/zsh ~/.local/share/zsh
ln -s ../.local/share/zsh/zshrc ~/.config/.zshrc
cp ~/.local/share/zsh/zshenv ~/.zshenv
usermod --shell $(which zsh) $(whoami)
```
![Screenshot](https://michael.sdf.org/zsh.png)