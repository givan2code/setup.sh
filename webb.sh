#!/bin/bash
# MyAwesomeMachine
# Simple and nice script that
# help make your machine ready
# for fun

# declare variables here 
script_name=$1
script_version="0.1"
dev_path="/usr/bin/"

#download package
download() {
	
	local dname=$1
	echo -e "\033[1;33m installing $dname... \033[1;30m"
	sudo apt-get install $dname
}
# check is package already exist
check_packgn() {
	name=$1
	if [ "$name" != "" ]; then
		if [ -e "$dev_path$name" ]; then
			echo -e "\033[1;37m ($name) :: already installed"
		else
			echo -e "\033[1;32m ($name) :: not installed."
			download $name
		fi
	else
		echo -e "\033[0;31menter package name p_install() func"
	fi
}
helpful() {
	if [ -e "$HOME/mam_log.txt" ]; then
		echo "you have good setup for basic"
	else
		echo "nice to help you ^^ txh for usage"
	fi 
}
#make pre updates
pre_upgd() {
	echo -e "- begging prefixing packages..."
	sudo apt-get autoremove;
	sudo apt-get autoclean; 
	sudo apt-get upgrade; 
	sudo apt-get update
	echo -e "\033[1;32m- ready to installing..."
}
p_install() {
	check_packgn $1
}
basic_setup() {
	echo -e "\033[1;30m- running basic setup..."
	pre_upgd
	p_install ruby
	p_install git
	p_install php
	p_install vim
}
# end of dunc block
#script body
echo -e "\033[1;30m(v$script_version)\033[0;35m hello, $USER! thx for using  $script_name ..."
echo -e "\033[1;36mlets make some magic with your laptop ."
echo -e "\033[1;36mwhat type of setup do you want? \033[1;33m[basic/pro]: \033[1;36m"

read -p "   -> " setup_type;

if  [ "$setup_type" != "" ]; then
		if [ "$setup_type" == "basic" ]; then
			echo -e "\033[1;32mok, you want <basic> development setup. Cool ..."
			basic_setup
			# helpful
		elif [ "$setup_type" == "pro" ]; then
			echo -e "\033[1;32mok, you want <pro> development setup. Nice ..."
		else
			echo -e "\033[0;30m (error) \033[0;31muncorrect setup type. Close. "
			exit 1
		fi
	else
	echo -e "\033[0;30m (error) \033[0;31muncorrect setup type. Close."
	exit 1
	fi

