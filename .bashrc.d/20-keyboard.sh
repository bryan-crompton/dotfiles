####################################################
#      KEYBOARD
####################################################

# allow for up arrow key searching in bash commands
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# remove antiquated ctrl+s and ctrl+q functionality
stty -ixon
bind -r "\C-s"
bind -r "\C-q"