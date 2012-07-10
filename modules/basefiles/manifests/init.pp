define dotfile {
	file { "/home/jamie/.$name":
		source => "puppet:///modules/basefiles/$name",
		owner => jamie,
		mode => 0600,
	}
}

define dir {
	file { "/home/jamie/.$name":
		source => "puppet:///modules/basefiles/$name",
		owner => jamie,
		mode => 0644,
		ensure => directory,
		recurse => true,
	}
}

define binfile {
	file { "/home/jamie/bin/$name":
		source => "puppet:///modules/basefiles/$name",
		mode => 700,
	}
}

class mail($mailpath) {
	binfile { checkmail: }

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
	file { "/home/jamie/bin":
		mode => 755
	}
	dotfile { ['bashrc', 'inputrc', 'vimrc', 'tmux.conf', 'muttrc']: }
	binfile { ['getpass', 'addpass', 'genpass']: }
	dir { ['vim']: }
}
