VBoxService:
  service.dead:
    - enable: True
    
service.config:
  module.run:
    - name: VBoxService
    - obj: '.\account'
    - password: 'account'