How to set up a sample instance of a running GeoTrellis:

1) Create a virtual machine based on a Linux variant (I used a pre-built CentOS 7 VDI from osboxes.org)
2) Install Java on the VM
3) There are two parts to the demo, the backend GeoTrellis-based service (in the 'service' directory in the project) and the front end UI (in the 'website' directory in the project).
4) To build and run the back-end, run:
   'cd service'
   './sbt -sbt-version 0.13.18 "project srv" assembly'
   'cp srv/target/scala-2.10/site.jar /srv'
   'cp -r srv/data /srv'
   'sudo chown -r <user>:<group> /srv/*' => maybe?
To test with the site, run:
   'java -jar /srv/site.jar'
5) Install, setup, and configure Apache HTTPD on the guest and open up ports on the firewall
   'sudo yum install httpd' 
   'sudo systemctl enable httpd' => Configure HTTPD to start at boot
   'sudo firewall-cmd --zone=public --add-service=http --permanent' => Open ports on guest firewall
   'sudo firewall-cmd --zone=public --add-port=9090/tcp --permanent'
   'sudo firewall-cmd --reload'
6) Set port forwarding rules in VirtualBox for port 8000 on the host to port 80 on the guest and port 9090 on the host to port 9090 on the guest
7) Deploy the web-site to /var/www/html:
   'sudo cp website/* /var/www/html'
8) Setup the GeoTrellis service to run at boot:
   'sudo cp gtservice.sh /usr/bin'
   'sudo chmod +x /usr/bin/gtservice.sh'
   'sudo cp gtservice.service /etc/systemd/system'
   'sudo chmod 644 /etc/systemd/system/gtservice.service'
   'sudo systemctl enable gtservice'
9) Browse to http://127.0.0.1:8000 on the host machine, or just http://127.0.0.1 on the guest machine.

