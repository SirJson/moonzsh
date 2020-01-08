#!/bin/bash
export HAS_ALLOW_UNSAFE=y

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

function has() {
	curl -sL https://git.io/_has | bash -s $1
	return $?
}

if ! has zsh; then
	echo "Install zsh first!" && exit 1
fi

mkdir -pv "$HOME/.zsh"
[ -d "$HOME/.zsh/pure" ] || git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
cp -rv "$DIR/zfuncs" "$HOME/.zsh"
cp -rv "$DIR/aliases.zsh" "$HOME/.zsh"
cp -rv "$DIR/.zshrc" $HOME
cp -rv "$DIR/.zprofile" $HOME
cp -rv "$DIR/.zshenv" $HOME

USRSHELL=$(basename $SHELL)
if [ ! "$USRSHELL" == "zsh" ]; then
	echo "Changing your login shell to zsh..."
	chsh -s $(which zsh) $USER
fi

if ! has fnm; then
	zsh -c "export SHELL=$(which zsh) && curl -fsSL https://github.com/Schniz/fnm/raw/master/.ci/install.sh | bash"
fi

chmod +x $HOME/.zsh/zfuncs/*
echo "Install done!"
