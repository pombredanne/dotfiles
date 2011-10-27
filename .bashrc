# .bashrc

# User specific aliases and functions

function source_if_exists() {
	if [ -f $1 ]; then
		. $1
	fi
}

export HISTSIZE=50000

# Source global definitions
source_if_exists /etc/bashrc
source_if_exists /etc/bash_completion
source_if_exists ${HOME}/bin/git-completion.bash
source_if_exists ${HOME}/bin/stgit-completion.bash

function configure_editor() {
	# Add an alias called 'gvimr' this will open the file in an existing
	# instance of gvim if it exists in a new tab. If there is no existing
	# instance of gvim it will create one.
	alias gvimr="gvim --remote-tab-silent"
	export EDITOR="vim"
}

function set_path() {
	# Add SBIN directories to the path
	export PATH=/sbin:/usr/sbin:$PATH
	# Set miscellaneous PATH
	export PATH=~/bin:$PATH
}

function configure_shell() {
	set -o vi
	
	# Force the history to be updated on a line by line basis and update
	# the history when displaying the prompt.
	shopt -s histappend
	
	# Don't match hidden files when auto-completing
	set match-hidden-files off
	
	# Allow differentiation between directories and executables when
	# autocompleting
	set visible-stats on

	# As we create new history, append it to the .bash_history file each
	# time we run a command. If we don't do this we can lose history with
	# multiple instances of bash.
	export PROMPT_COMMAND='history -a'

	# Shell prompt. Use bold, green for the username, blue for the
	# directory and include the git branch/tag if we are in a git
	# repository.
	if type __git_ps1 > /dev/null 2>&1 ; then
		PS1='[\[\e[1;32m\]\u\[\e[0m\]@\h \[\e[1;34m\]\W\[\e[0m\]\[\e[1;33m\]$(__git_ps1 "(%s)")\[\e[0m\]]\$ '
	else
		PS1='[\[\e[1;32m\]\u\[\e[0m\]@\h \[\e[1;34m\]\W\[\e[0m\]\[\e[1;33m\]\[\e[0m\]]\$ '
	fi
}

export GREP_OPTIONS='--color=auto'

export MINICOM='-c on -w -T'

function set_max_make_jobs() {
	SCALING_MULTIPLIER=2
	NUM_JOBS=$((`grep ^processor /proc/cpuinfo | wc -l` * ${SCALING_MULTIPLIER}))

	alias make="make -j${NUM_JOBS}"
}

alias ls='ls --color=auto'
alias ll='ls --color=auto -l'

# GPG keyring is stored on an encrypted USB drive that should always be
# mounted in the same location.
function configure_gpg() {
	if [ -d /media/jiprivate/.gnupg ] && \
		! pgrep -c gpg-agent >/dev/null; then
		export GNUPGHOME=/media/jiprivate/.gnupg/
		eval `gpg-agent --daemon --enable-ssh-support \
			--write-env-file "${HOME}/.gpg-agent-info"`
		export GPG_TTY=`tty`
	elif [ -f ${HOME}/.gpg-agent-info ]; then
		. "${HOME}/.gpg-agent-info"
		export GPG_AGENT_INFO
		export SSH_AUTH_SOCK
	fi
}

# For android builds, use ccache.
export USE_CCACHE=1

set_path
configure_shell
configure_editor
set_max_make_jobs
configure_gpg
