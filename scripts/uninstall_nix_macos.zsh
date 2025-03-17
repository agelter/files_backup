#!/bin/zsh

if [[ -f  /etc/bashrc.backup-before-nix ]] then
        sudo rm /etc/bashrc
        sudo mv /etc/bashrc.backup-before-nix /etc/bashrc
else
        print "bashrc.backup-before-nix not found"
fi

if [[ -f /etc/bash.bashrc.backup-before-nix ]] then
        sudo rm /etc/bash.bashrc
        sudo mv /etc/bash.bashrc.backup-before-nix /etc/bash.bashrc
else
        print "bash.bashrc.backup-before-nix not found"
fi

if [[ -f /etc/zshrc.backup-before-nix ]] then
        sudo rm /etc/zshrc
        sudo mv /etc/zshrc.backup-before-nix /etc/zshrc
else
        print "zshrc.backup-before-nix not found"
fi

#sudo nano /etc/synthetic.conf
sudo rm /etc/synthetic.conf

sudo vifs

sudo launchctl unload /Library/LaunchDaemons/org.nixos.nix-daemon.plist
sudo rm /Library/LaunchDaemons/org.nixos.nix-daemon.plist
sudo launchctl unload /Library/LaunchDaemons/org.nixos.activate-system.plist
sudo rm /Library/LaunchDaemons/org.nixos.activate-system.plist

sudo rm -rf /etc/nix /var/root/.nix-profile /var/root/.nix-defexpr /var/root/.nix-channels ~/.nix-profile ~/.nix-defexpr ~/.nix-channels

sudo dscl . delete /Groups/nixbld

for x in {1..32}
do
sudo dscl . delete /Users/_nixbld$x
done

sudo diskutil apfs deleteVolume /nix

echo "Please reboot for changes to take effect"

