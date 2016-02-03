VBoxService:
  service.dead:
    - enable: True
    
change_password:
  module.run:
    - name: service.config
    - m_name: 'KBoxService'
    - obj: '.\account'
    - password: 'account'