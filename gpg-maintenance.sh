#!/bin/zsh

while true
do

# wait for tor on boot
sleep 30

#-----------------------------
# refresh
#-----------------------------

gpg --check-trustdb 2> /dev/null

for key in $(gpg --list-keys --with-colons | grep "^pub" | cut --fields 5 --delimiter ":" | sort --random-sort)
do
	gpg --batch --no-tty --no-auto-check-trustdb --refresh-keys $key 2> /dev/null
	sleep $(( ($RANDOM % 1000) + 300))	# $RANDOM != POSIX :(
done

gpg --check-trustdb 2> /dev/null

#-----------------------------
# delete bad keys: disabled, expired, invalid, revoked
# you might want to keep old keys with local signatures
#-----------------------------

secretkeys=`gpg --list-secret-keys --with-colons | grep "^sec" | cut -f5 -d":" | tr '\n' '|' | sed 's/^/\\(/; s/$/\)/; s/|/\\|/'g`
badkeys=`gpg --list-keys --with-colons | grep "^...:\(i\|d\|r\|e\)" | grep -v "^sec" | cut -f5 -d":" | grep -e $secretkeys`

#[ $badkeys ] && gpg --delete-key --batch --yes $badkeys

#gpg --check-trustdb

done &
