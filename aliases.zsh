alias_lsd() {
    alias l="lsd -1 --group-dirs first"
    alias ll="lsd --long --classify --group-dirs first --timesort --all"
    alias lt="lsd --long --classify --group-dirs first --tree --depth 3"
    alias ls="lsd"
}

alias_exa() {
    alias l="exa -1"
    alias ll="exa -l --git -@Hh"
    alias la="exa -la --git -@Hh"
    alias lt="exa --tree"
    alias ls="exa"
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
installed "fzf-dpkg" && alias pkg="fzf=dpkg"
alias 'tailf'='tail -f'
alias reload!="source ~/.zshrc"

