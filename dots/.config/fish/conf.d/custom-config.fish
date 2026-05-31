#    _               _              
#   | |__   __ _ ___| |__  _ __ ___ 
#   | '_ \ / _` / __| '_ \| '__/ __|
#  _| |_) | (_| \__ \ | | | | | (__ 
# (_)_.__/ \__,_|___/_| |_|_|  \___|
# 

# Fish doesn't need the interactive check - it's always interactive when sourcing config

alias ls='ls --color=auto'
alias grep='grep --color=auto'
# Fish uses fish_prompt function instead of PS1
# PS1='[\u@\h \W]\$ '  # Not needed in fish

# Convert most.sh logic to fish
if command -v most >/dev/null 2>&1
    set -gx PAGER most
end

# NVM - fish-nvm is installed and will be loaded automatically from ~/.config/fish/conf.d/nvm.fish
set -gx NVM_DIR "$HOME/.nvm"

# Conda initialization is handled by conda init fish
# The conda.fish file is automatically loaded from ~/miniconda3/etc/fish/conf.d/conda.fish

# Add local bin and cargo bin to PATH
set -gx PATH "/home/bilal/.local/bin/:$PATH"
# Add cargo bin (equivalent of sourcing ~/.cargo/env)
if not contains "$HOME/.cargo/bin" $PATH
    set -gx PATH "$HOME/.cargo/bin:$PATH"
end

# Secrets live in secrets.local.fish (backed up on Seagate, not committed)
if test -f ~/.config/fish/conf.d/secrets.local.fish
    source ~/.config/fish/conf.d/secrets.local.fish
end

set -gx PATH $PATH:/home/bilal/.spicetify/

# To allow simulated devices to function without running out of memory
set -gx NODE_OPTIONS "--max-old-space-size=12192"

# Unlimited fish history
set -gx fish_history unlimited

alias nvim="ESLINT_USE_FLAT_CONFIG=false command nvim"
alias aider="aider --config ~/.config/.aider.conf.yml --no-gitignore"
