#!/bin/bash
# MyAwesomeMachine
# Simple and nice script that
# help make your machine ready
# for fun

# decare variables
script_name=$0
# end of var block
# func block
basic_setup() {
	local var=$1
	echo -e "\033[1;30mRunning basic setup.... $var"
}
# end of dunc block
#script body
echo -e "\033[1;30m(v0.1)\033[0;35m Hello, $USER! Thx for using  $script_name ..."
echo -e "\033[1;36mLets make some magic with your laptop ."
echo -e "\033[1;36mWhat type of setup do you want? \033[1;33m[basic/pro]: \033[1;30m"

read -p "  -> " setup_type;

if  [ "$setup_type" != "" ]; then
		if [ "$setup_type" == "basic" ]; then
			echo -e "\033[1;32mOk, you want BASIC development setup. Cool ..."
			basic_setup
		elif [ "$setup_type" == "pro" ]; then
			echo -e "\033[1;32mOk, you want PRO development setup. Nice ..."
		else
			echo -e "\033[0;30m (error) \033[0;31mUncorrect setup type. Close. "
			exit 1
		fi
	else
	echo -e "\033[0;30m (error) \033[0;31mUncorrect setup type. Close."
	exit 1
fi

# end of script

exit 0


