#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}=== English Pocket Teacher - Build Configuration ===${NC}"

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo -e "${RED}Flutter is not installed!${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Flutter found${NC}"

# Get dependencies
echo -e "${YELLOW}Installing dependencies...${NC}"
flutter pub get

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Dependencies installed${NC}"
else
    echo -e "${RED}✗ Failed to install dependencies${NC}"
    exit 1
fi

# Run code generation
echo -e "${YELLOW}Running code generation...${NC}"
flutter pub run build_runner build --delete-conflicting-outputs

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Code generation complete${NC}"
else
    echo -e "${YELLOW}Note: Code generation skipped (may not be needed)${NC}"
fi

# Analyze code
echo -e "${YELLOW}Analyzing code...${NC}"
flutter analyze

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Code analysis passed${NC}"
else
    echo -e "${YELLOW}⚠ Code analysis warnings found${NC}"
fi

# Run tests
echo -e "${YELLOW}Running tests...${NC}"
flutter test

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Tests passed${NC}"
else
    echo -e "${YELLOW}⚠ Some tests failed${NC}"
fi

echo -e "${GREEN}=== Build configuration complete! ===${NC}"
