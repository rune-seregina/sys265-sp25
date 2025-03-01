# secure-ssh.sh
# author: rune
# creates a new ssh user using $1 parameter
# adds a public key from the local repo or curled from the remote repo
# removes roots ability to ssh in

# check if username is provided
if [ $# -eq 0 ]; then
	echo "Please provide a username."
	exit 1
fi

username=$1

# Run commands to create user and necessary directories
sudo useradd -m -s /bin/bash $username
sudo mkdir -p /home/$username/.ssh
sudo cp ~/sys265-sp25/linux/public-keys/id_rsa.pub /home/$username/.ssh/authorized_keys
sudo chmod 700 /home/$username/.ssh
sudo chmod 600 /home/$username/.ssh/authorized_keys
sudo chown -R $username:$username /home/$username/.ssh

# disable root SSH (not necessary on Ubuntu)
sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

echo "User $username has been created with SSH access"
echo " Root SSH login has been disabled"
