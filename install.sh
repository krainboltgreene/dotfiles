#!/bin/bash

echo "Copying zsh configurations..."
cp zsh/krainboltgreene.zsh-theme ~/.oh-my-zsh/themes/krainboltgreene.zsh-theme
cp zsh/.zshrc ~/.zshrc
echo "Setting up ssh..."
mkdir -p ~/.ssh/
cp ssh/config ~/.ssh/config
cp ssh/personal.pub ~/.ssh/personal.pub
chmod 644 ~/.ssh/personal.pub
eval `ssh-agent -s`
echo "Setting up git..."
cp git/.gitconfig ~/.gitconfig
cp git/.gitignore ~/.gitignore
cp npm/.npmrc ~/.npmrc
echo "Done! Just need to run ./post-install.sh"
