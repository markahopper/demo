VBoxService:
  service.dead:
    - enable: True
    
service.config:
  salt.function:
    - name: service.config
    - kwargs: {
        name: KBoxService,
        obj: ./account,
        password: account
      }