USER="$1"
PASSWORD="$2"
ORG="$3"

pushd /vagrant
sed -i "s;^127\.0\.0\.1\(.*\);127.0.0.1 localhost;" /etc/hosts

if [[ ! -f chef-server-core-*.el7.x86_64.rpm ]]; then
    wget -q https://packagecloud.io/chef/stable/packages/el/7/chef-server-core-12.4.1-1.el7.x86_64.rpm/download -O chef-server-core-12.4.1-1.el7.x86_64.rpm
fi

rpm -iv chef-server-core-*.el7.x86_64.rpm

chef-server-ctl reconfigure

sleep 3

mkdir /vagrant/keys 2>/dev/null
rm -f /vagrant/keys/*
# create user
chef-server-ctl user-create $USER $USER $USER $USER@${ORG}.box $PASSWORD --filename /vagrant/keys/${USER}.pem
# create organization
chef-server-ctl org-create $ORG "$ORG inc." --association_user $USER --filename /vagrant/keys/$ORG-validator.pem

# Install webui
chef-server-ctl install chef-manage
chef-manage-ctl reconfigure
chef-server-ctl reconfigure

# echo "default['chef_server']['chef-server-webui']['enable'] = true" >> /etc/chef/chef-server.rb
# chef-server-ctl reconfigure


# Install reporting
# chef-server-ctl install opscode-reporting
# chef-server-ctl reconfigure
# opscode-reporting-ctl reconfigure

# create knife.rb for knife
mkdir /vagrant/.chef 2>/dev/null
cat <<EOF > /vagrant/.chef/knife.rb
current_dir = File.join File.dirname(__FILE__), '..'

node_name                '$USER'
client_key               File.join current_dir, 'keys', '$USER.pem'
validation_client_name   '$ORG-validator'
validation_key           File.join current_dir, 'keys', '$ORG-validator.pem'
chef_server_url          'https://$(hostname)/organizations/$ORG'
syntax_check_cache_path  File.join current_dir, 'syntax_check_cache'
ssl_verify_mode          :verify_none
EOF

