#!/bin/bash

# Note that this is the Linux / Bash / sh version for those wanting to use Cygwin or who symlink their logs directory to a Linux file share.

## Install Cygwin and relevant packages
# Download the latest installer for Cygwin from https://www.cygwin.com/
# The default install is to "C:\cygwin64", though I prefer installing to "C:\Users\YourUserName\cygwin64". Either will work.
# The packages you need to install include: curl, grep, sh and/or bash.

## Create a Symbolic Link
# Open a command prompt (cmd.exe) as Administrator by opening the start/windows menu, type CMD, then click "Run as Administrator".
# Change directory to your Cygwin root directory "cd C:\Users\YourUserName\cygwin".
# Type "mklink" and hit enter to see the list of options.
# If you are using Windows 11 with Onedrive enabled, the command you likely want to use from the Cygwin root directory is,
# "mklink /D "c:\users\YourUserName\OneDrive\Documents\Elder Scrolls Online\live\Logs" esologs"
# If you don't user Onedrive, remove "\Onedrive" from the path.

## Edit the Script
# Download the chat2discord.sh script and edit the line of the WEBHOOK_URL for the one you created earlier.
# Each type of chat, zone, guild1 through guild5, say, yell, whisper, etc. will each have a different code number. Zone is 31 as far as I've seen to date, so the default script you can download here has grep " 31," to filter out any chat that is not code 31 (zone). If you'd like to send other types of chat to Discord, then just look at your ChatLog.log file and change 31 to whatever number is associated with the type of chat you want.

## Run the Script
# From within the game, type /chatlog on the text input (chat) line. You'll see a system message letting you know that chats are now being logged to a file ChatLog.log
# Open a Cygwin shell (it should be on the Windows/Start menu as "Cygwin64 Terminal"
# Change directory (cd) to your Logs directory with cd "c:\users\YourUserName\OneDrive\Documents\Elder Scrolls Online\live\Logs" or using the symbolic link added earlier cd "c:\users\YourUserName\cygwin64\esologs"
#  Run "sh chat2discord.sh"
#  When your gaming session is done, hit ctrl-c to cancel the script.


# Replace WEBHOOK_URL with the one you created on your Discord server
WEBHOOK_URL="PASTE YOUR WEBHOOK URL HERE REPLACING THIS TEXT"
# If running this script from the Logs directory, leave this alone. If running from elsewhere, you may need a hard path.
LOGFILE_NAME="./ChatLog.log"

# tail will read the log file and send new lines to the next command after the |
# grep will look for the pattern in quotes, and only pass matching lines to the next command after the |
# grep --line-buffered will collect a few lines at a time and output them together. Discord sometimes has issues with continuous messages, so this slows it down and batches them.
tail -f $LOGFILE_NAME | grep " 31," | grep --line-buffered -v '\[verbose\]' | while read LINE0
do
    # Send POST Request to Discord API
    curl -d "content=$LINE0" -X POST $WEBHOOK_URL
    echo $LINE0;
done
