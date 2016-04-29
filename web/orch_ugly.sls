# nginx_ugly.sls Orchestration file for nginx ugly
nginx_dev:
  salt.state:
    - tgt: 'minion03'
    - sls: nginx.ugly
