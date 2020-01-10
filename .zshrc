# Interactive shell config
# If you need to modify your path see .zshenv

MYZDIR="$HOME/.zsh"

fpath=("$MYZDIR/zfuncs" "$MYZDIR/pure" "${fpath[@]}")

# Load all user zfuncs
if [[ -d $MYZDIR/zfuncs ]]; then
    for func in $MYZDIR/zfuncs/*(N-.x:t); do
        unhash -f $func 2>/dev/null
        autoload -U $func
    done
fi

# Init pure
autoload -U promptinit
promptinit
prompt pure

export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

# ctrl-s will no longer freeze the terminal.
stty erase "^?"

# Aliases and other stuff
source "$MYZDIR/aliases.zsh"
installed pipenv && eval $(pipenv --completion)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fnm env --multi)"
source "$MYZDIR/syntax-highlighting/zsh-syntax-highlighting.zsh"
