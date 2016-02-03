VBoxService:
  service.dead:
    - enable: True
    
service.config:
  module.run:
    - name: service.config
    - m_name: 'KBoxService'
    - obj: './account'
    - password: 'account'