#!/bin/bash

# Claude Code Statusline - Minimal style with fish theme colors
# Displays: model | tokens | cost | last prompt

input=$(cat)

# Extract variables using jq
MODEL=$(echo "$input" | jq -r '.model.id // "unknown"' | sed 's/claude-//' | cut -d'-' -f1)
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0' | xargs printf "%.2f")
TRANSCRIPT=$(echo "$input" | jq -r '.transcript_path // ""')

# Get last user message from transcript (JSONL format)
# Handle both string content and array content
LAST_PROMPT=""
if [[ -n "$TRANSCRIPT" && -f "$TRANSCRIPT" ]]; then
  # Try to extract content - handle both string and array formats
  LAST_PROMPT=$(grep '"type":"user"' "$TRANSCRIPT" 2>/dev/null | tail -1 | jq -r '
    if (.message.content | type == "string") then
      .message.content
    elif (.message.content | type == "array") then
      .message.content[] | select(.type == "text") | .text
    else
      empty
    end
  ' 2>/dev/null | head -c 40 | tr -d '\n')
  [[ ${#LAST_PROMPT} -ge 30 ]] && LAST_PROMPT="${LAST_PROMPT}..."
fi

# Colors
CYAN='\033[36m'
GREEN='\033[32m'
DIM='\033[2m'
RESET='\033[0m'

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

# Build minimal statusline
OUTPUT="${CYAN}${MODEL}${RESET}"
[[ -n "$BAR_DISPLAY" ]] && OUTPUT="${OUTPUT} ${BAR_DISPLAY}"
OUTPUT="${OUTPUT} ${GREEN}\$${COST}${RESET}"
[[ -n "$LAST_PROMPT" ]] && OUTPUT="${OUTPUT} ${DIM}\"${LAST_PROMPT}\"${RESET}"

echo -e "$OUTPUT"
