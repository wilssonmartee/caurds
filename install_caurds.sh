#!/bin/bash

cards_config=$(cards config)

if [[ $cards_config == *"testing/base"* ]] ; then
  nutyx_version="testing"
else
  nutyx_version="rolling"
fi

cd /tmp

curl -O https://raw.githubusercontent.com/wilssonmartee/caurds/main/cards.conf
curl -O https://raw.githubusercontent.com/wilssonmartee/caurds/main/pkgmk.conf

sed -i 's/rolling/'${nutyx_version}'/g' /tmp/cards.conf

cp -f --backup /tmp/cards.conf /etc/cards.conf
cp -f --backup /tmp/pkgmk.conf /etc/pkgmk.conf

cards sync && cards upgrade
(pkginfo -i | grep " git ") || cards install git

mkdir -p /usr/share/ports/xposed/caurds
cd /usr/share/ports/xposed/caurds
curl -O https://raw.githubusercontent.com/wilssonmartee/nutyx-xposed-pkg-x86_64/main/caurds/Pkgfile

pkgmk -d
cards install caurds
caurds sync
caurds upgrade

echo "***** Caurds installed!"

