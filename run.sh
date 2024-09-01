#!/bin/bash

# Update package list
echo "Updating package list..."
sudo pacman -Syu --noconfirm

# Install OpenSSH Server
echo "Installing OpenSSH Server..."
sudo pacman -S --noconfirm openssh

# Enable and start the SSH service
echo "Enabling and starting SSH service..."
sudo systemctl enable sshd
sudo systemctl start sshd

# Backup the existing SSH configuration file
echo "Backing up the current SSH configuration..."
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# Modify the SSH configuration to listen on port 6969
echo "Configuring SSH to listen on port 6969..."
sudo sed -i 's/#Port 22/Port 6969/' /etc/ssh/sshd_config

# Allow the new port through the firewall (using iptables as an example)
echo "Allowing port 6969 through the firewall..."
# Uncomment the following line if using iptables (adjust if using a different firewall)
sudo iptables -A INPUT -p tcp --dport 6969 -j ACCEPT

# Restart the SSH service to apply the changes
echo "Restarting SSH service..."
sudo systemctl restart sshd

# Check the SSH service status
echo "Checking SSH service status..."
sudo systemctl status sshd

echo "OpenSSH server has been configured to listen on port 6969."
