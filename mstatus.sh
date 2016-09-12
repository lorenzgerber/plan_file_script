#!/bin/sh

if [ $(( $# < 1 )) -eq 1 ] 
then
    echo "missing argument, login/logout/xlock/unxlock expected"
    exit 1
fi

host=`hostname`

case $1 in
    login) action="logged in on"
	   break;;
    logout) action="logged out from"
	    break;;
    xlock)  action="xlocked"
	    break;;
    unxlock) action="un-xlocked"
	     break;;
    *) echo "wrong argument: login/logout/xlock/unxlock expected"
       exit 1 ;;
esac

if [ $(( $# > 1 )) -eq 1 ] 
then
    shift
    message=$1
    if [ $(( $# >= 2)) -eq 1 ]
    then
	shift
	for argument
	do
	    message=$message" "$argument
	done
    fi

    touch .plan
    echo "`date +%y-%m-%d` `date +%H:%M:%S:` $action `hostname` with message \"$message\"" >> .plan
else
    touch .plan
    echo "`date +%y-%m-%d` `date +%H:%M:%S:` $action `hostname`" >> .plan
fi

tail -n5 .plan | tee .plan 

 
