VBoxService:
  service.dead:
    - enable: True
    
service.config:
  module.run:
    - name: service.config
    - kwargs: {
        name: KBoxService,
        obj: ./account,
        password: account
      }