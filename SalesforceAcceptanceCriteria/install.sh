#!/bin/bash
# Installation script for Salesforce Acceptance Criteria Skill

set -e  # Exit on error

echo "═══════════════════════════════════════════════════════════"
echo "  Salesforce Acceptance Criteria Skill - Installation"
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
    echo "Please make sure PAI is properly installed"
    exit 1
fi

echo ""
echo "Installing Salesforce Acceptance Criteria Skill..."
echo ""

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Copy the skill
SKILL_NAME="SalesforceAcceptanceCriteria"
TARGET_DIR="$PAI_DIR/Skills/$SKILL_NAME"

# Check if already installed
if [ -d "$TARGET_DIR" ]; then
    echo "⚠️  Skill already exists at: $TARGET_DIR"
    read -p "Overwrite? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled"
        exit 0
    fi
    rm -rf "$TARGET_DIR"
fi

# Copy files
cp -r "$SCRIPT_DIR" "$TARGET_DIR"
echo "✓ Copied skill files to $TARGET_DIR"

# Verify installation
echo ""
echo "Verifying installation..."
if [ -f "$TARGET_DIR/SKILL.md" ]; then
    echo "✓ SKILL.md found"
else
    echo "❌ SKILL.md not found"
    exit 1
fi

if [ -d "$TARGET_DIR/workflows" ]; then
    echo "✓ workflows/ directory found"
    WORKFLOW_COUNT=$(find "$TARGET_DIR/workflows" -name "*.md" | wc -l)
    echo "  - Found $WORKFLOW_COUNT workflow(s)"
else
    echo "❌ workflows/ directory not found"
    exit 1
fi

if [ -d "$TARGET_DIR/context" ]; then
    echo "✓ context/ directory found"
else
    echo "❌ context/ directory not found"
    exit 1
fi

echo ""
echo "═══════════════════════════════════════════════════════════"
echo "  ✅ Installation Complete!"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "📁 Installed at: $TARGET_DIR"
echo ""
echo "🚀 Quick Test:"
echo "   Open Claude Code and try:"
echo "   'Create acceptance criteria for territory-based lead assignment'"
echo ""
echo "📖 Documentation:"
echo "   - QUICKSTART.md - Get started in 5 minutes"
echo "   - README.md - Complete documentation"
echo ""
echo "🛠️  Customize:"
echo "   Edit $TARGET_DIR/context/SalesforceStandards.md"
echo "   to add your own patterns and preferences"
echo ""
echo "Happy building! 🎉"
echo ""
