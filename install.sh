echo "Copying zsh configurations..."
cp zsh/krainboltgreene.zsh-theme ~/.oh-my-zsh/themes/krainboltgreene.zsh-theme
cp zsh/.zshrc ~/.zshrc
echo "Setting up gpg..."
mkdir -p /tmp/gpg/
echo $GPG_PASSPHRASE > /tmp/gpg/passphrase
echo $GPG_ARMOR_PAIR > /tmp/gpg/personal.armor
gpg --passphrase-file /tmp/gpg/passphrase --import /tmp/gpg/personal.armor
echo "Setting up ssh..."
mkdir -p ~/.ssh/
cp ssh/config ~/.ssh/config
gpg --yes --passphrase-file /tmp/gpg/passphrase --output ~/.ssh/personal --decrypt ssh/personal.enc
chmod 600 ~/.ssh/personal
cp ssh/personal.pub ~/.ssh/personal.pub
chmod 644 ~/.ssh/personal.pub
eval `ssh-agent -s`
echo $SSH_PASSPHRASE | SSH_ASKPASS=/bin/cat setsid -w ssh-add ~/.ssh/personal
echo "Setting up git..."
cp git/.gitconfig ~/.gitconfig
cp git/.gitignore ~/.gitignore
cp npm/.npmrc ~/.npmrc
