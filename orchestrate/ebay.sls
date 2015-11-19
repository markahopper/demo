pip_setup:
  salt.function:
    - tgt: 'vm*'
    - name: cmd.run
    - arg:
      - wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py
docker_setup:
  salt.state:
    - tgt: 'vm*'
    - sls: dock_apache.docker
    - require:
      - salt: pip_setup
slack_docker:
  salt.function:
    - tgt: 'vm*'
    - name: cmd.run
    - arg:
      - salt-call slack.post_message channel="mh-demo" message="Docker Setup Completed" from_name="SaltStack" api_key=xoxp-2775848702-3347315632-6165482433-b742a0
docker_apache:
  salt.state:
    - tgt: 'vm*'
    - sls: dock_apache.dock_apache
    - require:
      - salt: docker_setup
slack_apache:
  salt.function:
    - tgt: 'vm*'
    - name: cmd.run
    - arg:
      - salt-call slack.post_message channel="mh-demo" message="Apache Setup Completed" from_name="SaltStack" api_key=xoxp-2775848702-3347315632-6165482433-b742a0
