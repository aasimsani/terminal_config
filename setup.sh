git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
apt-get install tmux
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

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
cp ./.tmux.conf ~/
