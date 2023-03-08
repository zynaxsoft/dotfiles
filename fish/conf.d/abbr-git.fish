if status is-interactive
    function __add_abbr
        abbr -a ga "git add -i"
        abbr -a gaa "git add -A"
        abbr -a ggpush "git push origin HEAD"
        abbr -a gl "git pull"
        abbr -a ggpull "git pull origin HEAD"

        abbr -a gc "git commit -v"
        abbr -a gc! "git commit -v --amend"
        abbr -a gcn! "git commit -v --no-edit --amend"
        abbr -a gca "git commit -v -a"
        abbr -a gca! "git commit -v -a --amend"
        abbr -a gcan! "git commit -v -a --no-edit --amend"
        abbr -a gcans! "git commit -v -a -s --no-edit --amend"
        abbr -a gcam "git commit -a -m"
        abbr -a gcsm "git commit -s -m"
        abbr -a gcas "git commit -a -s"
        abbr -a gcasm "git commit -a -s -m"

        abbr -a gco "git checkout"
        abbr -a gcb "git checkout -b"
        # abbr -a gcof "git checkout $(git_feature_prepend)/"
        abbr -a gd "git diff"
        abbr -a gds "git diff --staged"
        abbr -a gdca "git diff --cached"

        alias gdct 'git describe --tags $(git rev-list --tags --max-count=1)'

        abbr -a gf "git fetch"
        abbr -a gfa "git fetch --all --prune"

        abbr -a glg "git log --stat"
        abbr -a glgp "git log --stat -p"
        abbr -a glgg "git log --graph"
        abbr -a glgga "git log --graph --decorate --all"
        abbr -a glgm "git log --graph --max-count=10"
        abbr -a glo "git log --oneline --decorate"
        abbr -a glol "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
        abbr -a glols "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat"
        abbr -a glod "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"
        abbr -a glods "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
        abbr -a glola "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all"
        abbr -a glog "git log --oneline --decorate --graph"
        abbr -a gloga "git log --oneline --decorate --graph --all"

# grb: git rebase
        abbr -a grb "git rebase"
        abbr -a grba "git rebase --abort"
        abbr -a grbc "git rebase --continue"
        abbr -a grbi "git rebase -i"

        abbr -a gst "git status"

# gsw: git switch
        abbr -a gsw "git switch"
        abbr -a gswc "git switch -c"

# gwch: git whatchanged
        abbr -a gwch "git whatchanged -p --abbrev-commit --pretty=medium"
    end
    __add_abbr
    functions -e __add_abbr
end
