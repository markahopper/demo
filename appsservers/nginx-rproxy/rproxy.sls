### /srv/salt/nginx/rproxy.sls ###
##################################

### Install Nginx and configure it as a reverse proxy, pulling the IPs of
### the app servers from the Salt Mine.

nginx-rproxy:
  # Install Nginx
  pkg:
    - installed
    - name: nginx    
  # Place a customized Nginx config file
  file:
    - managed
    - source: salt://nginx/files/awesome-app.conf.jin
    - name: /etc/nginx/conf.d/awesome-app.conf
    - template: jinja
    - require:
      - pkg: nginx-rproxy
  # Ensure Nginx is always running.
  # Restart Nginx if the config file changes.
  service:
    - running
    - enable: True
    - name: nginx
    - require:
      - pkg: nginx-rproxy
    - watch:
      - file: nginx-rproxy
  # Restart Nginx for the initial installation.
  cmd:
    - run
    - name: service nginx restart
    - require:
      - file: nginx-rproxy
