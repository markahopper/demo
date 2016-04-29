# nginx_pretty.sls Orchestration file for nginx pretty
nginx_dev:
  salt.function:
    - tgt: 'minion03'
    - name: cmd.run
    - arg:
      - salt-call state.sls nginx.pretty
