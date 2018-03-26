Use this riemann.config file to have changes to metric naming convention and sending collectd events to Graphite.
Make use of the below commands to achieve this :

cd /etc/riemann/examplecom/etc
sudo wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Collectd/riemann-config-files/collectd.clj
cd /etc/riemann
mv riemann.config "riemann.config_$date +"%Y/%m/%d)"
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Collectd/riemann-config-files/riemann.config