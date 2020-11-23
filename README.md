# m3mN

CREATOR: m3thodman, Alexander Lopez  
PURPOSE: Streamline Netcat Functions - File Transfers, Bind Shell, Reverse Bind Shell  
BENEFIT: Saves Users The Hassle of Memorizing Commands  
  
**************************************************************
  
WARNING: Requires Netcat Installation on Respective OS  
Installation Sources  
https://eternallybored.org/misc/netcat/  
https://nmap.org/ncat/  
  
Linux CENTOS/RHL  
dnf install nmap  
  
*************************************************************
  
##Functions  
SCOPE: User 1 | User 2  
  
###File Transfers  
SCENARIO 1  
User 1 sets up a listener. User 1 shares a file.  
User 2 connects to the port of User 1. User 2 receives a file.    
SCENARIO 2  
User 1 connects to the port of User 2. User 1 shares a file.  
User 2 sets up a listener. User 2 receives a file.    
SCENARIO 3   
User 2 sets up a listener. User 2 shares a file.  
User 1 connects to the port of User 2. User 1 receives a file.    
SCENARIO 4  
User 2 connects to the port of User 1. User 2 shares a file.  
User 1 sets up a listener. User 1 receives a file.    
Bind Shell  
SCENARIO  
User 1 sets up a listener to share command-line access.  
User 2 connects to the port of User 1. User 2 receives command-line access to User 1.   
Reverse Bind Shell  
SCENARIO  
User 1 sets up a listener.  
User 2 connects to the port of User 1. User 2 provides User 1 with command-line access.  
User 1 has access to the command-line of User 2.   
