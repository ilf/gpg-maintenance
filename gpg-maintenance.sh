#!/bin/zsh

sleep 30	# wait for tor on boot

while true
do
	for key in $(gpg --list-keys --with-colons | grep "^pub" | cut --fields 5 --delimiter ":" | sort --random-sort)
	do
		gpg --batch --no-tty --no-auto-check-trustdb --refresh-keys $key 2> /dev/null
		sleep $(( ($RANDOM % 1000) + 300))	# $RANDOM != POSIX :(
	done

	gpg --check-trustdb 2> /dev/null
done &
