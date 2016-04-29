# this: salt://nginx/twilio_web_orch.sls
# Associated files:
#   - salt://reactor/twilio_web_react.sls
#   - salt://nginx/twilio_web_orch.sls
#   - /etc/salt/master.d/reactor.conf

{% set bdata = salt['pillar.get']('beacon_data') %}


"react with twilio data":
  salt.state:
    - tgt: 'minion03'
    - sls: nginx.twilio_web
    - pillar:
        beacon_data: {{ bdata }}