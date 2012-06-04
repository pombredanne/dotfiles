#!/bin/bash
die() {
	echo $* >&2
	exit 1
}
type puppet 2>/dev/null >/dev/null || die "puppet not installed"
[ `id -u` == "0" ] || die "Must run as root"
puppet apply --verbose --modulepath modules puppet.pp
