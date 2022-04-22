#!/bin/bash

if ! [ $(id -u) = 0 ]; then
   echo "ERROR! Use a root account to install Caurds." >&2
   exit 1
fi

cards_config=$(cards config)

if [[ $cards_config == *"testing/base"* ]] ; then
  nutyx_version="testing"
else
  nutyx_version="rolling"
fi

cards sync && cards upgrade
(pkginfo -i | grep " git ") || cards install git

cd /tmp

curl -O https://raw.githubusercontent.com/wilssonmartee/caurds/main/cards.conf
curl -O https://raw.githubusercontent.com/wilssonmartee/caurds/main/pkgmk.conf

sed -i 's/rolling/'${nutyx_version}'/g' /tmp/cards.conf

mv -f /etc/cards.conf /etc/cards.conf.backup
mv -f /etc/pkgmk.conf /etc/pkgmk.conf.backup
cp -f /tmp/cards.conf /etc/cards.conf
cp -f /tmp/pkgmk.conf /etc/pkgmk.conf

mkdir -p /usr/ports/xposed/caurds
cd /usr/ports/xposed/caurds
curl -O https://raw.githubusercontent.com/wilssonmartee/nutyx-xposed-pkg-x86_64/main/caurds/Pkgfile

pkgmk -d
cards sync && cards upgrade
cards install caurds
caurds sync && echo -e "\n\n***** Caurds installed!\n\n"
caurds --help

