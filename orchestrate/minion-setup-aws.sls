minion_setup:
  salt.function:
    - tgt: 'hopz-master2'
    - name: cmd.run
    - arg:
      - salt-cloud -Pym /etc/salt/cloud.maps.d/aws-docker-with-haproxy.map
slack_minions:
  salt.function:
    - tgt: 'hopz-master2'
    - name: cmd.run
    - arg:
      - salt-call slack.post_message channel="mh-demo" message="Cloud Minion Setup Completed" from_name="SaltStack Enterprise 4.0" api_key=xoxp-2775848702-3347315632-6165482433-b742a0
    - require:
      - salt: minion_setup
