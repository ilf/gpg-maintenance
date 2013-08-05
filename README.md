GPG maintenance
===============

Description
-----------

GPG maintenance keeps your GnuPG OpenPGP keyring current, by constantly and silently refreshing public keys to fetch updates.

It is designed to be started automatically on boot, for example via Init Script.

Refresh Public Keys
-------------------

From Riseup Labs [OpenPGP Best Practices](https://we.riseup.net/riseuplabs+paow/openpgp-best-practices):

> Make sure you are receiving regular key updates.

> If you do not regularly refresh your public keys, you do not get timely expirations or revocations, both of which are very important to be aware of!

> If you do a simple 'gpg --refresh-keys', you disclose to anyone listening, and the keyserver operator, the whole set of keys that you are interested in refreshing.

GPG maintenance is a simple shell script taking all public keys in your keyring and refreshing them one at a time, waiting a random interval between five and 21 minutes.

TODO
----

GPG maintenance currently uses the $RANDOM variable and therefore is not POSIX compatible :(

Delete Bad Keys
---------------

GPG maintenance can also delete disabled, expired, invalid and revoked keys to trim down the keyring.

This is disabled by default, since this interferes with your reach within the web of trust.

Inspiration
-----------

There's [parcimonie](https://gaffer.ptitcanardnoir.org/intrigeri/code/parcimonie/) doing something similar. But it's Perl. And it's over 9000 Hectobytes.

Configuration
-------------

Be sure to set up your GnuPG options file "~/.gnupg/gpg.conf" to use Tor and a Keyserver supporting HKPS.

See the example gpg.conf for some proposed good practices.

License
-------

[Beerware](https://en.wikipedia.org/wiki/Beerware)
