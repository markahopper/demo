nginx:
  pkg:
    - installed
    - version: 
    - source: salt://
  service:
    - running
    - require:
      - pkg: nginx

/usr/share/nginx/html/index.html:
  file:
    - managed
    - source: salt://nginx/index.html
    - template: jinja
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx

roles:
  grains.present:
    - value: webserver
