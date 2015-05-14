pip_setup:
  salt.function:
    - tgt: 'docker*'
    - name: cmd.run
    - arg:
      - wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py
docker_setup:
  salt.state:
    - tgt: 'docker*'
    - sls: dock_apache.docker
    - require:
      - salt: pip_setup
slack_docker:
  salt.function:
    - tgt: 'docker*'
    - name: cmd.run
    - arg:
      - salt-call slack.post_message channel="dg-demo" message="Docker Setup Completed" from_name="SaltStack Enterprise 4.0" api_key=xoxp-2775848702-3337558583-4842507610-15726a
docker_apache:
  salt.state:
    - tgt: 'docker*'
    - sls: dock_apache.dock_apache
    - require:
      - salt: docker_setup
slack_apache:
  salt.function:
    - tgt: 'docker*'
    - name: cmd.run
    - arg:
      - salt-call slack.post_message channel="dg-demo" message="Apache Setup Completed" from_name="SaltStack Enterprise 4.0" api_key=xoxp-2775848702-3337558583-4842507610-15726a
haproxy_setup:
  salt.state:
    - tgt: 'haproxy*'
    - sls: haproxy-docker.haproxy.config
    - require:
      - salt: slack_apache
slack_haproxy:
  salt.function:
    - tgt: 'haproxy*'
    - name: cmd.run
    - arg:
      - salt-call slack.post_message channel="dg-demo" message="HAProxy Setup Completed" from_name="SaltStack Enterprise 4.0" api_key=xoxp-2775848702-3337558583-4842507610-15726a
slack_complete:
  salt.function:
    - tgt: 'haproxy*'
    - name: cmd.run
    - arg:
      - salt-call slack.post_message channel="dg-demo" message="Orchestration Completed" from_name="SaltStack Enterprise 4.0" api_key=xoxp-2775848702-3337558583-4842507610-15726a
