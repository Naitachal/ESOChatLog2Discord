# ESOChatLog2Discord
Instructions for piping ESO chat logs to a Discord channel with no need to install any applications or complex code.

## Overview

This is a relatively simple process to send various in-game chat logs to a Discord channel using a web hook.

These instructions are for PowerShell on Windows. If you will be running from a Linux system or Windows with Cygwin, see the shell script file with instructions.

## Create a Webhook

Open a Discord where you have administrative privileges (or the ability to create Integrations/Webhooks). In Server Settings, Integrations, Webhooks, create a new Webhook. Name it whatever you want, and set the channel where you want chat to be posted.

## Edit the Script

Copy the Webhook URL and paste it into the below code replacing the example link. The Webhook URL will look like this: "https://discord.com/api/webhooks/0123456789/abc-random-whatever-code"

When you open PowerShell, it will probably show you your user name on the command line. You can use the ```pwd``` command to show the current directory (which will likely include your username). Replace "YOURUSERNAME" in the code below with it.

```
$hookUrl = 'https://discord.com/api/webhooks/0123456789/abc-random-whatever-code'
$logFile = 'C:\Users\YOURUSERNAME\Documents\Elder Scrolls Online\live\logs\ChatLog.log'

Get-Content $logFile -Wait -Tail 1 |
Select-String ' 31,' |
Foreach { $_ -replace "-05:00 31,", " - " } |
ForEach-Object {
Start-Sleep -Seconds 1
$curContents = $_
$curPayload = $null
$curPayload = [PSCustomObject]@{
content = ($curContents.SubString(11) | Out-String)
}

Write-Host ($curPayload.content | Out-String)
Invoke-RestMethod -Uri $hookUrl -Body ($curPayload | ConvertTo-Json -Depth 4) -ContentType 'Application/Json' -Method Post
}
```

Note that each type of chat, zone, guild1 through guild5, say, yell, whisper, etc. will each have a different code number. Zone is 31 as far as I've seen to date, so the default script you can see / download here has ' 31,' to filter out any chat that is not code 31 (zone). If you'd like to send other types of chat to Discord, then just look at your ChatLog.log file and change 31 to whatever number is associated with the type of chat you want.

## Run the Script

From within the game, type ```/chatlog``` on the text input (chat) line. You'll see a system message letting you know that chats are now being logged to a file ChatLog.log

In your PowerShell window, copy paste the above code, hit enter, and you should see a copy of each line that gets sent to Discord.

When your gaming session is done, hit ctrl-c in the PowerShell window to cancel the script, and the next time you want to run it, you may be able to simply hit the up arrow key in a new PowerShell window and the script will be there already.

Enjoy!
