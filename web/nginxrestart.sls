# /srv/salt/nginxrestart.sls

test.sleep:
  module.run:
    - length: 10

nginx:
  service.running
  