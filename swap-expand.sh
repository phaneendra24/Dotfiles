sudo swapoff -a

swapon --show

sudo fallocate -l 30G /swapfile

sudo chmod 600 /swapfile

sudo mkswap /swapfile

sudo swapon /swapfile
