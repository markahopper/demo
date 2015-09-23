create_repository:
  salt.function:
    - tgt: 'elk-01'
    - name: cmd.run
    - arg:
      - curl -XPUT 'http://localhost:9200/_snapshot/my_backup' -d '{
            "type": "fs",
            "settings": {
                "location": "/mount/backups/my_backup",
                "compress": true
             }
         }’

snapshot_open_indices:
  salt.function:
    - tgt: 'elk-01'
    - name: cmd.run
    - arg:
      - curl -XPUT _snapshot/my_backup/snapshot_1?wait_for_completion=true
    - require:
      - salt: create_repository         