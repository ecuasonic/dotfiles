sudo dnf update
# Enable access to both the free and nonfree repositories:
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-       release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/ rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Install needed programs:
sudo dnf install @base-x i3 stow nvim
sudo dnf install gh git git-delta
sudo dnf install kitty luarocks btop zsh zoxide shellcheck

# Install programs for i3:
sudo dnf install rofi polybar picom nitrogen xrandr xset cargo brightnessctl bat python3-pip scrot i3-gaps
bat cache --build
cargo install xidlehook --bins
cd; mkdir local; cd local; git clone https://github.com/JonnyHaystack/i3-        resurrect.git
pip3 install --user --upgrade i3-resurrect
# Update /etc/X11/xorg.conf.d/90-touchpad.conf
# Get background, open up nitrogen, then select it.
# Update scripts if necessary.

# Install fonts:
# Copy /dotfiles/fonts/ into ~/.local/share/fonts/

# Install xcape for ctrl/esc:
sudo dnf install gcc make pkgconfig libX11-devel libXtst-devel libXi-devel
cd ~/local
git clone https://github.com/alols/xcape.git                                     
cd xcape                                                                           make                                                                             
sudo make install

# Install tmux plugin manager
sudo dnf install tmux
git clone https:/github.com/tmux-plugins/tmp ~/.tmux/plugins/tpm
# prefix + I: To install plugins

# Power management:
sudo dnf install tlp

# Set up ohmyzsh and zsh plugins:
chsh -s $(which zsh)
# then logout and log back in, and run zsh.sh
