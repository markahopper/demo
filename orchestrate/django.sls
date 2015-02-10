{% for name, db in salt['pillar.get']('django_apps:poll-single:DATABASES', {}).iteritems() %}

mysql:
  salt.state:
    - tgt: 'django-web1'
    - sls: django.apps.poll.single-host.db

app:
  salt.state:
    - tgt: 'django-web1'
    - require:
      - salt: mysql
    - sls:
      - django.apps.poll.single-host.vhost
      - django.apps.poll.single-host.app

load_db:
  salt.state:
    - tgt: 'django-web1'
    - require:
      - salt: app
    - sls: django.apps.poll.single-host.loaddata
    
{% endfor %}
