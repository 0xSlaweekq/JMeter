#!/bin/bash

echo "
##### Update package #####"
sudo apt update -y

echo "
##### Install java and apache #####"
sudo apt install openjdk-11-jdk apache2 -y

echo "
##### Check version java #####"
java -version

# Start and enable Apache2
echo "Starting and enabling Apache2..."
sudo systemctl start apache2
sudo systemctl enable apache2

# Download and install Apache JMeter
echo "Downloading Apache JMeter..."
cd ~
wget https://downloads.apache.org//jmeter/binaries/apache-jmeter-5.6.3.tgz

echo "
##### Extract apache-jmeter-5.6.3 to $HOME/jmeter #####"
echo "Installing Apache JMeter..."
mkdir $HOME/jmeter $HOME/jmeter/backups
tar -xvzf apache-jmeter-5.6.3.tgz -C $HOME/jmeter --strip-components=1
chmod +x $HOME/jmeter/bin/jmeter
rm -rf apache-jmeter-5.6.3.tgz

# Update PATH in .bashrc
echo "Adding JMeter to PATH..."
echo 'export PATH="$PATH:$HOME/jmeter/bin"' | tee -a ~/.bashrc
source ~/.bashrc

# Create JMeter desktop shortcut
echo "Creating JMeter desktop shortcut..."
sudo tee /usr/share/applications/jmeter.desktop > /dev/null <<EOL
[Desktop Entry]
Name=JMeter
Comment=Apache JMeter v5.6.3
GenericName=Apache JMeter v5.6.3
Exec=$HOME/jmeter/bin/jmeter %F
Icon=jmeter
Type=Application
StartupNotify=false
StartupWMClass=jmeter
Categories=Network;
Actions=new-window;
Keywords=jmeter;

[Desktop Action new-window]
Name=New Window
Name[ru]=Новое окно
Exec=$HOME/jmeter/bin/jmeter --new-window %F
Icon=jmeter
EOL

echo "JMeter installation complete.
##### To run:
- GUI: Type 'jmeter' in the terminal or search for 'JMeter' in applications.
- CLI: Use 'jmeter -n -t your_test_plan.jmx -l results.jtl' for command-line mode."
