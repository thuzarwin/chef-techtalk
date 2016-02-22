Postgres with Chef Solo
=======================

1. Fetch the cookbooks:

```
for cookbook in openssl apt "chef-sugar" chef_handler "7-zip" "build-essential" postgresql windows; do
  knife cookbook site download $cookbook
  tar -xf $cookbook-*.tar.gz -C cookbooks/
  rm $cookbook-*.tar.gz
done
```

2. Start the virtual machine! `vagrant up`
3. Connect to postgres with `psql -h localhost -U postgres`

