# AutoEmailSuspendcPanel

This repo is for cpanel to take actions on spam, mass emails automatically.

To use this script:

Clone this repo to /root folder
and add cron entry like:

./root/AutoEmailSuspendcPanel/main.sh | mail -s "SPAM REPORT FOR SERVER: XYZ" your@email.com


### Idea

Suppose a customer's account is compromised, most scripts will start sending thousands of emails restlessly. With this script, if this behavior is detected for account, it's restricted from sending mails.

Administrators can then take action manually.
