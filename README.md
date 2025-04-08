# Checkmk Raspberry Pi Kiosk Display

## Purpose

This script (`start_checkmk_kiosk.sh`) automatically launches Firefox in kiosk (fullscreen) mode on a Raspberry Pi's desktop environment upon startup. It directly logs into a specified Checkmk dashboard using URL parameters.

Ideal for displaying monitoring status on a dedicated TV screen.

## Prerequisites

1. **Raspberry Pi:** With Raspberry Pi OS Desktop (or another desktop environment) installed and booted to the desktop.
2. **Firefox:** Installed (`sudo apt update && sudo apt install firefox-esr`).
3. **Checkmk User:** A dedicated Checkmk user account with:
    * Read-only permissions (e.g., 'Guest user' role or a custom limited role).
    * A simple password (letters/numbers recommended).
    * Login timeout disabled within Checkmk user settings.
4. **(Recommended)** Raspberry Pi configured for automatic login to the desktop environment (`sudo raspi-config`).

## Configuration

1. **Edit the Script:** Open `start_checkmk_kiosk.sh` in a text editor.
2. **Update Variables:** Modify the following variables in the `=== Configuration ===` section to match your environment:
    * `CHECKMK_HOSTNAME`
    * `CHECKMK_SITENAME`
    * `CHECKMK_DASHBOARD`
    * `KIOSK_USERNAME`
    * `KIOSK_PASSWORD`
3. **(Optional)** Adjust `STARTUP_DELAY` if Firefox starts too quickly before the network/desktop is ready.

## Usage & Autostart

1. **Make Executable:**

    ```bash
    chmod +x start_checkmk_kiosk.sh
    ```

2. **Test Manually (Recommended):**
    Run the script from a terminal *on the Pi's desktop* to ensure it works correctly before setting up autostart:

    ```bash
    ./start_checkmk_kiosk.sh
    ```

3. **Setup Autostart (Best Practice):**
    * Create the autostart directory if it doesn't exist:

        ```bash
        mkdir -p /home/pi/.config/autostart
        ```

        *(Adjust `/home/pi` if using a different user)*
    * Create a `.desktop` file:

        ```bash
        nano /home/pi/.config/autostart/checkmk-kiosk.desktop
        ```

    * Paste the following content, **making sure to use the full, absolute path** to your script in the `Exec=` line:

        ```ini
        [Desktop Entry]
        Type=Application
        Name=Checkmk Kiosk Display
        Comment=Start Checkmk Dashboard in Firefox Kiosk Mode
        Exec=/home/pi/start_checkmk_kiosk.sh # <-- IMPORTANT: Use the full path here
        Terminal=false
        StartupNotify=false
        ```

    * Save and close the editor.

4. **Reboot:**

    ```bash
    sudo reboot
    ```

    After rebooting and logging into the desktop, the script should run automatically after the configured delay, launching Firefox with your dashboard.
