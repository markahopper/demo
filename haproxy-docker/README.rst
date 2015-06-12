======================
haproxy-docker formula
======================

A saltstack formula to proxy docker containers serving http traffic with
haproxy.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``haproxy``
-----------

Install haproxy from packages

``haproxy.config``
------------------

Query Salt for the IP and ports of the docker hosts hosting the specified
docker image and configure haproxy to proxy them on port 80
