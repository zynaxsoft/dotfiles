Generate a patch message by analyzing stacked-git patch's changes.

Steps:
1. Run `stg email format $ARGUMENTS -G --stdout | tee` to retrieve all staged changes. Ignore every data about the commit message, only look at the diff that is after `diff --git` line.
2. Read each modified file in full to understand its purpose and context
3. Analyze how changes across different files relate to each other
4. Summarize the overall impact, then provide per-file summaries
5. Determine an appropriate commit topic that captures the essence of these changes
6. Output the topic as the first line, followed by a detailed summary

Format:
- First line: <type>: <subsystem>: <message title>
- Blank line
- Detailed summary of overall changes
- Per-file breakdown if changes are complex

IMPORTANT: You must only output the formated commit message only.
YOU MUST: Write the commit message in imperative Mood. Write as a command, not a description.
    e.g. “make xyzzy do frotz” instead of “[This patch] makes xyzzy do frotz” or “[I] changed xyzzy to do frotz”, as if you are giving orders to the codebase to change its behaviour.
