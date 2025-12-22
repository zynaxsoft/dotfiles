#!/bin/bash

# Claude Code Statusline - Minimal style with fish theme colors
# Displays: model | tokens | cost | last prompt

input=$(cat)

# Extract variables using jq
MODEL=$(echo "$input" | jq -r '.model.id // "unknown"' | sed 's/claude-//' | cut -d'-' -f1)
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0' | xargs printf "%.2f")
TRANSCRIPT=$(echo "$input" | jq -r '.transcript_path // ""')

# Get last user message from transcript (JSONL format)
# Only get messages where content is a string (actual user prompts, not tool results)
LAST_PROMPT=""
if [[ -n "$TRANSCRIPT" && -f "$TRANSCRIPT" ]]; then
  LAST_PROMPT=$(grep '"type":"user"' "$TRANSCRIPT" 2>/dev/null | tail -1 | jq -r 'select(.message.content | type == "string") | .message.content' 2>/dev/null | head -c 40 | tr -d '\n')
  [[ ${#LAST_PROMPT} -ge 30 ]] && LAST_PROMPT="${LAST_PROMPT}..."
fi

# Get token usage from LAST assistant message (current context size)
TOKENS=""
if [[ -n "$TRANSCRIPT" && -f "$TRANSCRIPT" ]]; then
  # Get last assistant message's input tokens (input + cache = total context for that turn)
  LAST_USAGE=$(grep '"type":"assistant"' "$TRANSCRIPT" 2>/dev/null | tail -1 | jq '.message.usage // {}' 2>/dev/null)
  if [[ -n "$LAST_USAGE" && "$LAST_USAGE" != "{}" ]]; then
    INPUT_TOKENS=$(echo "$LAST_USAGE" | jq '(.input_tokens // 0) + (.cache_read_input_tokens // 0) + (.cache_creation_input_tokens // 0)' 2>/dev/null)
    if [[ -n "$INPUT_TOKENS" && "$INPUT_TOKENS" != "null" && "$INPUT_TOKENS" != "0" ]]; then
      TOTAL_K=$(( INPUT_TOKENS / 1000 ))
      TOKENS="${TOTAL_K}k"
    fi
  fi
fi

# Fish theme colors (default)
CYAN='\033[36m'
GREEN='\033[32m'
YELLOW='\033[33m'
DIM='\033[2m'
RESET='\033[0m'

# Build minimal statusline
OUTPUT="${CYAN}${MODEL}${RESET}"
[[ -n "$TOKENS" ]] && OUTPUT="${OUTPUT} ${DIM}${TOKENS}${RESET}"
OUTPUT="${OUTPUT} ${GREEN}\$${COST}${RESET}"
[[ -n "$LAST_PROMPT" ]] && OUTPUT="${OUTPUT} ${DIM}\"${LAST_PROMPT}\"${RESET}"

echo -e "$OUTPUT"
