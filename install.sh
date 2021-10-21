cp zsh/krainboltgreene.zsh-theme ~/.oh-my-zsh/themes/krainboltgreene.zsh-theme
cp zsh/.zshrc ~/.zshrc
mkdir /tmp/gpg/
echo $GPG_PASSPHRASE > /tmp/gpg/passphrase
echo $GPG_ARMOR_PAIR > /tmp/gpg/personal.armor
gpg --passphrase-file /tmp/gpg/passphrase --import /tmp/gpg/personal.armor
gpg --import-options restore --import gpg/publickeys.kbx
mkdir ~/.ssh
cp ssh/config ~/.ssh/config
gpg --yes --passphrase-file /tmp/gpg/passphrase --output ~/.ssh/personal --decrypt ssh/personal
cp ssh/personal.pub ~/.ssh/personal.pub
ssh-add -K ~/.ssh/personal
cp git/.gitconfig ~/.gitconfig
cp git/.gitignore ~/.gitignore
cp npm/.npmrc ~/.npmrc
