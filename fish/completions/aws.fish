# https://dev.classmethod.jp/articles/fish-shell-aws-cli-complete/
complete -c aws -f -a '(
    begin
        set -lx COMP_SHELL fish
        set -lx COMP_LINE (commandline)
        aws_completer
    end
)'
