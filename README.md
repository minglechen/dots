# yazi setup
- Install packages and flavors: `ya pkg add`
- Currently installed (`ya pkg list`):
```
Plugins:
	Deepak22903/kdeconnect-send (06674d1)
	Lil-Dank/lazygit (e73fd74)
Flavors:
	yazi-rs/flavors:catppuccin-mocha (36c49ac)
```
# Use stow
In the git repo top directory, do:
`stow --dotfiles -t $HOME home`
add `--adopt` if `~/.config` has new plain config files and we would like to replace with symlink to git repo.
