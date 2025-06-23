# Aliases for WARP-CLI 1.1.1.1

# # Start WARP Services
# alias warp-service-start="systemctl start warp-svc.service"
#
# # Stops WARP Services
# alias warp-service-stop="systemctl stop warp-svc.service"

# Initialize the app
alias warp-init="warp-cli register ; sleep 1s ; warp-cli set-mode warp+doh"

# Check whether the connections is established and connected to cloudflare server
alias warp-check="curl https://www.cloudflare.com/cdn-cgi/trace/"

# Connect to WARP server
alias warp-connect="warp-cli connect"

# Disconnect from WARP server
alias warp-disconnect="warp-cli disconnect"
