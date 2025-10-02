# ~/.bashrc.d/prompt-color.sh

# Define color palette
COLORS=(31 32 33 34 35 36 91 92 93 94 95 96)

# Get deterministic hash of hostname
HASH=$(echo -n "$HOSTNAME" | cksum | awk '{print $1}')

# Map hash to color
NUM_COLORS=${#COLORS[@]}
COLOR_INDEX=$(( HASH % NUM_COLORS ))
COLOR_CODE=${COLORS[$COLOR_INDEX]}

# ANSI escape helpers
RESET='\[\e[0m\]'
COLOR="\[\e[${COLOR_CODE}m\]"

# Set the prompt (colorized hostname)
ps1_hostname="${COLOR}\h${RESET}"



ps1_timestamp="[\[\e[36m\]\T\[\e[m\]]"
ps1_user="\[\e[34m\]\u\[\e[m\]"
#ps1_hostname="\[\e[33m\]\h\[\e[m\]"
ps1_cwd="\[\e[32m\]\W\[\e[m\]\\"

export PS1="$ps1_user@$ps1_hostname:$ps1_cwd$ "
