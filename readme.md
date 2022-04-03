### Install [exa](https://git.sdf.org/michael/zsh/wiki/exa) and [nano](https://git.sdf.org/michael/zsh/wiki/nano)
```
git clone --recurse https://git.sdf.org/michael/zsh ~/.config/zsh
cp ~/.config/zsh/.zshenv.example ~/.zshenv
mkdir -p ~/.config/grc && cd ~/.config/grc && ln -s ../zsh/grc/{grc.conf,colourfiles/*} .
chsh -s $(which zsh)
```
![Screenshot](https://michael.sdf.org/zsh.png)