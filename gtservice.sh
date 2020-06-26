#!/bin/bash

DATE=`date '+%Y-%m-%d %H:%M:%S'`
echo "Starting GeotTrellis example server at ${DATE}" #| systemd-cat -p info


java -jar /srv/site.jar > ~/gt-example.log 2>&1 &
