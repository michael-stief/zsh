### Install [exa](https://git.sdf.org/michael/zsh/wiki/exa) and [nano](https://git.sdf.org/michael/zsh/wiki/nano)
```
mkdir -p ~/.config/{bin,grc,zsh}
git clone --recurse https://git.sdf.org/michael/zsh ~/.config/zsh
cp ~/.config/zsh/.zshenv.example ~/.zshenv
ln -s ../zsh/grc/grc{,at} ~/.config/bin
cd ~/.config/grc && ln -s ../zsh/grc/{grc.conf,colourfiles/*} .
chsh -s $(which zsh)
```
![Screenshot](https://michael.sdf.org/zsh.png)