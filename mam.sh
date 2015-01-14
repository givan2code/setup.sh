#!/bin/bash
# MyAwesomeMachine
# Simple and nice script that
# help make your machine ready
# for fun

# decare variables
script_name=$1
script_version="0.1"
dev_path="/usr/bin/"
# end of var block
# func block
# 
check_packname() {
	name=$1
	if [ "$name" != "" ]; then
		if [ -e "$dev_path$name" ]; then
			echo "($name) :: already installed"
		else
			echo "($name) :: not installed. begging downloading"
		fi
	else
		echo -e "\033[0;31menter package name p_install() func"
	fi
}

p_install() {
	check_packname $1
}
basic_setup() {
	echo -e "\033[1;30m running basic setup...."
	p_install ruby
	p_install git
	p_install php
	p_install gg
}
# end of dunc block
#script body
echo -e "\033[1;30m(v$script_version)\033[0;35m hello, $USER! thx for using  $script_name ..."
echo -e "\033[1;36mlets make some magic with your laptop ."
echo -e "\033[1;36mwhat type of setup do you want? \033[1;33m[basic/pro]: \033[1;30m"

read -p " -> " setup_type;

if  [ "$setup_type" != "" ]; then
		if [ "$setup_type" == "basic" ]; then
			echo -e "\033[1;32mok, you want BASIC development setup. Cool ..."
			basic_setup
		elif [ "$setup_type" == "pro" ]; then
			echo -e "\033[1;32mok, you want PRO development setup. Nice ..."
		else
			echo -e "\033[0;30m (error) \033[0;31muncorrect setup type. Close. "
			exit 1
		fi
	else
	echo -e "\033[0;30m (error) \033[0;31muncorrect setup type. Close."
	exit 1
fi

# end of script

exit 0


