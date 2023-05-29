# Just copy the two lines below and put them in custom_host.fish
set -gx MY_HOST_ICON 🚀
set -gx MY_HOST_ALIAS (hostname)

set custom_host_file ~/dotfiles/fish/configs/custom_host.fish
if test -f $custom_host_file
    source $custom_host_file
end
