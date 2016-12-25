# configs
Configuration Files For Vim, Tmux, &amp; R

##Synopsis
This purpose of this project is to provide a consistent set of configuration
files for terminal applications, such as vim and R, that I can access from
multiple computers.

##Installation
Clone the repository into your local home directory:
>git clone https://github.com/jscottbranson/configs.git ~/configs

Create symlinks in your home directory to each of the dot files in the ~/configs/ directory that you would like to use:
>ln -s ~/configs/.file_name ~/.file_name

To view all of the prospective configuration files:
>ls -a ~/configs/

##Editing Configuration Files
To edit configuration files navigate to the ~/configs directory:
>cd ~/configs/

Then use a text editor to edit the necessary configuration files:
>vim .file_name

##Motivation
Creating a consistent environment I can use for web design and data analysis.

##License
Anyone is free to use, modify, and distribute any of these files.

##Future Plans
At some point, I
hope to provide a script that will automatically generate symlinks to each of
the configuration files.
