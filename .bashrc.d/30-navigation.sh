####################################################
#      NAVIGATION
####################################################

# stack based cd-ing
function cd {
    if (("$#" > 0)); then
        if [ "$1" == "-" ]; then
            popd > /dev/null
        else
            pushd "$@" > /dev/null
        fi
    else
        cd $HOME
    fi
}
alias cd-="cd -"

## relative directory naviation
alias ..="cd .."
alias up="cd .."

open () {
    if [ -z "$1" ]; then val='.'; else val=$1; fi;
    xdg-open $val;
}

# quickly open up a project in vs-code
# vs-code saves the workspace for a given folder that is open
# if multiple options come up, you can pick a number in the find list
# gocode () {
#     # requires fd: sudo apt install fdclone
#     proj=~/tidy/projects
#     if [ -z "$1" ]; then echo "must specify path"; return; fi;
#     if [ -z "$2" ]; then val=1; else val=$2; fi;
#     location=$(fd -t d -g "$1" $proj | head -$val | tail -1);
#     fd -t d -g "$1" $proj | head -$val | tail -1
#     code $location; # should be launched in background somehow
# }