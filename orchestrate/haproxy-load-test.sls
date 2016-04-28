slack_notify:
  salt.function:
    - tgt: 'hopz-master1'
    - name: cmd.run
    - arg:
      - salt-call slack.post_message channel="mh-demo" message="websrv-02 is experiencing unusual load, Spinning Up Additional Nodes" from_name="SaltStack 2015.8" api_key=xoxp-xxxxxxxxxx

process_kill:
  salt.function:
    - tgt: 'websvr-02'
    - name: cmd.run
    - arg:
      - killall -9 gzip
    - require:
      - salt: slack_notify
