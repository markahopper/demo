############################
### Remove IIS Resource ###
############################


"Remove IIS Resources":
  win_servermanager.removed:
    - name: 'Web-Server,Web-Mgmt-Tools,Web-Mgmt-Console,Web-Scripting-Tools'
