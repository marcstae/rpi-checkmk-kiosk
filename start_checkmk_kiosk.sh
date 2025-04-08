#!/bin/bash

# === Configuration ===
# --- Checkmk Server Details ---
CHECKMK_HOSTNAME="your_checkmk_server.example.com" # Replace with your Checkmk server's FQDN or IP
CHECKMK_SITENAME="mysite"                         # Replace with your Checkmk site name
CHECKMK_DASHBOARD="main"                          # Replace with the desired dashboard name (e.g., main, network, custom_dashboard)

# --- Checkmk Kiosk User Credentials ---
# IMPORTANT: Use a dedicated, low-privilege user created as per the instructions
# (Role: Guest user or custom limited role, simple password, login timeout disabled)
KIOSK_USERNAME="kioskuser"                        # Replace with the username you created
KIOSK_PASSWORD="SimplePassword123"                # Replace with the password for the kiosk user

# --- Raspberry Pi Display & Browser Settings ---
# Delay in seconds before launching Firefox (allows desktop/network to initialize)
STARTUP_DELAY=30
# Optional: Specify a specific Firefox profile if needed
# FIREFOX_PROFILE_OPTION="--profile /path/to/your/profile"
FIREFOX_PROFILE_OPTION=""

# === Script Logic ===

# Construct the Checkmk Login URL
# Note: The URL encodes the target dashboard URL within the _origtarget parameter.
TARGET_DASHBOARD_URL="/${CHECKMK_SITENAME}/check_mk/dashboard.py?name=${CHECKMK_DASHBOARD}"
LOGIN_URL="https://${CHECKMK_HOSTNAME}/${CHECKMK_SITENAME}/check_mk/login.py?_origtarget=${TARGET_DASHBOARD_URL}&_username=${KIOSK_USERNAME}&_password=${KIOSK_PASSWORD}&_login=1"

echo "$(date): Waiting ${STARTUP_DELAY} seconds before launching Checkmk Kiosk..."
sleep ${STARTUP_DELAY}

echo "$(date): Attempting to launch Firefox in Kiosk mode..."
echo "URL: ${LOGIN_URL}" # Displaying URL for debugging (remove if sensitive)

# Ensure the DISPLAY environment variable is set (crucial if run from cron)
export DISPLAY=:0

# Kill any existing Firefox instances to ensure a clean start (optional, use with caution)
# pkill -f firefox

# Launch Firefox in Kiosk Mode
# --kiosk: Standard kiosk mode
# --new-instance: Tries to start a new instance instead of opening a new window in an existing one
# --private-window: Helps avoid session/cache issues, but might require login more often if the Pi reboots frequently. Remove if not desired.
firefox --kiosk --new-instance --private-window ${FIREFOX_PROFILE_OPTION} "${LOGIN_URL}" &

echo "$(date): Firefox launch command issued."

exit 0