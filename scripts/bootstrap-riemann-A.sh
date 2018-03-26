#Install Java
sudo apt-get -y install default-jre

#Installing Riemann
wget https://aphyr.com/riemann/riemann_0.2.11_all.deb
sudo dpkg -i riemann_0.2.11_all.deb

#Start and Stop Riemann
#sudo service riemann start
#sudo service riemann stop

#Running Interactively
#sudo riemann bin /etc/riemann/riemann.config

#Install Riemann Support Tools
sudo apt-get -y install ruby ruby-dev build-essential zlib1g-dev

#Send some event to Riemann
#riemann-health

#Placing Riemann config file
git clone https://github.com/anandmohnish/Monitoring-Framework.git
cd /etc/riemann/
sudo mv riemann.config riemann.config_orignal
#cd /tmp
#rm -fr riemann.config*
#wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Riemann-A/riemann.config
sudo cp ~/Monitoring-Framework/Configuration-Files/Riemann-A/riemann.config /etc/riemann/
sudo mkdir -p /etc/riemann/examplecom/etc
sudo cp ~/Monitoring-Framework/Configuration-Files/Riemann-A/email.clj /etc/riemann/examplecom/etc/
sudo cp ~/Monitoring-Framework/Configuration-Files/Riemann-A/graphite.clj /etc/riemann/examplecom/etc/
#wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Riemann-A/email.clj
#wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Riemann-A/graphite.clj
