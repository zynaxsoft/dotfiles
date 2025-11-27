#!/usr/bin/env fish

# Fetch Claude Code changelog and display only the latest version information
# Usage: ./claude-code-changelog.fish

set CHANGELOG_URL "https://raw.githubusercontent.com/anthropics/claude-code/main/CHANGELOG.md"

function extract_latest_version --description "Extract the latest version section from a markdown changelog" --argument-names changelog
    # Extracts content from the first '## ' heading until the next '## ' heading.
    #
    # Arguments:
    #   changelog - A markdown string containing version sections formatted as '## x.y.z'
    #
    # Returns:
    #   The first version section including heading and content
    #   Empty string if no version section found
    #
    # Example:
    #   set changelog "## 2.0.55\n- Fix bug\n\n## 2.0.54\n- Old fix"
    #   extract_latest_version "$changelog"
    #   # Output:
    #   # ## 2.0.55
    #   # - Fix bug

    echo "$changelog" | awk '
        /^## / {
            if (found) exit
            found = 1
        }
        found { print }
    '
end

function fetch_latest_changelog --description "Fetch a markdown changelog from URL and return the latest version section" --argument-names url
    # Fetches a changelog from a URL and extracts the latest version section.
    #
    # Arguments:
    #   url - URL to a markdown changelog file (e.g., raw GitHub URL)
    #
    # Returns:
    #   Exit 0: The latest version section (heading + content) on stdout
    #   Exit 1: Error message on stderr if fetch fails or changelog is empty
    #   Exit 2: Error message on stderr if changelog format is invalid
    #
    # Example:
    #   # Basic usage
    #   fetch_latest_changelog "https://raw.githubusercontent.com/anthropics/claude-code/main/CHANGELOG.md"
    #
    #   # Capture output in another script
    #   set result "$(fetch_latest_changelog $url)"
    #   if test $status -eq 0
    #       echo "Latest version info:"
    #       echo "$result"
    #   end

    if test -z "$url"
        echo "Error: URL argument is required" >&2
        return 1
    end

    # Fetch the changelog (quoted to preserve newlines as single string)
    set changelog "$(curl -sL "$url")"

    if test -z "$changelog"
        echo "Error: Failed to fetch changelog from $url" >&2
        return 1
    end

    # Extract the latest version section
    set latest_version "$(extract_latest_version "$changelog")"

    if test -z "$latest_version"
        echo "Error: Could not parse changelog format" >&2
        return 2
    end

    echo "$latest_version"
end

# Main: Run if script is executed directly (not sourced)
if status is-interactive; or not string match -q '*source*' (history --max=1 2>/dev/null)
    fetch_latest_changelog "$CHANGELOG_URL"
end
