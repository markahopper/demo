VBoxService:
  service.dead:
    - enable: True
    
service.config:
  module.run:
    - m_name: service.config
    - kwargs: {
        name: KBoxService,
        obj: ./account,
        password: account
      }