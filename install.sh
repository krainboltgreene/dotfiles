echo "Copying zsh configurations..."
cp zsh/krainboltgreene.zsh-theme ~/.oh-my-zsh/themes/krainboltgreene.zsh-theme
cp zsh/.zshrc ~/.zshrc
if [ -z "${GPG_PASSPHRASE}" ];
then
  echo "Setting up gpg..."
  mkdir -p /tmp/gpg/
  echo $GPG_PASSPHRASE > /tmp/gpg/passphrase
  echo "$GPG_PRIVATE" > /tmp/gpg/personal.pgp
  gpg --yes --batch --passphrase-file /tmp/gpg/passphrase --import /tmp/gpg/personal.pgp
fi
echo "Setting up ssh..."
mkdir -p ~/.ssh/
cp ssh/config ~/.ssh/config
if [ -z "${GPG_PASSPHRASE}" ];
then
  gpg --yes --pinentry-mode loopback --passphrase-file /tmp/gpg/passphrase --output ~/.ssh/personal --decrypt ssh/personal.enc
  chmod 600 ~/.ssh/personal
fi
cp ssh/personal.pub ~/.ssh/personal.pub
chmod 644 ~/.ssh/personal.pub
eval `ssh-agent -s`
if [ -z "${SSH_PASSPHRASE}" ];
then
  echo "Attempting to use the given ssh password"
  echo $SSH_PASSPHRASE | SSH_ASKPASS=/bin/cat setsid -w ssh-add ~/.ssh/personal
fi
echo "Setting up git..."
cp git/.gitconfig ~/.gitconfig
cp git/.gitignore ~/.gitignore
cp npm/.npmrc ~/.npmrc
echo "Done!"
