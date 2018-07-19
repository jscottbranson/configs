# configs
[Configs] is a directory that contains configuration files for Vim, Tmux, and R, as well as a script to automatically create symbolic links to the configuration files in the user's home directory. These configuration files are targeted toward users who want to use Vim to edit R, html, css, and Python3 files. Additional functionality for running R within a Vim session is available through [Nvim-R], which is set to be automatically installed by [Vundle].

## Synopsis
This purpose of this project is to provide a consistent set of configuration
files for terminal applications, such as Vim, Tmux, and R, that I can access from
multiple computers.

## Installation
### R install.packages()
System wide R configuration files may need to be edited so install.packages() installs to /home/username/R/libs or a similar directory in the user's home folder. On Linux systems, the system wide config is in /usr/lib64/R/etc/Renviron

### Required Software
The following steps are targeted toward Debian users. You must have super-user
privileges to install software using apt-get. Fedora/RHEL users should replace apt-get with dnf or yum.


1. Git is required for installation:

	```bash
	apt-get install git
	```

2. Vim and NeoVim are text editors that can interface with R using [Nvim-R]. NeoVim offers the ability to run an R console inside of NeoVim. By default, the install script will link NeoVim to an existing ~/.vim folder as well as the .vimrc configuration file contained in this directory:

	```bash
	apt-get install [vim] [neovim]
	```

3. R is required for statistical analyses:

	```bash
	apt-get install r-base
	```

4. Tmux adds a number of features to the terminal editor:

	```bash
	apt-get install tmux
	```

5. [Vundle] is required to install the plugins in the .vimrc configuration file.

### Installation Steps
1. Make a directory to house the configuration files:
	```bash
	mkdir ~/.configs
	```

2. Clone the repository into your local home directory:

	```bash
	git clone https://github.com/crypticrabbit/configs.git ~/.configs
	```

3. Create symlinks in your home directory to each of the dot files in the ~/configs/ directory that you would like to use:

	* To automatically create symbolic links:  
	```bash
  	bash ~/.configs/link_maker
    ```

		Note that this script will automatically overwrite any existing configuration
		files with symbolic links to the files in this repository.

	* To manually create symbolic links:

    ```bash
    ln -s ~/.configs/.file_name ~/.file_name
    ```

		Replace *.file_name* with the name of the dot file you would like to use.

		* To view all of the prospective configuration files:

	```bash
	ls -a ~/.configs/
	```

### Post Install Steps
1. Install the Vim plugins:

	Launch `vim` and run `:PluginInstall`

### Extras
R output can be color coded using the colorout package. To install colorout:
1. git clone https://github.com/jalvesaq/colorout.git
2. R CMD INSTALL colorout

## Editing Configuration Files
To edit a configuration file, navigate to the ~/configs directory:

```bash
cd ~/.configs/
```

Then use a text editor to edit the necessary configuration files:

```bash
vim .file_name
```

Change *.file_name* to the name of the configuration file you would like to
edit.

## License
Anyone is free to use, modify, and distribute any of these files.

## Future Plans
Continue to update these configuration files to maximize efficiency for data
analysis and editing HTML, CSS, Python, and other files.

[configs]:https://github.com/crypticrabbit/configs
[Vundle]:https://github.com/VundleVim/Vundle.vim
[Nvim-R]:https://github.com/jalvesaq/Nvim-R
