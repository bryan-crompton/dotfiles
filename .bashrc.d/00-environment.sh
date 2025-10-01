####################################################
#      VARIABLES
####################################################

pathadd() {
    local dir="$1"
    [ -z "$dir" ] && return 0
    [ -d "$dir" ] || return 0

    case ":$PATH:" in
        *":$dir:"*) ;;                          # already in PATH → do nothing
        *) PATH="${PATH:+"$PATH:"}$dir" ;;      # append if not present
    esac
}

# echo $PATH
pathadd $HOME/.local/bin
pathadd $HOME/bin
pathadd $HOME/.cargo/bin
pathadd "$HOME/.juliaup/bin"