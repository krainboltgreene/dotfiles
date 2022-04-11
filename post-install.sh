#!/bin/bash

echo "Setting up gpg..."
mkdir -p /tmp/gpg/
echo "Paste your Personal GPG (Combination) (ctrl+d twice when done)"
gpg --yes --import
echo "Setting up ssh..."
gpg --yes --output ~/.ssh/personal --decrypt ssh/personal.enc
chmod 600 ~/.ssh/personal
eval `ssh-agent -s`
echo "Attempting to use the given ssh password"
ssh-add ~/.ssh/personal
echo "Done!"
