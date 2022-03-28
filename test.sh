#!/bin/bash
echo "input your username"
read $username
echo "$username" | adduser $username
#read -s pass
#echo '$pass' | sudo -S su $username