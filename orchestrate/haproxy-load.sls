slack_notify:
  salt.function:
    - tgt: 'hopz-master1'
    - name: cmd.run
    - arg:
      - salt-call slack.post_message channel="mh-demo" message="{{tgt}} is experiencing unusual load, Spinning Up Additional Nodes" from_name="SaltStack 2015.8" api_key=xoxp-2775848702-3347315632-6165482433-b742a0

process_kill:
  salt.function:
    - tgt: 'websvr-02'
    - name: cmd.run
    - arg:
      - killall -9 gzip
    - require:
      - salt: slack_notify
      
minion_setup:
  salt.function:
    - tgt: hopz-master1
    - name: cmd.run
    - arg:
      - salt-cloud -Pym /etc/salt/cloud.maps.d/webload.map
    - require:
      - salt: process_kill

slack_web:
  salt.function:
    - tgt: 'websvr-03'
    - name: cmd.run
    - arg:
      - salt-call slack.post_message channel="mh-demo" message="Additional Web Servers Online" from_name="SaltStack 2015.8" api_key=xoxp-2775848702-3347315632-6165482433-b742a0
    - require:
      - salt: minion_setup
      
haproxy_setup:
  salt.state:
    - tgt: 'haproxy*'
    - sls: haproxy.config
    - require:
      - salt: slack_web
      
slack_haproxy:
  salt.function:
    - tgt: 'haproxy'
    - name: cmd.run
    - arg:
      - salt-call slack.post_message channel="mh-demo" message="Load Balancer Configuration Completed" from_name="SaltStack 2015.8" api_key=xoxp-2775848702-3347315632-6165482433-b742a0
    - require:
      - salt: haproxy_setup