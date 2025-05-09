Zephyrus G14 2022 had no issues. <br>
MacBook Pro 2012 Issues: <br>
- No wifi access and no wifi driver to begin with.
- Had to connect to ethernet to connect online.
- Network Controller: Broadcom Inc. BCM4331 802.11 a/b/g/n (rev 02)
```sh
sudo dnf update

# Enable access to both the **free** and **nonfree** repository, use the following command:
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# -------------------------------------------------------------------
# If no Wifi, then do the following:
# -------------------------------------------------------------------
sudo dnf install broadcom-wl
# then restart PC.
sudo modprobe wl
# if modprobe: FATAL: Module wl not found in directory
#   then:
sudo depmod -a
# and restart again.
sudo modprobe -r wl
sudo modprobe wl

# -------------------------------------------------------------------
# Install gh to get dotfiles online
# -------------------------------------------------------------------
sudo dnf install gh git
gh auth login
git clone https://github.com/ecuasonic/dotfiles.git
sudo dnf install stow git-delta
# stow everything and copy important config files, such as:
#   .gitconfig .zshenv
# Also unlink alacritty from dotfiles, so that font change doesn't affect repo.
# dont forget to make scripts executable
# -------------------------------------------------------------------
# Install needed programs
# -------------------------------------------------------------------
sudo dnf install kitty luarocks btop zsh zoxide shellcheck
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# -------------------------------------------------------------------
# Set up ohmyzsh and zsh plugins
# -------------------------------------------------------------------
chsh -s $(which zsh)
# then logout and log back in
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# -------------------------------------------------------------------
# Install programs for i3
# -------------------------------------------------------------------
sudo dnf install rofi polybar picom nitrogen xrandr xset cargo brightnessctl bat python3-pip scrot i3-gaps
# sudo pacman -S xorg-server xorg-xinit
bat cache --build
cargo install xidlehook --bins
cd; mkdir local; cd local; git clone https://github.com/JonnyHaystack/i3-resurrect.git
pip3 install --user --upgrade i3-resurrect
# Update /etc/X11/xorg.conf.d/90-touchpad.conf
# Get background, open up nitrogen, then select it
# Update scripts if needed

# -------------------------------------------------------------------
# Firefox settings
# -------------------------------------------------------------------


# -------------------------------------------------------------------
# Install xcape for ctrl/esc
# -------------------------------------------------------------------
sudo dnf install git gcc make pkgconfig libX11-devel libXtst-devel libXi-devel
cd ~/local;
git clone https://github.com/alols/xcape.git
cd xcape
make
sudo make install

# -------------------------------------------------------------------
# Install tmux plugin manager
# -------------------------------------------------------------------
sudo dnf install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# prefix + I: To install plugins

# -------------------------------------------------------------------
# Power management
# -------------------------------------------------------------------
sudo dnf install tlp
# /etc/tlp.conf L0152: SCHED_POWERSAVE_ON_AC="1"
# /etc/tlp.conf L0254: AHCI_RUNTIM_PM_ON_AC="auto"
# /etc/tlp.conf L0349: RUNTIME_PM_ONAC="auto"

# -------------------------------------------------------------------
# GCC and Nvim "go-to-file" gf
# -------------------------------------------------------------------
# So that gcc knows where to look for, add to .zshrc:
# export C_INCLUDE_PATH=/home/ecuas/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/avr/include:$C_INCLUDE_PATH
# So that nvim gf works, add to init.lua
# vim.o.path = vim.o.path .. ",/home/ecuas/.arduino15/packages/arduino/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/avr/include/**"

# -------------------------------------------------------------------
# Where G14 and MBP2012 differ
# -------------------------------------------------------------------
# i3/.config/i3/config                      : L5, L15
# nitrogen/.config/nitrogen/bg-saved.cfg    : L2
# nitrogen/.config/nitrogen/nitrogen.cfg    : L2
# polybar/.config/polybar/hack/bars.ini     : L118, L161
```
