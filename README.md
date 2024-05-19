# ESOChatLog2Discord
Instructions for piping ESO chat logs to a Discord channel

## Overview

This is a relatively simple process to send all of your in-game chat logs to a Discord channel using a web hook.

## Create a Webhook

Open a Discord where you have administrative privileges (or the ability to create Integrations/Webhooks). In Server Settings, Integrations, Webhooks, create a new Webhook. Name it whatever you want, and set the channel where you want chat to be posted.
Copy the Webhook URL and save it for later. The Webhook URL will look like this: "https://discord.com/api/webhooks/0123456789/abc-rando-mwhatever-code"

## Install Cygwin and relevant packages

Download the latest installer for Cygwin from https://www.cygwin.com/

The default install is to "C:\cygwin64", though I prefer installing to "C:\Users\YourUserName\cygwin64". Either will work.

The packages you need to install include: curl, grep, and bash.

## Create a Symbolic Link

Open a command prompt (cmd.exe) as Administrator by opening the start/windows menu, type CMD, then click "Run as Administrator".

Change directory to your Cygwin root directory "cd C:\Users\YourUserName\cygwin".

Type "mklink" and hit enter to see the list of options.

If you are using Windows 11 with Onedrive enabled, the command you likely want to use from the Cygwin root directory is,

"mklink /D "c:\users\YourUserName\OneDrive\Documents\Elder Scrolls Online\live\Logs" esologs"

If you don't user Onedrive, remove "\Onedrive" from the path.

## Edit the Script

Download the chat2discord.sh script and edit the line of the WEBHOOK_URL for the one you created earlier.

Each type of chat, zone, guild1 through guild5, say, yell, whisper, etc. will each have a different code number. Zone is 31 as far as I've seen to date, so the default script you can download here has grep " 31," to filter out any chat that is not code 31 (zone). If you'd like to send other types of chat to Discord, then just look at your ChatLog.log file and change 31 to whatever number is associated with the type of chat you want.

## Run the Script

From within the game, type /chatlog on the text input (chat) line. You'll see a system message letting you know that chats are now being logged to a file ChatLog.log

Open a Cygwin shell (it should be on the Windows/Start menu as "Cygwin64 Terminal"

Change directory (cd) to your Logs directory with cd "c:\users\YourUserName\OneDrive\Documents\Elder Scrolls Online\live\Logs" or using the symbolic link added earlier cd "c:\users\YourUserName\cygwin64\esologs"

Run "sh chat2discord.sh"

When your gaming session is done, hit ctrl-c to cancel the script.

Enjoy!
