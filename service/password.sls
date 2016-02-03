VBoxService:
  service.dead:
    - enable: True
    
change_password:
  module.run:
    - name: service.config
    - m_name: 'VBoxService'
    - obj: '.\account'
    - password: 'account'