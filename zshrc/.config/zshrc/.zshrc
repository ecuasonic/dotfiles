# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zshrc/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export ZDOTDIR=$HOME/.config/zshrc
export SIZE="2560x1600"
export EDITOR="$(which nvim)"

# # Sets Control to be both escape and Control (set in i3 config)
# setxkbmap -option ctrl:nocaps
# xcape -e 'Control_L=Escape' -t 175

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

export OBSIDIAN_REST_API_KEY=cba463260884be711af064b64696bb0cb9559d47037e5db454b9dbb364a8b94c
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search zsh-vi-mode git-auto-fetch)
GIT_AUTO_FETCH_INTERVAL=900 # in seconds

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Organization
source $HOME/.config/zshrc/.zsh_alias
source $HOME/.config/zshrc/.zsh_commands

# Refresh rate to 60 if on laptop monitor
# If i have this on, then when I switch to hybrid, it swtiches back to integrated
#   and loses i3 resurrections with the save before hand
# save_power

# History configuration
HISTFILE=~/.zsh-history
SAVEHIST=2000
HISTSAVE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# Check window size after each command and, if necessary, update the values of LINES and COLUMNS.
# Removed CHECK_WINSIZE since it caused an error

# Enable extended globbing
setopt extended_glob

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:locus=01;32:quote=01'

# export TERM=tmux-256color

# Enable autocomplete for executables in the current directory
compdef _files ''

source ~/.config/powerlevel10k/powerlevel10k.zsh-theme

#----------------- FZF --------------------

# Set up fzf key bindings and fuzzy completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/.config/zshrc/fzf-git.sh

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
# export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ------ Bat (better cat) -----------

export BAT_THEME="tokyonight_night"

# ------------ Zoxide (better cd) -----------
eval "$(zoxide init zsh)"

alias cd="z"

# cx() { cd "$@" && l; }
# fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && l; }
# find() { echo "$(find . -type f -not -path '*/.*' | fzf)" | pbcopy }
# fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)" }

# To customize prompt, run `p10k configure` or edit ~/.config/zshrc/.p10k.zsh.
[[ ! -f ~/.config/zshrc/.p10k.zsh ]] || source ~/.config/zshrc/.p10k.zsh

# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# ~/.config/custom_scripts/stty.sh
# stty susp "^C"
# stty intr "^Z"

# man colors
export LESS_TERMCAP_mb=$'\e[1;31m'   # start blinking
export LESS_TERMCAP_md=$'\e[1;31m'   # start bold
export LESS_TERMCAP_me=$'\e[0m'      # end mode
export LESS_TERMCAP_se=$'\e[0m'      # end standout-mode
export LESS_TERMCAP_so=$'\e[01;1;33m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'      # end underline
export LESS_TERMCAP_us=$'\e[1;32m'   # begin underline
export GROFF_NO_SGR=1

# VIM keybindings
bindkey -v
bindkey -M vicmd '^[' undefined-key
bindkey -M vicmd 'yy' vi-yank-whole-line
bindkey -M vicmd 'H' vi-first-non-blank
bindkey -M vicmd 'L' vi-end-of-line
# bindkey -M vicmd > ~/dotfiles/zshrc/.config/zshrc/bindkey.txt

function zvm_config() {
    ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
}

# To customize prompt, run `p10k configure` or edit ~/dotfiles/zshrc/.config/zshrc/.p10k.zsh.
