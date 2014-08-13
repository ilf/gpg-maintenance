#!/bin/zsh

sleep 30	# wait for tor on boot

while true
do
	for key in $(gpg --list-keys --with-colons --with-fingerprint | grep --after-context "1" "^pub" | grep "^fpr" | cut -d ":" -f "10" | sort --random-sort)
	do
		gpg --batch --no-tty --no-auto-check-trustdb --refresh-keys $key 2> /dev/null
		sleep $(( ($RANDOM % 1000) + 300))
	done
done &
