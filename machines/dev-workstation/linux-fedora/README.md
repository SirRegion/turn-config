# fedora setup

This setup manual assumes you have installed the main fedora workstation using *GNOME* as DE. Other fedora
spins might differ from this setup. The setup has been done using fedora 35 with kernel version
5.14.17-301.fc35.x86_64.  
You can find your current kernel version by executing `uname -r`.

## Installation of relevant packages / apps.

Usually fedora comes preinstalled with various packages. Therefore, this is just a precaution you don't miss
out on the fun. :D

### Enhance `dnf` installation times

Update / installation times can be tremendously fastened up by configuring `dnf` to use fast mirrors. In order
to do this, you need to edit `/etc/dnf/dnf.conf`.

```shell
cat << EOF >> /etc/dnf/dnf.conf
fastestmirror=true
deltarpm=true
EOF
```

### Enable *rpmfusion* repository for third party packages

```shell
# Free repository
sudo dnf install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

# Nonfree repository
sudo dnf install \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

### Enable *flathub* base repository

```shell
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

You most likely need both repositories to be able to install all relevant packages.

### Basics

```shell
dnf check-update                                                                                              
sudo dnf -y install git-core\
make\
wget\
curl\
keepassxc\
util-linux-user\
remmina
```

Afterwards upgrade all preinstalled packages. If you feel like cleaning up and removing some of the
preinstalled packages, it is recommended to do so before upgrading. Below you can find such example.

```shell
#sudo dnf -y remove nano @libreoffice libreoffice* rhythmbox gnome-maps gnome-tour gnome-weather
sudo dnf -y upgrade
```

### Install MS core fonts for support of MS (web-)apps

```shell
wget https://sourceforge.net/projects/mscorefonts2/files/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm/download -O msttcore-fonts-installer-2.6-1.noarch.rpm
sudo dnf -y install msttcore-fonts-installer-2.6-1.noarch.rpm
```

### Docker-Compose / Podman

Execute the following commands to install `docker-compose`, `podman` and ensure docker endpoints are handled
by podman.

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

#### MS Teams

MS Teams has to be downloaded from the
[official Microsoft website](https://www.microsoft.com/de-de/microsoft-teams/download-app). It can be
installed using *dnf* as well. Therefore, you need to navigate into the directory where you have downloaded
the rpm package and execute `sudo dnf install <Teams rpm package name>.rpm`.  
*NOTE:* Since this is a Electron app, it might be sufficient to stick to the web app.

Using the browser version of Teams is recommended if you would like to stick to *Wayland* as window server and
*Pipewire* as audio server. The following steps enable you to do so:

```shell
# Check if Pipewire is enabled and running
systemctl --user status pipewire.service
# if not
systemctl --user start pipewire.service
systemctl --user enable pipewire.service

# Make sure xdg-desktop-portal is installed
sudo dnf list installed | grep xdg-desktop-portal
# if not
sudo dnf -y install xdg-desktop-portal

# Install chromium-freeworld as it is built with all freeworld codecs and is, therefore, most suitable to run Teams without compatibility issues
sudo dnf -y install chromium-freeworld
```

After executing the proper shell commands, open *Chromium* and navigate to [chrome://flags](chrome://flags),
search for *WebRTC PipeWire support* and enable it. Restart the browser to apply the changes. Now you can
start using teams by simply navigating to [https://teams.microsoft.com](https://teams.microsoft.com) in
*Chromium (Freeworld)*.

#### Powershell

Installing *Powershell* needs you to import a new *dnf* repository.

```shell
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo
dnf check-update
sudo dnf -y install powershell
```

#### MS Edge Browser / VSCode

If you would like to install *MS Edge* Browser or *VSCode*, you need to execute similar commands compared to *
Powershell*.

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

#### MS OneDrive

OneDrive is only available as cli tool, but it monitors your files just like you are using it with the Windows
OS. This tool is available through the fedora *updates* repository.

```shell
# Install onedrive
sudo dnf -y install onedrive

# Configure for the first time
# NOTE: This prompts you to open a url where you will be asked to sign in, do so and you'll be redirected to a blank screen. Copy the blank screen's uri and paste it into your terminal.
onedrive

# Start syncing / monitoring your files
onedrive --monitor

# Get help / print all available commands
onedrive --help
```

All config files for `onedrive` will be placed under `~/.config/onedrive` and can be edited at will.

### Install VPN

Setting up the VPN tool might become hacky. This depends heavily on whether your current DNS config is
functioning. You can test your local DNS config by connecting to your home's wifi or GUESTWLAN at the company
site and executing `ping extern.mdctec.com`. If this command states something like 
"*Name or service not known*", your `/etc/resolv.conf` might be corrupted.  
To fix it, follow the steps below:

1. Ensure `/etc/resolv.conf` is symlink rather than a stand-alone file.
2. Ensure `/etc/systemd/resolved.conf.d/00-custom.conf` exists and contains the config below.
   ```text
   [Resolve]
   DNSoverTLS=yes
   ```
3. Ensure every default entry in `/etc/systemd/resolved.conf` is commented.
4. If you had to edit one of the files in step 2 or 3, run:
   `sudo systemctl restart systemd-resolved.service; sudo systemctl restart NetworkManager.service`
5. Check `resolvctl --no-pager status`. If it states something like below, you should be good to go.
   ```text
   Link 3 (enp0s20f0u2u3i5)
      Current Scopes: DNS LLMNR/IPv4 LLMNR/IPv6
         Protocols: +DefaultRoute +LLMNR +mDNS -DNSOverTLS DNSSEC=no/unsupported
   Current DNS Server: 192.168.8.102
       DNS Servers: 192.168.8.102 192.168.8.100
        DNS Domain: mdctec.local
   ```
   If not, the issue most likely lies within `NetworkManager`.
6. Ensure there is **no** `/etc/NetworkManager/conf.d/dns.conf` or it does **not** contain:
    ```text
    [main]
    dns=none
    main.systemd-resolved=false
    ```
7. Ensure NetworkManager does not overwrite your config after restarting by adding the following to
    `/etc/NetworkManager/NetworkManager.conf`:
     ```
     [main]
     dns=none
     #systemd-resolved=false
     #plugins=keyfile,ifcfg-rh
     ```
8. Reboot.
9. *Optionally* migrate ifcfg network files to keyfiles to help keep your system ready for future updates:
   `sudo nmcli conn migrate`

This should work in most cases and lets you continue to install *NetExtender*.

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
# NOTE: You may want to remove the background operator, in case the certificate is unknown and needs to be confirmed manually.
alias connectVPN="netExtender -u YOURUSERNAME -p YOURPASSWORD -d mdctec.local extern.mdctec.com:4433 &"
```

### Install Jetbrains IDE

1. Download the installer archive from
   jetbrains: https://www.jetbrains.com/de-de/toolbox-app/download/download-thanks.html?platform=linux
2. Extract the downloaded archive by executing `tar -xzvf <downloaded archive name>.tar.gz`.
3. Navigate into the extracted archive and ensure the binary file has execute permissions. If not, grant them
   by executing `sudo chmod +x jetbrains-toolbox`.
4. Copy the binary file into a directory included in `PATH`. For example,
   `sudo /bin/cp -f jetbrains-toolbox /usr/local/bin`
5. The previous steps enable you to run *Jetbrains Toolbox* from your terminal by simply
   typing `sudo jetbrains-toolbox`.
6. After starting toolbox, sign in to your Jetbrains account and downloaded the latest preferred IDE.
7. If you want to be able to start your IDEs from the terminal as well, you have to specify a path where
   toolbox shall create startup commands. (Toolbox Settings -> Tools -> Generate shell scripts)
    1. Create a `bin` folder in your user's `home` directory and symlink it
       to `/usr/local/bin`: `mkdir /home/YOURUSERNAME/bin; sudo ln -s /home/YOURUSERNAME/bin /usr/local/bin`
    2. The folder where toolbox generates your start scripts need to be `/home/YOURUSERNAME/bin`.

## Help

### DELL DisplayLink docking station lacks features

For example, your screen stays blank and is not noticed by the OS. This can be fixed by installing the
official drivers.

1. Execute the following commands to satisfy dependencies and generate and import self-signing key to sign the
   driver. This is only mandatory, in case you're using your computer with *Secure Boot* enabled.
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
   sudo make
   cd module
   sudo make install_dkms
   ```
3. Sign the `evdi` package. (This is only necessary if you have *Secure Boot* enabled.)
   ```shell
   cd ../..
   sudo unxz $(modinfo -n evdi)
   sudo /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 ./MOK.priv ./MOK.der /lib/modules/$(uname -r)/extra/evdi.ko
   sudo xz -f /lib/modules/$(uname -r)/extra/evdi.ko
   ```
4. Download the latest displaylink driver rpm package from https://github.com/displaylink-rpm/displaylink-rpm
5. Install it by executing `sudo dnf -y install <downloaded diplaylink driver package name>.rpm`.

### Resolve mouse flickering when using *GNOME on XORG* with Intel Graphics

* Create `/etc/X11/xorg.conf.d/20-intel.conf`.
* Enter the following:
  ```                                                                                                         
  Section "Device"                                                                                            
    Identifier  "Intel Graphics"                                                                               
    Driver      "intel"                                                                                        
  EndSection                                                                                                  
  ``` 

### Resolve missing kernel in grub2 config

This might be caused due to missing kernel dependencies and can be resolved using `dnf`.

1. Check which kernel grubby has detected so far: `sudo grubby --info=ALL`
2. Check if dnf finds any issues regarding installed packages, e.g. duplicates, etc.: `sudo dnf check`
3. If there are problems detected, ensure to resolve them, e.g. remove
   duplicates: `sudo dnf remove --duplicates`
4. Install missing kernel dependencies: `sudo dnf install "kernel*"`
5. Use the grubby command from the first step to evaluate if all required kernel packages have been
   recognized.

NOTE: `kernel-debug-*` can be removed again, if everything works as expected and there is no further need for
them.

### Prevent laptop from entering airplane mode when opening the lid

1. Open *GNOME Tweaks*. In the *General* tab, disable *Suspend when laptop lid is closed*.
2. Edit `/etc/systemd/logind.conf` by typing: `sudo -e /etc/systemd/logind.conf`.
    1. Edit the following entries:
   ```shell
   HandleLidSwitch=ignore
   HandleLidSwitchExternalPower=ignore
   HandleLidSwitchDocked=ignore
   LidSwitchIgnoreInhibited=no
   ```
3. Restart systemd-logind (NOTE: You will be logged out.): `systemctl restart systemd-logind`
4. Reboot.
5. Try closing and opening the lid again. If the issue persists, proceed with the following steps.
6. While the lid is closed, enter `sudo journalctl -f` to get *live* logs. Open the lid again and check the
   logs for unknown button pressed, e.g. **e058** and **e057**.
7. Reassign these keys to just suspending the screen, rather than also entering airplane mode:
   `sudo setkeycodes e058 245 e057 245`
8. If this hack resolved the issue, you need to make it permanent by adding a systemd unit file.
    1. Create a new file and edit it: `sudo -e /etc/systemd/system/lid-closed.service`.
    2. Paste the following into this file and save it:
   ```shell
   [Unit]
   Description=Prevent laptop from entering airplane mode when opening the lid

   [Service]
   ExecStart=/usr/bin/setkeycodes e058 245 e057 245

   [Install]
   WantedBy=multi-user.target
   ```
    3. Reload systemd services: `sudo systemctl daemon-reload`.
    4. Start and enable the service to make it being executed automatically after rebooting / power-off:
       `sudo systemctl start lid-closed && sudo systemctl enable lid-closed`
9. Reboot again and verify that the issue is resolved now.

### Wifi disconnects randomly when using a Realtek RTL8822BE/CE
1. Check if you're really using a Realtek card: `lspci | grep -i wireless`
2. Clone lwfinger/rtw88 repo: `git clone https://github.com/lwfinger/rtw88`
3. Enter the repo and run:
   1. `make`
   2. `sudo make install`

NOTE: If you are using a non Realtek wifi card, installing `akmod-wl` from the previously enabled RPMFusion
non-free repo might resolve this issue as well. (`sudo dnf install akmod-wl`)
