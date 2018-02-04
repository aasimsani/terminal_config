git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
apt-get install tmux
if [ -f ~/.bashrc ];
    then
        echo ".bashrc exists. Appending"
        echo 'set -o vi' >> ~/.bashrc
else
        echo ".bashrc doesn't exist. Creating then appending"
        touch ~/.bashrc
        echo 'set -o vi' >> ~/.bashrc
fi

cp ./.vimrc ~/
