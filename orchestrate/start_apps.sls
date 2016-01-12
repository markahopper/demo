start_webserver:
  salt.function:
    - tgt: 'roles:webserver'
    - tgt_type: grain
    - name: service.start
    - arg:
      - nginx
slack_nginx:
  salt.function:
    - tgt: 'hopz-master1'
    - name: cmd.run
    - arg:
      - salt-call slack.post_message channel="mh-demo" message="Web Applications started" from_name="SaltStack" api_key=xoxp-2775848702-3347315632-6165482433-b742a0
    - require:
      - salt: start_webserver
start_database:
  salt.function:
    - tgt: 'roles:database'
    - tgt_type: grain
    - name: service.start
    - arg:
      - mysql
    - require:
      - salt: start_webserver
slack_mysql:
  salt.function:
    - tgt: 'hopz-master1'
    - name: cmd.run
    - arg:
      - salt-call slack.post_message channel="mh-demo" message="Database started" from_name="SaltStack" api_key=xoxp-2775848702-3347315632-6165482433-b742a0
    - require:
      - salt: start_database