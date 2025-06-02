# Perform a full update
# Refresh the mirrors list and select the fastest ones
# Then upgrade packages, including AUR, allow Pamac to downgrade if needed
# Alow refresh the package database for good measure

echo "Performing update..."
echo "----------------------------------------------"
sudo pacman-mirrors -f ; pamac update -a --enable-downgrade --force-refresh

# List any packages that require a rebuild:

echo "The following packages may require a re-build:"
echo "----------------------------------------------"
checkrebuild

echo "The following pacnew files may require attention:"
echo "----------------------------------------------"
pacdiff -o

# Check for firmware updates:
echo "Checking for firmware updates with fwupd"
echo "----------------------------------------------"

fwupdmgr refresh
fwupdmgr get-updates

# Notes: 

# Use this command to rebuild all packages using outdated dependencies:

# pamac build $(checkrebuild | awk '{print $2}')

# Update using pacman (sometimes recommended):

# sudo pacman -Syuu

# Change this to reflect the outdated Python version and rebuild all packages that are affected:

# pamac build $(pacman -Qoq /usr/lib/python3.11)

# Note: When getting errors such as this:

# Error: Target not found: python-manjaro-sdk

# Likely these are packages that can be safely removed and have since been deprecated or replaced.
# Check the dependencies first using:

# pamac info python-manjaro-sdk

