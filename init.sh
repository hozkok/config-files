for dotfile in *.dotfile; do
    base_folder=$(dirname $(readlink -f $0))
    link_name=.${dotfile%.dotfile}
    ln -s $base_folder/$dotfile $HOME/$link_name
done
