#!/bin/sh

while true
do
	for fingerprint in $(gpg --list-keys --with-colons | grep --after-context "1" "^pub" | grep "^fpr" | cut -d ":" -f "10" | sort --random-sort)
	do
		sleep $(( $(tr -cd "[:digit:]" < /dev/urandom | head -c 3) + 300 ))
		gpg --batch --no-tty --no-auto-check-trustdb --refresh-keys "$fingerprint" 2> /dev/null
	done
done &
