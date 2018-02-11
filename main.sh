#!/bin/bash

OUTPUT="$(grep "<=.*P=local" /var/log/exim_mainlog | awk '{print $6}' | sort | uniq -c | sort -nr | head -n 50)"
limit=2000
adminEmail="email@exampl.com"
susUsers="/root/autoemailsuspendcpanel/suspendedEmailUsers.txt"
exceptions="$(cat /root/autoemailsuspendcpanel/exceptionEmailUsers.txt)"

touch $exceptions

echo "Job Started at $(date -u)"

echo "
Full Output:
${OUTPUT}

Suspended Accounts:
"

while read -r line; do
	totalMail="$(echo $line | awk '{print $1;}')"
	username="$(cut -d '=' -f 2 <<< $(echo $line | awk '{print $2;}'))"
	if [ "$username" != 'root' ]; then
		if [ "$totalMail" -ge "$limit" ]; then
			if [[ $(grep $username <<< $exceptions) ]]
				then echo "${username} not suspended even tho found guilty"
			else
				echo "${username} at ${totalMail}"
				echo "Suspended ${username} at ${totalMail}" >> $susUsers
				/usr/sbin/whmapi1 suspend_outgoing_email user=${username}
			fi
		fi
	fi
done <<< "$OUTPUT"
