# Exit if not an interactive shell
case $- in
    *i*) ;;
    *) return ;;
esac

source-again () {
    source ~/.bashrc;
}

# Load modular configuration
if [ -d "$HOME/.bashrc.d" ]; then
    for file in "$HOME"/.bashrc.d/*.sh; do
        [ -r "$file" ] && . "$file"
    done
fi


