#!/bin/bash

set -e

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

function maybe_create_link {
    config_loc=$1
    link_loc=$2
    link_loc_dir=$(dirname $link_loc)
    [[ -d $link_loc_dir ]] || mkdir -p $link_loc_dir
    if [[ -h $link_loc ]]; then
        echo "$link_loc already initialized, skipping"
        return
    elif [[ -f $link_loc ]]; then
        echo "moving ${link_loc} to ${link_loc}-old"
        mv ${link_loc} ${link_loc}-old
    fi
    ln -s $config_loc $link_loc
    echo "created symlink ${link_loc} -> ${config_loc}"
}

function init_nvim {
    nvim_config_dir=$HOME/.config/nvim
    nvim_data_dir=$HOME/.local/share/nvim
    maybe_create_link $SCRIPT_DIR/init.lua $nvim_config_dir/init.lua
    maybe_create_link $SCRIPT_DIR/coc-settings.json $nvim_config_dir/coc-settings.json
    maybe_create_link $SCRIPT_DIR/plugins.lua $nvim_config_dir/lua/plugins.lua
    packer_dir=$nvim_data_dir/site/pack/packer/start/packer.nvim
    if [[ ! -d $packer_dir ]]; then
        packer_repo=https://github.com/wbthomason/packer.nvim
        git clone --depth 1 $packer_repo $packer_dir
    fi
}

function init_git {
    maybe_create_link $SCRIPT_DIR/gitconfig.dotfile $HOME/.gitconfig
}

function init_zsh {
    if [[ ! -d $HOME/.oh-my-zsh ]]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
    maybe_create_link $SCRIPT_DIR/zshrc.dotfile $HOME/.zshrc
    maybe_create_link $SCRIPT_DIR/.zprofile $HOME/.zprofile
    maybe_create_link $SCRIPT_DIR/hozkok.zsh-theme $HOME/.oh-my-zsh/custom/themes/hozkok.zsh-theme
}

function init_tmux {
    maybe_create_link $SCRIPT_DIR/tmux.conf.dotfile $HOME/.tmux.conf
}

init_git
init_zsh
init_nvim
init_tmux
