stop_webserver:
  salt.function:
    - tgt: 'roles:webserver'
    - tgt_type: grain
    - name: service.stop
    - arg:
      - nginx