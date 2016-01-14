create_AppPool:
  cmd.run:
    - name: New-WebAppPool -Name TestPool
    - shell: powershell