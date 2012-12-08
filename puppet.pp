import "basefiles"

package { ['msmtp', 'offlineimap', 'tmux', 'mutt', 'git', 'kvm',
	'virt-manager', 'chromium-browser', 'vim-nox', 'ctags', 'cscope',
	'maildir-utils', 'gnupg-agent', 'mosh']: }

class machine($suffix, $mailpath) {
	class { commonfiles: }
	class { mail: mailpath => $mailpath }
	file { "/home/jamie/.mutt.accounts":
		source => "puppet:///modules/basefiles/mutt-accounts-$suffix",
		owner => jamie,
	}
	file { "/home/jamie/.offlineimaprc":
		source => "puppet:///modules/basefiles/offlineimaprc-$suffix",
		owner => jamie,
	}
	file { "/home/jamie/.msmtprc":
		source => "puppet:///modules/basefiles/msmtprc-$suffix",
		owner => jamie,
		mode => 0600,
	}
	file { "/home/jamie/.tmux-default.conf":
		source => "puppet:///modules/basefiles/tmux-default-$suffix",
		owner => jamie,
	}
	file { "/home/jamie/.gitconfig":
		source => "puppet:///modules/basefiles/gitconfig-$suffix",
		owner => jamie,
	}
}

node cedar {
	class { machine:
		mailpath => 'ksplice',
		suffix => 'oracle',
	}
}

node gallagher, page, sycamore {
	class { machine:
		mailpath => 'jamieiles',
		suffix => 'jamieiles',
	}
}
