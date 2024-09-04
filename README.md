# **`dynamic-vpn-config`**.

# Repository Structure:

```
dynamic-vpn-config/
│
├── config.json
├── generate_mobileconfig.sh
└── README.md
```

### Adjusted Script (`generate_mobileconfig.sh`):

Make sure to update the script with the correct repository name:

```bash
#!/bin/bash

# Define the GitHub raw URL for the config.json
CONFIG_URL=“https://raw.githubusercontent.com/YOUR_USERNAME/dynamic-vpn-config/main/config.json”

# Fetch the latest IP from the GitHub repository
IP=$(curl -s $CONFIG_URL | jq -r ‘.remote_ip’)

# Check if IP was fetched successfully
if [ -z “$IP” ]; then
    echo “Failed to fetch IP from config.json. Please check the URL or file.”
    exit 1
fi

# Generate the mobileconfig file with the new IP
cat <<EOF > DynamicVPN.mobileconfig
<?xml version=“1.0” encoding=“UTF-8”?>
<!DOCTYPE plist PUBLIC “-//Apple//DTD PLIST 1.0//EN” “http://www.apple.com/DTDs/PropertyList-1.0.dtd”>
<plist version=“1.0”>
  <dict>
    <key>PayloadContent</key>
    <array>
      <dict>
        <key>PayloadVersion</key>
        <integer>1</integer>
        <key>PayloadUUID</key>
        <string>$(uuidgen)</string>
        <key>PayloadType</key>
        <string>com.apple.vpn.managed</string>
        <key>PayloadIdentifier</key>
        <string>com.example.vpnconfig</string>
        <key>UserDefinedName</key>
        <string>Dynamic VPN</string>
        <key>VPNType</key>
        <string>IKEv2</string>
        <key>RemoteAddress</key>
        <string>${IP}</string>
        <!— Add other VPN settings like authentication as needed —>
      </dict>
    </array>
    <key>PayloadType</key>
    <string>Configuration</string>
    <key>PayloadIdentifier</key>
    <string>com.example.mobileconfig</string>
    <key>PayloadUUID</key>
    <string>$(uuidgen)</string>
    <key>PayloadVersion</key>
    <integer>1</integer>
    <key>PayloadDisplayName</key>
    <string>Dynamic VPN Configuration</string>
  </dict>
</plist>
EOF

echo “DynamicVPN.mobileconfig file created with IP: $IP”
```

### Updated `README.md`:

```markdown
# Dynamic VPN Configuration

This repository, `dynamic-vpn-config`, provides a way to dynamically update an iPhone’s VPN configuration using a hosted `config.json` file.

## Files

- **config.json**: Stores the current IP address for the VPN.
- **generate_mobileconfig.sh**: A script that fetches the IP from `config.json` and generates a `mobileconfig` file for iOS devices.

## How to Use

1. **Update IP Address**: 
   - Update the IP address in the `config.json` file.

2. **Generate `mobileconfig` File**: 
   - Run the `generate_mobileconfig.sh` script to create a new `DynamicVPN.mobileconfig` file with the updated IP address.
   
   ```bash
   ./generate_mobileconfig.sh
   ```

3. **Deploy**:
   - Distribute the `DynamicVPN.mobileconfig` file to your iPhone users.

## Automation

You can automate the process of fetching the latest IP and generating the `mobileconfig` file using a cron job or any other scheduling tool.

Example Cron Job:

```bash
0 * * * * /path/to/your/generate_mobileconfig.sh
```

This job will run the script every hour, ensuring the `mobileconfig` file is always up to date.
```

### Final Steps:

- Replace `YOUR_USERNAME` in the script with your actual GitHub username.
- Create and push the files to your GitHub repository named `dynamic-vpn-config`.
- Use and share the script and mobileconfig file as needed.