echo "
##### Update package #####"
sudo apt update -y

echo "
##### Uninstall jmeter, java and apache #####"
cd ~
rm -rdf $HOME/jmeter
sudo apt remove --purge -y openjdk-11-jdk apache2
