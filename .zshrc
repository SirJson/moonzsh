MYZDIR="$HOME/.zsh"

fpath=("$MYZDIR/zfuncs" "$MYZDIR/pure" "${fpath[@]}")

if [[ -d $MYZDIR/zfuncs ]]; then
    for func in $MYZDIR/zfuncs/*(N-.x:t); do
        unhash -f $func 2>/dev/null
        autoload -U $func
    done
fi
autoload -U promptinit; promptinit
prompt pure

## ctrl-s will no longer freeze the terminal.
stty erase "^?"

PATH="$HOME/.local/bin:$PATH"
export PATH

source "$MYZDIR/alias.zsh"

command -v pipenv &> /dev/null && eval $(pipenv --completion)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export DOTNET_CLI_TELEMETRY_OPTOUT=0
export PIPENV_VENV_IN_PROJECT=true
