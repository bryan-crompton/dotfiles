ps1_timestamp="[\[\e[36m\]\T\[\e[m\]]"
ps1_user="\[\e[34m\]\u\[\e[m\]"
ps1_hostname="\[\e[33m\]\h\[\e[m\]"
ps1_cwd="\[\e[32m\]\W\[\e[m\]\\"

export PS1="$ps1_user@$ps1_hostname:$ps1_cwd$ "
