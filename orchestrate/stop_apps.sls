stop_webserver:
  salt.function:
    - tgt: 'roles:webserver'
    - tgt_type: grain
    - name: service.stop
    - arg:
      - nginx
slack_nginx:
  salt.function:
    - tgt: 'hopz-master1'
    - name: cmd.run
    - arg:
      - salt-call slack.post_message channel="mh-demo" message="Web Applications Stopped" from_name="SaltStack" api_key=xoxp-2775848702-3347315632-6165482433-b742a0
    - require:
      - salt: stop_webserver
stop_database:
  salt.function:
    - tgt: 'roles:database'
    - tgt_type: grain
    - name: service.stop
    - arg:
      - nginx
    - require:
      - salt: stop_webserver
slack_mysql:
  salt.function:
    - tgt: 'hopz-master1'
    - name: cmd.run
    - arg:
      - salt-call slack.post_message channel="mh-demo" message="Database Stopped" from_name="SaltStack" api_key=xoxp-2775848702-3347315632-6165482433-b742a0
    - require:
      - salt: stop_database