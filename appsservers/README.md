Demo of cloud provisioning from .map file and install application servers using grains, and mines.
- 3 ubuntu vms
  - 2 appservers
  - 1 nginx reverse proxy
  
small Node.js web application is set to run indefintely on each appserver that just reports the IP of the server it's on 
back to the nginx reverse proxy.

Once the .map file is used to provision the 3 vms, salt-run the overstate file to initiate the creation of the different
packages on the servers.

Once completed, determine the public IP of the nginx proxy, and paste that into a web browser.  Refresh the page and you'll
see the proxy bounce back and forth to the different ip addresses of the app servers

taken from https://www.digitalocean.com/community/tutorials/how-to-use-salt-cloud-map-files-to-deploy-app-servers-and-an-nginx-reverse-proxy
