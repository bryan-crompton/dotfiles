apt-mark showmanual # see all manually installed


apt-mark showmanual > ~/manual-packages.txt

sudo xargs apt install -y < ~/manual-packages.txt
