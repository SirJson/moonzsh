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

alias_lsd() {
    alias l="lsd -1 --group-dirs first"
    alias ll="lsd --long --classify --group-dirs first --timesort --all"
    alias lt="lsd --long --classify --group-dirs first --tree --depth 3"
    alias ls="lsd"
}

alias_exa() {
    alias l="exa"
    alias ll="exa -la"
    alias lt="exa -T"
    alias ls="exa -l"
}

alias_ls() {
    alias ll='ls -lh'
    alias la='ls -A'
    alias lc='ls -CF'
    alias l='ls -lah'
}

installed "lsd" && alias_lsd || installed "exa" && alias_exa || alias_ls
installed "fd" && alias find='fd'
installed "bat" && alias cat='bat'
installed "rg" && alias grep='grep'
installed "nvim" && alias vim='nvim'
alias 'tailf'='tail -f'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export DOTNET_CLI_TELEMETRY_OPTOUT=0