# resets your yubikey back to the current key
# function yk-reset() {
# 	# remote all trusted keys, so any pointers to cards are removed
# 	gpg --with-keygrip --list-secret-keys jakdept@gmail.com 2>/dev/null |
# 		awk '$1 ~ /Keygrip/ {print $3}' |
# 		while read keygrip; do
# 			rm -f ~/.gnupg/private-keys-v1.d/${keygrip}.key
# 		done
# 	gpgconf --kill gpg-agent
# 	kill $SSH_AGENT_PID &>/dev/null
# 	export GPG_TTY="$(tty)"
# 	export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
# 	gpgconf --launch gpg-agent
# 	# test the gpg agent
# 	/usr/bin/env gpg --card-status &>/dev/null
# 	# do something with ssh to get the daemon running
# 	/usr/bin/env ssh-add -L &>/dev/null
# 	# set the user.name in git
# 	/usr/bin/env gpg --card-status |
# 		awk -F: '/Name of cardholder/ {print $NF}' |
# 		xargs echo |
# 		xargs -I{} git config --global user.name "{}"
# 	/usr/bin/env gpg --card-status |
# 		awk -F: '/Login Data/ {print $NF}' |
# 		xargs echo |
# 		xargs -I{} git config --global user.email "{}"
# 	echo UPDATESTARTUPTTY | gpg-connect-agent
# }

export GPG_TTY=$(who | grep $(id -un)|awk '{print "/dev/" $2}')
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

function yk-masterKeys() {
	gpg --list-keys|tail -n +2|awk '$1 ~ /pub/ {gsub(/.*\//, "", $2); print $2}'
}

function yk-ssh() {
	/usr/bin/env ssh-add -L | pbcopy
}

function yk-gpg() {
	yk-masterKeys|xargs -I{} gpg --armor --export {}
}

function yk-encrypt() {
	gpg --encrypt --armor --recipient
}

