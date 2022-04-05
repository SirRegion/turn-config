# Common setup of an Ubuntu server machine

- [Common setup of an Ubuntu server machine](#common-setup-of-an-ubuntu-server-machine)
  - [Install latest Git from ppa](#install-latest-git-from-ppa)
  - [Setup the infrastructure repository](#setup-the-infrastructure-repository)

## Install latest Git from PPA repository

```shell
add-apt-repository ppa:git-core/ppa
apt-get update
apt-get install git
```

## Set up the Mdctec infrastructure repository

1. Create an empty git repository

```shell
mkdir /etc/mtec && cd $_

# setup permissions. this will allow all users of group 'mtec' to work with this dir
chgrp mtec . && chmod g+s .

# setup git repository
mkdir infrastructure && cd $_
git init
```

2. Enable the sparse-checkout feature

```shell
git config core.sparseCheckout true
```

```shell
git sparse-checkout init
```

3. Specify what parts of the repo should get cloned

```shell
#replace <FOLDER> with the director corresponding to your machine
git sparse-checkout set /machines/<FOLDER>/ /scripts/
```

4. Enable credential Store

```shell
git config credential.helper 'store --file /etc/mtec/.git-credentials'
```

1. Add & configure origin

```shell
git remote add -f origin http://MTEC_MACHINE:glpat-Y77UFppq2x9TWzyeN5cb@gitlab.mdctec.com/mdctec-developers/internal/infrastructure.git
git branch --set-upstream-to=origin/master master
```

7. Checkout config files

```shell
git pull
```

8. Create a link for convenience

```shell
ln -s /etc/mtec/infrastructure/machines/dev.mdctec.local dev-infrastructure
```
