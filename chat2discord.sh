#!/bin/bash

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
