####################################################
#      HISTORY
####################################################


## Append to the history file, don't overwrite it
shopt -s histappend
shopt -s cmdhist # Save multi-line commands as one command

## Record each line as it gets issued
PROMPT_COMMAND='history -a'

## Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=100000
HISTCONTROL="erasedups:ignoreboth"
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear:cd*"
export HISTTIMEFORMAT='%F %T '