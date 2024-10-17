echo "
##### Update package #####"
sudo apt update -y

echo "
##### Install java and apache #####"
sudo apt install openjdk-11-jdk apache2 -y

echo "
##### Check version java #####"
java -version

echo "
##### Start and enable apache2.service #####"
sudo systemctl start apache2
sudo systemctl enable apache2

echo "
##### Download apache-jmeter-5.6.3 #####"
cd ~
wget https://downloads.apache.org//jmeter/binaries/apache-jmeter-5.6.3.tgz

echo "
##### Extract apache-jmeter-5.6.3 to $HOME/jmeter #####"
mkdir $HOME/jmeter $HOME/jmeter/backups
tar -xvzf apache-jmeter-5.6.3.tgz -C $HOME/jmeter --strip-components=1
chmod +x $HOME/jmeter/bin/jmeter
rm -rf apache-jmeter-5.6.3.tgz

echo "
##### Export path for $HOME/jmeter/bin #####"
tee -a ~/.bashrc <<< \
'
export PATH="$PATH:$HOME/jmeter/bin"'
source ~/.bashrc

echo "
##### Create desktop application #####"
sudo tee -a /usr/share/applications/jmeter.desktop <<< \
'
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
Icon=jmeter'

echo "
##### Start UI: jmeter or alt+F2 -> JMeter in Applications
Start CLI: jmeter -n -t your_test_plan.jmx -l results.jtl"
