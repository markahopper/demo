pip_install:
  cmd.run:
    - name: wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py

docker-python-apt:
  pkg.installed:
    - name: python-apt

docker-dependencies:
  pkg.installed:
    - pkgs:
      - iptables
      - ca-certificates
      - lxc
#      - python-pip

docker-py:
  pip.installed:
    - name: docker-py
    - reload_modules: True
    - require:
      - pkg: docker-dependencies

docker_repo:
  pkgrepo.managed:
    - repo: 'deb http://get.docker.io/ubuntu docker main'
    - file: '/etc/apt/sources.list.d/docker.list'
    - key_url: salt://docker/docker.pgp
    - require_in:
      - pkg: lxc-docker
    - require:
      - pkg: docker-python-apt

lxc-docker:
  pkg.latest:
    - require:
      - pkg: docker-dependencies

docker:
  service.running
