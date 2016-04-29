# setup the pretty
{% set twilio_pic = salt['pillar.get']('nginx_background', '../img/bg1.jpg') %}
{% set title = salt['pillar.get']('nginx_title', 'Salted NGINX') %}
{% set customer = salt['pillar.get']('nginx_customer_1', 'Salty the Cube') %}
{% set customer_subtitle = salt['pillar.get']('nginx_cust1sub', 'Get Salted') %}
{% set customer_image = salt['pillar.get']('nginx_cust1img', 'img/team/1.jpg') %}

nginx:
  pkg:
    - installed
    - version: 
    - source: salt://
  service:
    - running
    - require:
      - pkg: nginx

/usr/share/nginx/html/:
  file.recurse:
    - source: salt://web/pretty
    - template: jinja
    - include_empty: True
    - defaults:
        back_pic: {{ twilio_pic }}
        web_title: {{ title }}
        cust_name: {{ customer }}
        cust_subtitle: {{ customer_subtitle }}
        cust_image: {{ customer_image }}
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx
