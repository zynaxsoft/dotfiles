Generate a patch message by analyzing stacked-git patch's changes.

Steps:
1. Run `stg email format $ARGUMENTS -G --stdout | tee` to retrieve all staged changes. Ignore every data about the commit message, only look at the diff that is after `diff --git` line.
2. Read each modified file in full to understand its purpose and context
3. Analyze how changes across different files relate to each other
4. Summarize the overall impact, then provide per-file summaries
5. Determine an appropriate commit topic that captures the essence of these changes
6. Output the topic as the first line, followed by a detailed summary

Format:
- First line: Brief topic (50 chars or less)
- Blank line
- Detailed summary of overall changes
- Per-file breakdown if changes are complex
