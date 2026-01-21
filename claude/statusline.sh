#!/bin/bash

# Claude Code Statusline - Minimal style with fish theme colors
# Line 1: model | tokens | cost
# Line 2: git branch | last prompt

input=$(cat)

# Extract variables using jq
MODEL=$(echo "$input" | jq -r '.model.id // "unknown"' | sed 's/claude-//' | cut -d'-' -f1)
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0' | xargs printf "%.2f")
TRANSCRIPT=$(echo "$input" | jq -r '.transcript_path // ""')

# Get last user message from transcript (JSONL format)
# Filter for messages with actual text content (not just tool_results)
LAST_PROMPT=""
if [[ -n "$TRANSCRIPT" && -f "$TRANSCRIPT" ]]; then
  # Find last user message that contains actual text (string or array with text type)
  # Process all user messages, extract text, filter empty, take last one
  LAST_PROMPT=$(grep '"type":"user"' "$TRANSCRIPT" 2>/dev/null | jq -r '
    .message.content |
    if type == "string" then
      .
    elif type == "array" then
      [.[] | select(.type == "text") | .text] | join(" ")
    else
      empty
    end
  ' 2>/dev/null | grep -v '^$' | tail -1 | head -c 40 | tr -d '\n')
  [[ ${#LAST_PROMPT} -ge 30 ]] && LAST_PROMPT="${LAST_PROMPT}..."
fi

# Get git branch (if in a git repo)
GIT_BRANCH=""
if git rev-parse --git-dir > /dev/null 2>&1; then
  GIT_BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
fi

# Colors
CYAN='\033[36m'
GREEN='\033[32m'
DIM='\033[2m'
RESET='\033[0m'

# Git branch icon (nerd font)
BRANCH_ICON=""

# Extract context window data and build progress bar
CONTEXT_SIZE=$(echo "$input" | jq '.context_window.context_window_size // 0')
CURRENT_USAGE=$(echo "$input" | jq '.context_window.current_usage')

BAR_DISPLAY=""

if [[ "$CURRENT_USAGE" != "null" && -n "$CURRENT_USAGE" ]]; then
  # Calculate current tokens
  CURRENT_TOKENS=$(echo "$CURRENT_USAGE" | jq '(.input_tokens // 0) + (.cache_creation_input_tokens // 0) + (.cache_read_input_tokens // 0)')

  # Calculate percentage
  if [[ "$CONTEXT_SIZE" -gt 0 ]]; then
    PERCENTAGE=$((CURRENT_TOKENS * 100 / CONTEXT_SIZE))

    # Build density progress bar with 40% threshold
    BAR_WIDTH=10
    THRESHOLD=4  # 40% of 10 = 4 chars
    FILLED=$((PERCENTAGE * BAR_WIDTH / 100))

    # Build bar: ▓ = filled, ▒ = until threshold, ░ = after threshold
    BAR="╠"
    for ((i=0; i<FILLED; i++)); do BAR+="▓"; done
    if [[ $FILLED -lt $THRESHOLD ]]; then
      for ((i=FILLED; i<THRESHOLD; i++)); do BAR+="▒"; done
    fi
    START=$((FILLED > THRESHOLD ? FILLED : THRESHOLD))
    for ((i=START; i<BAR_WIDTH; i++)); do BAR+="░"; done
    BAR+="╣"

    # Format token display
    CURRENT_K=$((CURRENT_TOKENS / 1000))
    CONTEXT_K=$((CONTEXT_SIZE / 1000))

    # Choose color based on usage (>40% = brighter, <=40% = dimmed)
    if [[ $PERCENTAGE -gt 40 ]]; then
      BAR_DISPLAY="${BAR} ${PERCENTAGE}% (${CURRENT_K}k/${CONTEXT_K}k)"
    else
      BAR_DISPLAY="${DIM}${BAR} ${PERCENTAGE}% (${CURRENT_K}k/${CONTEXT_K}k)${RESET}"
    fi
  fi
fi

# Build minimal statusline (two lines)
# Line 1: model | tokens | cost
LINE1="${CYAN}${MODEL}${RESET}"
[[ -n "$BAR_DISPLAY" ]] && LINE1="${LINE1} ${BAR_DISPLAY}"
LINE1="${LINE1} ${GREEN}\$${COST}${RESET}"

# Line 2: git branch | last prompt
LINE2=""
[[ -n "$GIT_BRANCH" ]] && LINE2="${BRANCH_ICON} ${GIT_BRANCH}"
[[ -n "$LAST_PROMPT" ]] && LINE2="${LINE2} ${DIM}\"${LAST_PROMPT}\"${RESET}"

echo -e "$LINE1"
[[ -n "$LINE2" ]] && echo -e "$LINE2"
