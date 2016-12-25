# configs
Configuration Files For Vim, Tmux, &amp; R

##Synopsis
This purpose of this project is to provide a consistent set of configuration
files for terminal applications, such as Vim, Tmux, and R, that I can access from
multiple computers.

## Installation
### Required Software
1. Vundle is required to install the plugins in the .vimrc configuration file.
	Vundle is available on [GitHub](https://github.com/VundleVim/Vundle.vim)

2. Tmux adds a number of features to the terminal editor. To install Tmux on a Debian based system, as a super user:
	```bash
	apt-get install tmux
	```

3. Git is required for installation:
	```bash
	apt-get install git
	```

###Installation Steps
1. Clone the repository into your local home directory:
	```bash
	git clone https://github.com/jscottbranson/configs ~/configs
	```

2. Create symlinks in your home directory to each of the dot files in the ~/configs/ directory that you would like to use:
	```bash
	ln -s ~/configs/.file_name ~/.file_name
	```
	Replace *.file_name* with the name of the dot file you would like to use.

3. To view all of the prospective configuration files:
	```bash
	ls -a ~/configs/
	```

###Post Install Steps
1. Install the Vim plugins:
	```bash
	vim
	```

	```vim
	:PluginInstall
	```

##Editing Configuration Files
To edit configuration files navigate to the ~/configs directory:
```bash
cd ~/configs/
```

Then use a text editor to edit the necessary configuration files:
```bash
vim .file_name
```

##Motivation
Creating a consistent environment I can use for web design and data analysis.

##License
Anyone is free to use, modify, and distribute any of these files.

##Future Plans
At some point, I
hope to provide a script that will automatically generate symlinks to each of
the configuration files.
