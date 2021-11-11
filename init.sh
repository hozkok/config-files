SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

for dotfile in *.dotfile; do
    base_folder=$(dirname $(readlink -f $0))
    link_name=.${dotfile%.dotfile}
    ln -s $base_folder/$dotfile $HOME/$link_name
done

ln -s $SCRIPT_DIR/init.vim $HOME/.config/nvim/init.vim
ln -s $SCRIPT_DIR/hozkok.zsh-theme $HOME/.oh-my-zsh/custom/themes/hozkok.zsh-theme
