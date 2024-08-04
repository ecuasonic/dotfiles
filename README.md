Zephyrus G14 2022 had no issues.
MacBook Pro 2012 Issues:
	No wifi access and no wifi driver to begin with.
	Had to connect to ethernet to connect online.
	Network Controller: Broadcom Inc. BCM4331 802.11 a/b/g/n (rev 02)
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
sudo dnf install gh
gh auth login
git clone https://github.com/ecuasonic/dotfiles.git
sudo dnf install stow git-delta
# stow everything and copy important config files, such as:
#   .gitconfig .zshenv

# -------------------------------------------------------------------
# Install needed programs
# -------------------------------------------------------------------
sudo dnf install alacritty luarocks btop zsh zoxide

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
sudo dnf install rofi polybar picom nitrogen xrandr xset cargo brightnessctl bat
cargo install xidlehook --bins
# Update /etc/X11/xorg.conf.d/90-touchpad.conf
# Get background, open up nitrogen, then select it
# Update scripts if needed

# -------------------------------------------------------------------
# Install xcape for ctrl/esc
# -------------------------------------------------------------------
sudo dnf install git gcc make pkgconfig libX11-devel libXtst-devel libXi-devel
git clone https://github.com/alols/xcape.git
cd xcape
make
sudo make install

# -------------------------------------------------------------------
# Install tmux plugin manager
# -------------------------------------------------------------------
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    prefix + I: To install plugins

# -------------------------------------------------------------------
# Power management
# -------------------------------------------------------------------
sudo dnf install tlp
```
