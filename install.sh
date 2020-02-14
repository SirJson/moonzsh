#!/bin/bash
export HAS_ALLOW_UNSAFE=y

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
UNIXTIME=$(date +%s)
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
NC='\033[0m'

function has() {
	curl -sL https://git.io/_has | bash -s $1
	return $?
}

function setup_skip() {
	local src=$1
	local target=$2
	if [ -f $target ]; then
		printf "${ORANGE}$target already exists! skipping...${NC}\n"
		return 1
	fi
	printf "${GREEN}Installing $src to $target...${NC}\n"
	cp -rv $src $target
}

function setup_safe() {
	local src=$1
	local target=$2
	if [ -f $target ]; then
		printf "${ORANGE}$target already exists! Creating backup copy..${NC}\n"
		cp -rv $2 "$2.bak_$UNIXTIME"
	fi

	printf "${GREEN}Installing $src to $target...${NC}\n"
	cp -rv $src $target

}

if ! has zsh; then
	echo "Install zsh first!" && exit 1
fi

mkdir -pv "$HOME/.zsh"
[ -d "$HOME/.zsh/pure" ] || git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
[ -d "$HOME/.zsh/syntax-highlighting" ] || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh/syntax-highlighting"

setup_safe "$DIR/.zshrc" "$HOME/.zshrc"
cp -rv "$DIR/zfuncs" "$HOME/.zsh"
setup_skip "$DIR/aliases.zsh" "$HOME/.zsh/aliases.zsh"
setup_skip "$DIR/.zprofile" "$HOME/.zprofile"
setup_skip "$DIR/.zshenv" "$HOME/.zenv"


USRSHELL=$(basename $SHELL)
if [ ! "$USRSHELL" == "zsh" ]; then
	echo "Changing your login shell to zsh..."
	chsh -s $(which zsh) $USER
fi

if ! has fnm; then
	zsh -c "export SHELL=$(which zsh) && curl -fsSL https://github.com/Schniz/fnm/raw/master/.ci/install.sh | bash"
fi

chmod +x $HOME/.zsh/zfuncs/*
printf "${GREEN}Setup done!${NC}\n"
