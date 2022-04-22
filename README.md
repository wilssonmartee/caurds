# CAURDS

**Caurds** is a cards helper designed and programmed to handle user-created package descriptions (Pkgfile).

### NuTyX Xposed: [Repository](https://github.com/wilssonmartee/nutyx-xposed-pkg-x86_64)

## Features

- Build and install packages from source or binary.
- Pkgfile downloading from [NuTyX Xposed repository](https://github.com/wilssonmartee/nutyx-xposed-pkg-x86_64).
- Manage dependencies.
- Create packages from local Pkgfile.

## Installation

### Automatic

#### Step 1
**Run the script `install_caurds.sh`**
(as root)

`bash <(curl -L is.gd/installcaurds)`

### Manual

#### Step 1

First of all, you must adapt the cards configuration file to work correctly with caurds:

This action will not affect the normal operation of cards.

 `# vi /etc/cards.conf` where *vi* is your preferred text editor and *#* indicates that it should be run as root.

```sh
editor vi
#
# Default server URL
#url http://downloads.nutyx.org
dir /usr/ports/xposed
#
## For all the graphical applications and desktops
dir /var/lib/pkg/depot/gui-extra|http://downloads.nutyx.org
#
## For a minimal graphical interface
dir /var/lib/pkg/depot/gui|http://downloads.nutyx.org
#
## For all the console applications
dir /var/lib/pkg/depot/cli-extra|http://downloads.nutyx.org
#
## For a minimal console interface
dir /var/lib/pkg/depot/cli|http://downloads.nutyx.org
#
## Chroot system without reboot possibilities for a chroot
dir /var/lib/pkg/depot/base|http://downloads.nutyx.org
#
## Normaly you want to keep base and
base /var/lib/pkg/depot/base
#
#
## If you want to keep more collections remove comments below
# Adjust to your needs
#
# base /var/lib/pkg/depot/cli
# base /var/lib/pkg/depot/cli-extra
# base /var/lib/pkg/depot/gui
# base /var/lib/pkg/depot/gui-extra
# base /var/lib/pkg/depot/...         
#
group devel

```

*⚠️ this is a standard configuration file, if it has been modified before you must adapt it yourself.*

The `editor` variable indicates the text editor used by caurds to edit Pkgfiles at build time,

The `group devel` should be added to avoid dependency problems when compiling some packages.

The default `url` variable should be removed or commented out and added to the directories and added to the directory of each collection with a pipe.

The line `dir /usr/ports/xposed` must be added.

#### Step 2

**Upgrade system.**
(as root)

`cards sync`

`cards upgrade`

**Adapt the /etc/pkgmk.conf file**

```
PKGMK_IGNORE_REPO="no"
PKGMK_IGNORE_COLLECTION="no"
```

*⚠️ these variables should be set like this.*

**Create the required directories.**
(as root)

`mkdir -p /usr/ports/xposed/caurds/`

**Download required files.**
(as root)

`cd /usr/ports/xposed/caurds`

`curl -L is.gd/caurds > Pkgfile`

**Build caurds.**
(as root)

`pkgmk -d`

**Install caurds.**
(as root)

`cards install caurds`

**Sync and update.**
(as root)

`caurds sync`

`caurds upgrade`

## First Use

#### Sync and upgrade

- Use `caurds sync` to sync with remote [NuTyX Xposed repository](https://github.com/wilssonmartee/nutyx-xposed-pkg-x86_64).
- `caurds upgrade` shows the packages that must be re-builded and allows to update it.

## Examples of use

| Command                                  | Description                                                                                         |
| ---------------------------------------- | --------------------------------------------------------------------------------------------------- |
| `caurds`                                 | shows available options and version.                                                                |
| `caurds install <package>`               | install one <package>, build or compiled.                                                           |
| `caurds remove <package>`                | remove one package.                                                                                 |
| `caurds sync`                            | synchronize local and remote metadatas..                                                            |
| `caurds upgrade`                         | rebuild packages to the last version on xposed repo.                                                |
| `caurds -v`                              | show caurds version.                                                                                |

  *⚠️ before an `upgrade` it is recommended to `synchronize`.*

  
