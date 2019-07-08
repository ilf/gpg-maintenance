GPG maintenance
===============

Description
-----------

GPG maintenance keeps your GnuPG OpenPGP keyring current, by constantly and silently refreshing public keys to fetch updates.

Refresh Public Keys
-------------------

From Riseup [OpenPGP Best Practices](https://help.riseup.net/en/security/message-security/openpgp/best-practices):

> If you do not regularly refresh your public keys, you do not get timely expirations or revocations, both of which are very important to be aware of!

> You should not use `gpg --refresh-keys` or the refresh keys menu item on your email client because you disclose to anyone listening, and the keyserver operator, the whole set of keys that you are interested in refreshing.

GPG maintenance is a simple shell script taking all public keys in your keyring and refreshing them one at a time, waiting a random interval between five and 21 minutes.

Configuration
-------------

Be sure to set up your GnuPG to use Tor and a Keyserver supporting HKPS.

See [this example gpg.conf](https://github.com/ioerror/duraconf/blob/master/configs/gnupg/gpg.conf) for an implementation of the OpenPGP Best Practices with GnuPG 1.4. But really, you should be using GnuPG 2.1+ these days.

Autostart
---------

GPG maintenance is designed to be started automatically on boot, for example via Init Script.

See the example `LSBInitScript.sh` for an LSB (Linux Standards Base)-compliant Init Script, as used by Debian-based sytems. Be sure to edit the user.

TODO
----

* POSIX compatibility: `grep --after-context` and `sort --random-sort`
* evaluate [GnuPG Made Easy](https://www.gnupg.org/documentation/manuals/gpgme/) instead of GnuPG binary

Inspiration
-----------

There's [parcimonie](https://gaffer.ptitcanardnoir.org/intrigeri/code/parcimonie/) doing something similar. But it's Perl. And it's over 9000 Hectobytes.

Since three months after this project was first published, there is also [parcimonie.sh](https://github.com/EtiennePerot/parcimonie.sh), but it currently has over 50 times more SLOC than this.

License
-------

[HESSLA](http://www.hacktivismo.com/about/hessla.php), but I also [like beer](https://en.wikipedia.org/wiki/Beerware).
