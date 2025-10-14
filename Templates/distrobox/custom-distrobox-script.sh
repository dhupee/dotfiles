#!/bin/bash
# template_2_create_container.sh - Creates a single Distrobox with customizable parameters.

# --- User-Defined Variables ---
# Edit these values to suit your needs for this container.
CONTAINER_NAME="my-dev-container"
CONTAINER_IMAGE="ubuntu:22.04"
CONTAINER_HOME_DIR="$HOME/distrobox/$CONTAINER_NAME" # Isolated home directory
CONTAINER_MANAGER="podman"
ADDITIONAL_PACKAGES="git htop vim curl"
INSTALL_SYSTEMD="true" # Set to "true" to install and use systemd inside the container.
USE_NVIDIA="false" # Set to "true" for NVIDIA GPU support.

# --- Container Creation Command ---
echo "Creating container '$CONTAINER_NAME' from image $CONTAINER_IMAGE..."

CREATE_CMD="distrobox create"

# Build the command with the chosen options
CREATE_CMD="$CREATE_CMD --name $CONTAINER_NAME"
CREATE_CMD="$CREATE_CMD --image $CONTAINER_IMAGE"
CREATE_CMD="$CREATE_CMD --home $CONTAINER_HOME_DIR"
CREATE_CMD="$CREATE_CMD --additional-packages \"$ADDITIONAL_PACKAGES\""
CREATE_CMD="$CREATE_CMD --pull" # Ensure the latest image is used.

# Optionally add init system (systemd)
if [ "$INSTALL_SYSTEMD" = "true" ]; then
    CREATE_CMD="$CREATE_CMD --init"
    # Note: On some images, you might need to add systemd-specific packages.
    # Consider adding: --additional-packages "systemd libpam-systemd pipewire-audio-client-libraries"
fi

# Optionally add NVIDIA support
if [ "$USE_NVIDIA" = "true" ]; then
    CREATE_CMD="$CREATE_CMD --nvidia"
fi

# --- Execute the command ---
echo "Running: $CREATE_CMD"
eval $CREATE_CMD

# --- Post-creation instructions ---
echo ""
echo "Container '$CONTAINER_NAME' has been created."
echo "To enter the container, run:"
echo "  distrobox enter $CONTAINER_NAME"