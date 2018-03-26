#Change Hostname

sudo hostname riemanna
cp -p /etc/hostname /etc/hostname_orignal
>>/etc/hostname
echo "riemanna" >/etc/hostname
cp -p /etc/hosts /etc/hosts_orignal
>>/etc/hosts
echo "127.0.1.1     riemanna" >/etc/hosts

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
cd /etc/riemann/
mv riemann.config riemann.config_orignal
#cd /tmp
#rm -fr riemann.config*
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Riemann-A/riemann.config
#mv riemann.config
mkdir -p examplecom/etc
cd examplecom/etc
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Riemann-A/email.clj
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Riemann-A/graphite.clj