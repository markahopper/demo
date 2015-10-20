slack_notify:
  salt.function:
    - tgt: 'websvr-01'
    - name: cmd.run
    - arg:
      - salt-call slack.post_message channel="mh-demo" message="websrv-01 Failure, Spinning Up New Node" from_name="SaltStack 2015.8" api_key=xoxp-2775848702-3347315632-6165482433-b742a0

minion_setup:
  salt.function:
    - tgt: hopz-master1
    - name: cmd.run
    - arg:
      - salt-cloud -p aws_nginx_scale websvr-02
    - require:
      - salt: slack_notify

slack_web:
  salt.function:
    - tgt: 'websvr-02'
    - name: cmd.run
    - arg:
      - salt-call slack.post_message channel="mh-demo" message="Webserver Migration Completed" from_name="SaltStack 2015.8" api_key=xoxp-2775848702-3347315632-6165482433-b742a0
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