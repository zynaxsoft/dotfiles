# https://github.com/tsub/fish-fzf-git-recent-branch/blob/master/functions/fzf_git_recent_branch.fish
function fzf_git_recent_branch -d "Efficient fish keybinding for fzf with git branch"
    set -l cmd (builtin string split -r -m 1 " " (commandline))
    eval "git branch --format='%(refname:short)' \
        --all --sort=-authordate | fzf --query \"$cmd[-1]\"" \
        | read -z select

    if test -n $select
    set -l branch (builtin string trim --left --chars='* ' "$select")
    set -l branch (builtin string shorten -N $branch | tr -d '\n')
    commandline -i $branch
    end

    commandline -f repaint
end
