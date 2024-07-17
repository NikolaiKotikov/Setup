prompt "Open firefox and import WireGuard config file"

run_in_background firefox

prompt "Ensure config is imported"

nmcli connection import type wireguard file ~/Downloads/*.conf
