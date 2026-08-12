#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}=== Building App Bundle (AAB) for Google Play ===${NC}"

# Clean previous builds
echo -e "${YELLOW}Cleaning previous builds...${NC}"
flutter clean
rm -rf build/

# Get dependencies
echo -e "${YELLOW}Installing dependencies...${NC}"
flutter pub get

# Build AAB
echo -e "${YELLOW}Building release App Bundle...${NC}"
flutter build appbundle --release

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ App Bundle build successful!${NC}"
    echo -e "${GREEN}Output:${NC}"
    ls -lh build/app/outputs/bundle/release/
    echo -e "${GREEN}AAB ready for Google Play Store!${NC}"
else
    echo -e "${RED}✗ App Bundle build failed${NC}"
    exit 1
fi
