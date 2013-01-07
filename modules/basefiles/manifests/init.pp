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
	file { "/home/jamie/bin/checkmail":
		content => template("basefiles/checkmail.erb"),
		mode => 700,
		owner => jamie,
		group => jamie,
	}

	cron { shortmail:
		command => "/home/jamie/bin/checkmail short",
		user => jamie,
		minute => "*/5",
	}

	cron { fullmail:
		command => "/home/jamie/bin/checkmail full",
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
