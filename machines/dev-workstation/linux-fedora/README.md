# fedora Setup
This setup manual assumes you have installed the main fedora workstation using *GNOME* as DE.
Other fedora spins might differ from this setup.
The setup has been done using fedora 35 with kernel version 5.14.17-301.fc35.x86_64.  
You can find your current kernel version by executing `uname -r`.

## Installation of relevant packages / apps.
Usually fedora comes preinstalled with various packages. Therefore, this is just a precaution
you don't miss out on the fun. :D

### Basics
```shell
dnf check-update                                                                                              
sudo dnf -y install git-core\
make\
wget\
curl\
keepassxc\
util-linux-user
```

Afterwards upgrade all preinstalled packages. If you feel like cleaning up and removing some of the
preinstalled packages, it is recommended to do so before upgrading. Below you can find such example.

```shell
#sudo dnf -y remove nano @libreoffice libreoffice* rhythmbox gnome-maps gnome-tour gnome-weather
sudo dnf -y upgrade
```

### Docker-Compose / Podman
Execute the following commands to install `docker-compose`, `podman` and ensure docker endpoints
are handled by podman.

```shell
sudo dnf -y install docker-compose podman podman-docker
```

Start all related services and disable docker emulator warnings.

```shell
sudo touch /etc/containers/nodocker
sudo systemctl start podman.socket
sudo systemctl enable podman.socket
sudo systemctl start podman.service
sudo systemctl enable podman.service
sudo systemctl --user enable podman.socket
sudo systemctl --user start podman.socket
sudo systemctl --user start podman.service
sudo systemctl --user enable podman.service
```

### Microsoft related apps / tools
MS Teams can be installed using `flatpak`.

```shell
flatpak install -y com.microsoft.teams
```

Installing *Powershell* needs you to import a new *dnf* repository.

```shell
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo
dnf check-update
sudo dnf -y install powershell
```

If you would like to install *MS Edge* Browser or *VSCode*, you need to execute similar commands compared to *Powershell*.

```shell
# MS Edge Browser
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
dnf check-update
sudo dnf -y install microsoft-edge-stable

# VSCode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf -y install code
sudo xdg-mime default code.desktop text/plain    # <- set vscode as default editor for text files
```

### Install VPN
Setting up the VPN tool might become hacky. This depends heavily on whether your current DNS config is functioning.
You can test your local DNS config by connecting to your home's wifi or GUESTWLAN at the company site and executing
`ping extern.mdctec.com`. If this command states something like "*Name or service not known*", your `/etc/resolv.conf`
might be corrupted.  
To fix it, follow the steps below:

1. Ensure `/etc/resolv.conf` is symlink rather than a stand-alone file.
2. If so, remove the symlink by typing `sudo /bin/rm -f /etc/resolv.conf`.
3. Create or edit `/etc/NetworkManager/conf.d/dns.conf` and add:
    ```
    [main]
    dns=none
    main.systemd-resolved=false
    ```
4. Restart the NetworkManager: `sudo systemctl restart NetworkManager`.
5. Check if the issue is resolved by executing the `ping` command above.
6. If you still have issues accessing the VPN server, populate a temporary `/etc/reolv.conf` by executing
`sudo systemctl restart systemd-resolved && sudo systemctl stop systemd-resolved`.
7. If the issue still persists, create a new `/etc/reolv.conf` or overwrite the current temporary one with the following
contents:
    ```shell
    search domain.name
    nameserver 192.168.8.102
    nameserver 192.168.8.100
    nameserver 8.8.8.8
    nameserver 1.1.1.1
    nameserver 1.0.0.1
    ```
8. Ensure NetworkManager does not overwrite your config after restarting by adding th following to
`/etc/NetworkManager/NetworkManager.conf`:
    ```
    [main]
    dns=none
    systemd-resolved=false
    ```
9. Reboot.

This should work in most cases, and you can continue afterwards with installing *NetExtender*.

1. Download the latest installer form the
[Sonicwall website](https://www.sonicwall.com/products/remote-access/vpn-clients/).
2. Install it from the commandline by executing `sudo dnf -y install <downloaded package name>.rpm`.

Alternatively you can download and install it with the help of this command.
**Before using this command, ensure that the latest installer link has been inserted!**

```shell
wget https://software.sonicwall.com/NetExtender/NetExtender.Linux-10.2.828-1.x86.64.rpm -o NetExtender.rpm && \
sudo dnf -y install NetExtender.rpm
```

Finally, add a handy alias for connecting to the vpn to your shell configuration.

```shell
alias connectVPN="netExtender -u YOURUSERNAME -p YOURPASSWORD -d mdctec.local extern.mdctec.com:4433 &"
```

### Install Jetbrains IDE
1. Download the installer archive from jetbrains: https://www.jetbrains.com/de-de/toolbox-app/download/download-thanks.html?platform=linux
2. Extract the downloaded archive by executing `tar -xzvf <downloaded archive name>.tar.gz`.
3. Navigate into the extracted archive and ensure the binary file has execute permissions. If not, grant them by
executing `sudo chmod +x jetbrains-toolbox`.
4. Copy the binary file into a directory included in `PATH`. For example, 
`sudo /bin/cp -f jetbrains-toolbox /usr/local/bin`
5. The previous steps enable you to run *Jetbrains Toolbox* from your terminal by simply typing `jetbrains-toolbox`.
6. After starting toolbox, sign in to your Jetbrains account and downloaded the latest your preferred IDE.
7. If you want to be able to start your IDEs from the terminal as well, you have to specify a path where the toolbox
shall create startup commands. (Toolbox Settings -> Tools -> Generate shell scripts)

## Help
### DELL DisplayLink docking station lacks features
For example, your screen stays blank and is not noticed by the OS.
This can be fixed by installing the official drivers.

1. Execute the following commands to satisfy dependencies and generate and import self-signing key to sign the driver,
in case you're using your computer with *Secure Boot* enabled.
    ```shell
    cd ~/Downloads/
    sudo dnf -y install libdrm-devel.x86_64 libdrm.x86_64 kernel-devel-$(uname -r)
    openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform DER -out MOK.der -nodes -days 36500 -subj "/CN=Displaylink/"
    sudo mokutil --import MOK.der
    reboot
    ```
2. Clone the `evdi` git repository from GitHub and build / install the driver wrapper.
   ```shell
   git clone https://github.com/DisplayLink/evdi.git
   cd evdi
   make
   cd modules
   sudo make install_dkms
   ```
3. Sign the `evdi` package. (This is only necessary if you have *Secure Boot* enabled.)
   ```shell
   cd ../..
   unxz $(modinfo -n evdi)
   /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 ./MOK.priv ./MOK.der /lib/modules/$(uname -r)/extra/evdi.ko
   xz -f /lib/modules/$(uname -r)/extra/evdi.ko
   ```
4. Download the latest displaylink driver rpm package from https://github.com/displaylink-rpm/displaylink-rpm.
5. Install it by executing `sudo dnf -y install <downloaded diplaylink driver package name>.rpm`.
