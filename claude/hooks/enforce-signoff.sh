#!/bin/bash

#  Add this to settings.json
#   "hooks": {
#     "PreToolUse": [
#       {
#         "matcher": "Bash",
#         "hooks": [
#           {
#             "type": "command",
#             "command": "~/dotfiles/claude/hooks/enforce-signoff.sh"
#           }
#         ]
#       }
#     ]
#   }


# Pre-hook to enforce signed-off commits (git commit -s)
# This hook runs before git commit commands and blocks if -s flag is missing

# Read JSON input from stdin
INPUT=$(cat)

# Extract the command from tool_input
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# Only check git commit commands, let other commands pass through
if ! echo "$COMMAND" | grep -qE '\bgit\s+commit\b'; then
    exit 0
fi

# Check if -s or --signoff flag is present
if ! echo "$COMMAND" | grep -qE '(-s|--signoff)\b'; then
    echo "Please use 'git commit -s' instead of 'git commit' to sign off your commits." >&2
    exit 2
fi

exit 0
