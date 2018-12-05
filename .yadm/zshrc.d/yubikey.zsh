export GPG_TTY=$(who | grep $(id -un) | awk '{print "/dev/" $2}')
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

function yk-reset() {
	/usr/bin/env gpg --card-status 2>/dev/null |
		awk -F: '/Name of cardholder/ {print $NF}' |
		sed '/^$/d' |
		xargs -I{} git config --global user.name "{}"
	/usr/bin/env gpg --card-status 2>/dev/null |
		awk -F: '/Login data/ {gsub(" ", "", $NF);print $NF}' |
		sed '/^$/d' |
		xargs -I{} git config --global user.email "{}"
}

function yk-keys() {
	gpg --list-keys | tail -n +2 | awk '$1 ~ /pub/ {gsub(/.*\//, "", $2); print $2}'
}

function yk-ssh() {
	/usr/bin/env ssh-add -L
}

function yk-gpg() {
	yk-keys | xargs -I{} gpg --armor --export {}
}

function yk-encrypt() {
	gpg --encrypt --armor --recipient
}
