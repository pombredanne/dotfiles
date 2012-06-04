define dotfile {
	file { "/home/jamie/.$name":
		source => "puppet:///modules/basefiles/$name",
		owner => jamie,
		mode => 0600,
	}
}

class mail($mailpath) {
	file { "/home/jamie/bin":
		mode => 755
	}

	file { "/home/jamie/bin/checkmail":
		source => "puppet:///modules/basefiles/checkmail",
		mode => 700,
	}

	cron { shortmail:
		command => "MAILPATH=/home/jamie/Private/mail/$mailpath /home/jamie/bin/checkmail short",
		user => jamie,
		minute => "*/5",
	}

	cron { fullmail:
		command => "MAILPATH=/home/jamie/Private/mail/$mailpath /home/jamie/bin/checkmail full",
		user => jamie,
		minute => "3",
	}
}

class commonfiles {
	dotfile { ['bashrc', 'inputrc', 'vim', 'vimrc', 'tmux.conf', 'muttrc']: }
}
