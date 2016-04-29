# this: salt://nginx/twilio_web.sls
# Associated files:
#   - salt://reactor/twilio_web_react.sls
#   - salt://nginx/twilio_web_orch.sls
#   - /etc/salt/master.d/reactor.conf

# pre-seed your settings in case something happens.
{% set twilio_pic = salt['pillar.get']('nginx_background', '../img/bg1.jpg') %}
{% set title = salt['pillar.get']('nginx_title', 'Salted NGINX') %}
{% set customer = salt['pillar.get']('nginx_customer_1', 'Salty the Cube') %}
{% set customer_subtitle = salt['pillar.get']('nginx_cust1sub', 'Get Salted') %}
{% set customer_image = salt['pillar.get']('nginx_cust1img', 'img/team/1.jpg') %}

# get the payload from pillar (salt://nginx/twilio_web_orch.sls)
{% set beaconinfo = salt['pillar.get']('beacon_data') %}

{% if 'Name' in beaconinfo['data']['texts'][0]['body'] %}
    {% set cust_content = (beaconinfo['data']['texts'][0]['body']).split(', ') %}
    {% set customer = (cust_content[0]).split('. ')[1] %}
    {% set customer_subtitle = (cust_content[1]).split('. ')[1] %}
    {% if 'ptitle' in beaconinfo['data']['texts'][0]['body'] %}
        {% set title = (cust_content[2]).split('. ')[1] %}
    {% else %}
        {% set title = 'Salted NGINX' %}
    {% endif %}
    {% if beaconinfo['data']['texts'][0]['images'][0] is defined %}
        {% set customer_image = beaconinfo['data']['texts'][0]['images'][0] %}
    {% endif %}
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
  file.managed:
    - source: salt://nginx/pretty/index.html
    - template: jinja
    - defaults:
        web_title: {{ title }}
        cust_name: {{ customer }}
        cust_subtitle: {{ customer_subtitle }}
        cust_image: {{ customer_image }}
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx
{% else %}
# check to see if the message contains any images
{% if beaconinfo['data']['texts'][0]['images'][0] is defined %}
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
    - source: salt://nginx/pretty
    - template: jinja
    - include_empty: True
    - defaults:
        back_pic: {{ beaconinfo['data']['texts'][0]['images'][0] }}
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx
{% endif %}
{% endif %}

{# Example Beacon event data

salt/beacon/open-master/twilio_txt_msg/ {
    "_stamp": "2016-01-14T00:53:40.249441",
    "data": {
        "id": "open-master",
        "texts": [
            {
                "body": "it is a cat, meow.",
                "from": "+15557771212",
                "id": "MMbf8c3e44cfa712a4ccaccf9078449685",
                "images": [
                    "https://api.twilio.com/2010-04-01/Accounts/ACafc7014ebb1fb5238c1d042adfe2bb94/Messages/MMbf8c3e44cfa712a4ccaccf9078449685/Media/ME559598d81d39811926690742f602d850"
                ],
                "sent": "2016-01-14 00:53:28"
            }
        ]
    },
    "tag": "salt/beacon/open-master/twilio_txt_msg/"
}
#}
