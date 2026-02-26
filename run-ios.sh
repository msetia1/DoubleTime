#!/bin/bash

# Configuration
PROJECT="DoubleTime.xcodeproj"
SCHEME="DoubleTime"
BUNDLE_ID="Personal.DoubleTime"
DEVICE_NAME="iPhone 15 Pro"

# Find device ID
DEVICE_ID=$(xcrun simctl list devices available | grep "$DEVICE_NAME" | head -1 | grep -oE "[0-9A-Z-]{36}")

if [ -z "$DEVICE_ID" ]; then
    echo "Error: Could not find available device: $DEVICE_NAME"
    exit 1
fi

echo "Using device: $DEVICE_NAME ($DEVICE_ID)"

# 1. Open Simulator app
echo "Opening Simulator..."
open -a Simulator

# 2. Boot the device if not already booted
echo "Booting device..."
xcrun simctl boot "$DEVICE_ID" 2>/dev/null || true

# 3. Build the app
echo "Building app..."
DERIVED_DATA_PATH="./build"
xcodebuild -project "$PROJECT" -scheme "$SCHEME" -sdk iphonesimulator -destination "platform=iOS Simulator,id=$DEVICE_ID" -derivedDataPath "$DERIVED_DATA_PATH" build

if [ $? -ne 0 ]; then
    echo "Build failed!"
    exit 1
fi

# 4. Locate the app
APP_PATH=$(find "$DERIVED_DATA_PATH" -name "$SCHEME.app" -type d | head -1)

if [ -z "$APP_PATH" ]; then
    echo "Error: Could not find built app in $DERIVED_DATA_PATH"
    exit 1
fi

echo "App found at: $APP_PATH"

# 5. Install the app
echo "Installing app..."
xcrun simctl install "$DEVICE_ID" "$APP_PATH"

# 6. Launch the app
echo "Launching app..."
xcrun simctl launch "$DEVICE_ID" "$BUNDLE_ID"

echo "Done!"
