minion_setup:
  salt.function:
    - tgt: 'hopz-master2'
    - name: cmd.run
    - arg:
      - salt-cloud -dym /etc/salt/cloud.maps.d/aws-docker-with-haproxy.map
slack_minions:
  salt.function:
    - tgt: 'hopz-master2'
    - name: cmd.run
    - arg:
      - salt-call slack.post_message channel="mh-demo" message="Cloud Minion Teardown Completed" from_name="SaltStack Enterprise 4.0" api_key=xoxp-xxxxxxxxxx
    - require:
      - salt: minion_setup
