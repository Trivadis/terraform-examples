#!/bin/bash
# find public ip addr
sudo su
ip=$(curl -s https://api.ipify.org)
# run AS init script with public ip as host
/usr/local/openvpn_as/bin/ovpn-init --batch --host=$ip
# wait of AS to load and then carry out sacli commands
while ! [ "True" = "$(/usr/local/openvpn_as/scripts/sacli LocalAuthEnabled)" ]; do sleep 10; done
# set AS to use external DNS servers
/usr/local/openvpn_as/scripts/sacli -k "vpn.client.routing.reroute_dns" -v "custom" ConfigPut
/usr/local/openvpn_as/scripts/sacli -k "vpn.server.dhcp_option.dns.0" -v  "1.1.1.1" ConfigPut
/usr/local/openvpn_as/scripts/sacli -k "vpn.server.dhcp_option.dns.1" -v "8.8.8.8" ConfigPut
/usr/local/openvpn_as/scripts/sacli start
# add admin username with password
/usr/local/openvpn_as/scripts/sacli --user "${admin_username}" --new_pass "${password}" SetLocalPassword
/usr/local/openvpn_as/scripts/sacli --key "prop_superuser" --value "true" --user "${admin_username}" UserPropPut
/usr/local/openvpn_as/scripts/sacli start
# activate AS with key
# /usr/local/openvpn_as/scripts/sacli --lic_key "${as_activation_key}" LicActivate
# Set route rule to private network
/usr/local/openvpn_as/scripts/sacli --key "vpn.server.routing.private_network.0" --value "10.1.0.0/27" ConfigDel
/usr/local/openvpn_as/scripts/sacli --key "vpn.server.routing.private_network.0" --value "10.1.0.32/27" ConfigPut
/usr/local/openvpn_as/scripts/sacli start

# Set DNS client rule
/usr/local/openvpn_as/scripts/sacli --key "vpn.client.routing.reroute_dns" --value "false" ConfigPut
/usr/local/openvpn_as/scripts/sacli start