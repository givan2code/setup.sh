#!/bin/bash
# MyAwesomeMachine
# Simple and nice script that
# help make your machine ready
# for fun

# declare variables here 
SCRIPT_NAME=$1
SCRIPT_VERSION="0.1"
dev_path="/usr/bin/"

if [ -e "$(which apt-get)" ]; then
	PMAN="apt-get"
elif [ -e "$(which yum)" ]; then
	PMAN="yum"
fi

#npm package list . simply add one more you like
function npm-package-list {
	npm_install gulp
	npm_install grunt
	npm_install bower
	npm_install mocha
	npm_install testem
	npm_install sails
}

# check for npm in path
function npm_av {
	if [ -e "$dev_path$npm" ]; then
		npm-package-list
	else
		sudo $PMAN --purge remove nodejs*
		node_install
		npm-package-list
	fi
}

#download package
function download {
	local dname=$1
	echo -e "\033[1;33m installing $dname... \033[0m"
	sudo $PMAN install "$dname"
}

# check is package already exist
function check_packgn {
	name=$1
	if [ "$name" != "" ]; then
		if [ -e "$dev_path$name" ]; then
			echo -e "\033[1;37m ($name) :: already installed \033[0m"
		else
			echo -e "\033[1;32m ($name) :: not installed.\033[0m"
			download "$name"
		fi
	else
		echo -e "\033[0;31menter package name p_install() func \033[0m"
	fi
}

# fix common error
function fix_common {
	echo "Fixing grunt wathc error..."
	echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
}

#make pre updates
function pre_upgd {
	echo -e "- normalize package list..."
	sudo $PMAN autoremove;
	sudo $PMAN autoclean; 
	echo -e "\033[1;32m- ready to installing..."
}

#installing sublime-text
function sublime-install {
	local sublime="sublime-text"
	if [ -e "$dev_path$sublime" ]; then
		echo -e "\033[1;37m (sublime2) :: already installed \033[0m"
	else
		echo -e "\033[1;32m (sublime2) :: not installed. \033[0m"

		if [ "$PMAN" = "yum" ]; then
			sudo yum-config-manager --add-repo ppa:webupd8team/sublime-text-2;
		else
			sudo add-apt-repository ppa:webupd8team/sublime-text-2;
		fi
		sudo $PMAN update
		sudo $PMAN --purge remove sublime-text*
		sudo $PMAN install sublime-text
	fi
}

#installing image magick 
function im_setup {
	if [ -e "$dev_path$imp" ]; then
		echo -e "\033[1;37m (imagemagick) :: already installed \033[0m"
	else
		echo -e "\033[1;32m (imagemagick) :: not installed.\033[0m"
		sudo $PMAN install imagemagick
	fi
}

#installing npm packages
function npm_install {
	local pckgname=$1
	if [ -e "$dev_path$pckgname" ]; then
		echo -e "\033[1;37m ($pckgname) :: already installed \033[0m"
	else
		echo -e "\033[1;32m ($pckgname) :: not installed.\033[0m"
		sudo npm install -g "$pckgname"
	fi
}

# changing to zsh
function jump_to_zsh {
	case "$SHELL" in
  	*/zsh) echo "You have zsh as default" ;;
  	*)	echo -e "Changing your shell to zsh ..."
      	chsh -s "$(which zsh)"
    	;;
	esac
}

# install zsh
function zsh_use {
	case "$(which zsh)" in
		*/zsh) echo "Zsh installed"; jump_to_zsh ;;
		*)  echo "Installing zsh" 
			sudo $PMAN install zsh;
			jump_to_zsh
			echo "installing oh-my-zsh"
			if [ -e "$(which wget)" ]; then
				wget --no-check-certificate http://install.ohmyz.sh -O - | sh
			else
				curl -L http://install.ohmyz.sh | sh
			fi
			;;
	esac
}

#installing node (tested in mint 13 x64)
function node_install {
	if [ -e "/usr/bin/nodejs" ]; then
		echo -e "\033[1;37m (nodejs) :: already installed \033[0m"
	else
		echo -e "\033[1;32m (nodejs) :: not installed.\033[0m"
		if [ -e "/usr/bin/curl" ]; then
			curl -sL https://deb.nodesource.com/setup | sudo bash -
			sudo $PMAN install -y nodejs
		else
			sudo $PMAN install curl;
			curl -sL https://deb.nodesource.com/setup | sudo bash -
			sudo $PMAN install -y nodejs
		fi
	fi
}

# package install
function p_install {
	check_packgn "$1"
}


# basic setup
function basic_setup {
	local npm="npm"
	local imp="convert"

	echo -e "\033[1;30m- running basic setup..."
	pre_upgd
	# node_install
	# npm_av 
	# p_install ruby
	# p_install git
	# sublime-install	
	# im_setup
	# fix_common
	# zsh_use
}

echo -e "\033[1;30m(v$SCRIPT_VERSION)\033[0;35m hello, $USER! thx for using  $SCRIPT_NAME ..."
echo -e "\033[1;36mlets make some magic with your laptop ."
echo -e "\033[1;36mwhat do you want? \033[1;33m[setup/remove]: \033[0m"
read -p "   -> " setup_type;

case $setup_type in  
  setup|Setup|SETUP ) basic_setup ;; 
  remove|Remove|REMOVE ) echo "Removing ..." ;; 
  *) echo -e "\033[1;30m(error) \033[0;31muncorrect setup type.\033[0m" ;; 
esac
