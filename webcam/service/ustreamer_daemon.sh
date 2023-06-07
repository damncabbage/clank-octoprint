#!/bin/bash

SCRIPT_DIR=$(unset CDPATH && cd "$(dirname "$0")" && pwd)

USTREAMER_HOME="${SCRIPT_DIR}/../ustreamer"

# Init configuration
camera="usb"
camera_device="/dev/video0"
camera_options="-m MJPEG -f 10 -c NOOP --device=${camera_device}"

# Runs uStreamer, using the provided configuration
runUStreamer() {
  pushd "$USTREAMER_HOME"
		(
			set -x
			./ustreamer $camera_options --host=0.0.0.0 --port=8080
		)
  popd
}

echo "Camera: $camera"
echo "Options: $camera_options"

# Keep ustreamer running if some camera is attached
while true; do
    if [ -e "${camera_device}" ] && { [ "$camera" = "auto" ] || [ "$camera" = "usb" ] ; }; then
        runUStreamer
    fi

    sleep 120
done
