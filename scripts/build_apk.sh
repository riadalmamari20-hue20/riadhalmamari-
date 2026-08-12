#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}=== Building APK Release ===${NC}"

# Clean previous builds
echo -e "${YELLOW}Cleaning previous builds...${NC}"
flutter clean
rm -rf build/

# Get dependencies
echo -e "${YELLOW}Installing dependencies...${NC}"
flutter pub get

# Build APK
echo -e "${YELLOW}Building release APK...${NC}"
flutter build apk --release --split-per-abi

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ APK build successful!${NC}"
    echo -e "${GREEN}Output:${NC}"
    ls -lh build/app/outputs/flutter-apk/
    echo -e "${GREEN}APK ready for testing!${NC}"
else
    echo -e "${RED}✗ APK build failed${NC}"
    exit 1
fi
