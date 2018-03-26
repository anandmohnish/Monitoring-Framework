#!/bin/bash
cd /etc/riemann
mv riemann.config "riemann.config_backup_$(date +%F_%R)"
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Graphite-A/Riemann-config-files/riemann.config
cd examplecom/etc
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Graphite-A/Riemann-config-files/riemann.config