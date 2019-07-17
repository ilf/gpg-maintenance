#!/bin/sh

#-----------------------------
# warning: only run this if you understand what it does!
#-----------------------------

# pub:r - revoked certificates
#   - other options: expired, not valid, invalid, unknown validity, undefined validity...
#   - see https://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git;a=blob_plain;f=doc/DETAILS;hb=refs/heads/master
# sig - your secret key(s)
#   - add all you have, with grep -e
#   - this is important, you probably don't want to delete signed keys
# --batch - add this only if you are *really* sure

for fingerprint in $(gpg --list-keys --with-colons | grep --after-context "1" "^pub:r" | grep "^fpr" | cut -d ":" -f "10")
do
	gpg --list-sigs --with-colons $fingerprint | grep "^sig" || gpg --delete-key $fingerprint
done
