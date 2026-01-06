#!/bin/bash
# Master installation script for Salesforce PAI Skills Suite

set -e

echo "═══════════════════════════════════════════════════════════"
echo "  Salesforce PAI Skills Suite - Complete Installation"
echo "═══════════════════════════════════════════════════════════"
echo ""

# Detect PAI directory
if [ -z "$PAI_DIR" ]; then
    if [ -d "$HOME/.claude/Skills" ]; then
        PAI_DIR="$HOME/.claude"
        echo "✓ Found PAI at: $HOME/.claude"
    elif [ -d "$HOME/.config/pai/Skills" ]; then
        PAI_DIR="$HOME/.config/pai"
        echo "✓ Found PAI at: $HOME/.config/pai"
    else
        echo "❌ Could not find PAI Skills directory"
        echo ""
        echo "Please set PAI_DIR environment variable:"
        echo "  export PAI_DIR=\"/path/to/your/pai\""
        echo ""
        exit 1
    fi
else
    echo "✓ Using PAI_DIR: $PAI_DIR"
fi

# Check if Skills directory exists
if [ ! -d "$PAI_DIR/Skills" ]; then
    echo "❌ $PAI_DIR/Skills directory not found"
    exit 1
fi

echo ""
echo "Installing Salesforce Skills Suite..."
echo ""

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# List of skills to install
SKILLS=(
    "SalesforceAcceptanceCriteria"
    "SalesforceDocumentation"
    "SalesforceTesting"
    "SalesforceDevelopment"
    "SalesforceDataMigration"
)

# Install each skill
INSTALLED=0
SKIPPED=0

for SKILL in "${SKILLS[@]}"; do
    echo "Installing $SKILL..."
    
    SOURCE_DIR="$SCRIPT_DIR/$SKILL"
    TARGET_DIR="$PAI_DIR/Skills/$SKILL"
    
    if [ ! -d "$SOURCE_DIR" ]; then
        echo "  ⚠️  Source directory not found: $SOURCE_DIR"
        continue
    fi
    
    if [ -d "$TARGET_DIR" ]; then
        echo "  ⚠️  Already exists, skipping..."
        SKIPPED=$((SKIPPED + 1))
        continue
    fi
    
    cp -r "$SOURCE_DIR" "$TARGET_DIR"
    echo "  ✓ Installed to $TARGET_DIR"
    INSTALLED=$((INSTALLED + 1))
done

echo ""
echo "═══════════════════════════════════════════════════════════"
echo "  Installation Complete!"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "📊 Summary:"
echo "  ✓ Installed: $INSTALLED skills"
echo "  ⚠ Skipped: $SKIPPED skills (already installed)"
echo ""
echo "🎯 Installed Skills:"
for SKILL in "${SKILLS[@]}"; do
    if [ -d "$PAI_DIR/Skills/$SKILL" ]; then
        echo "  ✓ $SKILL"
    fi
done
echo ""
echo "🚀 Quick Tests:"
echo ""
echo "1. Acceptance Criteria:"
echo "   \"Create AC for territory-based lead assignment\""
echo ""
echo "2. Documentation:"
echo "   \"Create a job aid for the routing feature\""
echo ""
echo "3. Testing:"
echo "   \"Generate test class for OpportunityTriggerHandler\""
echo ""
echo "4. Development:"
echo "   \"Create an LWC to display opportunity products\""
echo ""
echo "5. Data Migration:"
echo "   \"Create field mapping from legacy to Salesforce Account\""
echo ""
echo "📖 Documentation:"
echo "  - Suite README: $SCRIPT_DIR/README.md"
echo "  - Individual READMEs in each skill directory"
echo ""
echo "🛠️  Customize:"
echo "  - Edit context files in each skill's context/ directory"
echo "  - Add your patterns, standards, and preferences"
echo ""
echo "Happy building! 🎉"
echo ""
