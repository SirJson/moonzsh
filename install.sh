#!/bin/bash
export HAS_ALLOW_UNSAFE=y

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

function has() {
	curl -sL https://git.io/_has | bash -s $1
	return $?
}

if ! has zsh
	then echo "Install zsh first!" && exit 1
fi

mkdir -pv "$HOME/.zsh"
[ -d "$HOME/.zsh/pure" ] || git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
cp -rv "$DIR/zfuncs" "$HOME/.zsh"
chmod +x "$HOME/.zsh/zfuncs/*"
cp -rv "$DIR/.zshrc" $HOME
cp -rv "$DIR/.zprofile" $HOME
echo "Changing your login shell to zsh..."
chsh -s $(which zsh) $USER
zsh -c "export SHELL=$(which zsh) && curl -fsSL https://github.com/Schniz/fnm/raw/master/.ci/install.sh | bash"
echo "Install done!"
