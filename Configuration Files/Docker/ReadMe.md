This file contains steps to configure changes for Riemann in order for Riemann to receive metrics from host running docker.

1. Chaange graphite.clj on RiemannA host.
cd /etc/riemann/examplecom/etc
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Docker/riemann-config/graphite.clj

2. wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Docker/riemann-config/collectd.clj
3. cd /etc/riemann
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Docker/riemann-config/riemann.config
Below steps should be carried out on GraphiteA host.

cd /etc/carbon/storage-schemas.conf
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Docker/storage-schema.conf