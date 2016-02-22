Postgres with Chef Server
=========================

1. Create Chef Server `vagrant up server`
   - Note the new file in the `demo3` directory, `config.rb`.  It details how knife should contact the new Chef Server.
2. Get cookbooks `berks install`
3. Upload cookbooks `berks upload` or `knife cookbook upload -o ~/.berkshelf/cookbooks postgresql openssl apt build-essential 7-zip windows chef-sugar chef_handler`
4. Spin up node to bootstrap `vagrant up node1 --no-provision`.
   - Pass `--no-provision` so we can manually bootstrap the node.  Removing this option will cause vagrant to automatically bootstrap the node.
5. Create new node1 `knife node create node1`
Set "normal" to:
```
"normal": {
    "postgresql": {
        "config": {
            "data_directory": "/var/lib/pgsql/data",
            "listen_addresses": "0.0.0.0"
        },
        "dir": "/var/lib/pgsql/data",
        "pg_hba": [
            {
                "addr": "0.0.0.0/0",
                "db": "all",
                "method": "trust",
                "type": "host",
                "user": "postgres"
            },
            {
                "addr": null,
                "db": "all",
                "method": "trust",
                "type": "local",
                "user": "vagrant"
            }
        ]
    }
}
```
6. Bootstrap the new node `knife bootstrap vagrant@node1.cheftest.box -i .vagrant/machines/node1/virtualbox/private_key --sudo -N node1 -r postgresql::server_redhat --node-ssl-verify-mode none`
7. Visit [https://server.cheftest.box][https://server.cheftest.box], explore the Chef Server management UI.
   User: `admin`, Pass: `vagrant`

8. Connect to postgres with `psql -h node1.cheftest.box -U postgres`
