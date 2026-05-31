# Paths & tools (before interactive): conda, nvm, Android SDK, common PATH
set -gx NVM_DIR $HOME/.nvm

if test -d $HOME/miniconda3
    set -gx PATH $HOME/miniconda3/bin $PATH
    $HOME/miniconda3/bin/conda shell.fish hook | source
end

# AWS CLI v2 in /usr/local must beat conda's aws stub. Do NOT prepend /usr/bin here — Fish also
# prepends $fish_user_paths (often including /usr/bin), which would beat nvm's node.
fish_add_path -m /usr/local/bin

# Default nvm Node must be first so `node` is not /usr/bin/node (remove system node if you use nvm only).
if test -f $NVM_DIR/alias/default
    set -l nvm_ver (string trim (cat $NVM_DIR/alias/default))
    string match -q 'v*' $nvm_ver; or set nvm_ver v$nvm_ver
    set -l nvm_path $NVM_DIR/versions/node/$nvm_ver/bin
    if not test -d $nvm_path
        for d in $NVM_DIR/versions/node/$nvm_ver*/bin
            test -d $d && set nvm_path $d && break
        end
    end
    test -d $nvm_path && set -gx PATH $nvm_path $PATH
end

if test -z "$ANDROID_HOME"; and test -d $HOME/Android/Sdk
    set -gx ANDROID_HOME $HOME/Android/Sdk
    set -gx ANDROID_SDK_ROOT $ANDROID_HOME
    set -gx PATH $ANDROID_HOME/emulator $ANDROID_HOME/platform-tools $ANDROID_HOME/tools $ANDROID_HOME/tools/bin $PATH
end

contains -- /usr/lib/ccache/bin $PATH; or set -a PATH /usr/lib/ccache/bin
contains -- $HOME/.cargo/bin $PATH; or set -a PATH $HOME/.cargo/bin
contains -- $HOME/.local/bin $PATH; or set -a PATH $HOME/.local/bin

# Commands to run in interactive sessions can go here
if status is-interactive
    # Fix colors in tmux
    if set -q TMUX
        set -q TMUX_TERM; or set -gx TERM tmux-256color
        if not tput colors >/dev/null 2>&1
            set -gx TERM screen-256color
        end
    end

    # No greeting
    set fish_greeting

    # Use starship
    function starship_transient_prompt_func
        starship module character
    end
    if test "$TERM" != "linux"
        starship init fish | source
        type -q enable_transience; and enable_transience
    end

    # Colors
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    # Aliases
    # kitty doesn't clear properly so we need to do this weird printing
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias celar "printf '\033[2J\033[3J\033[1;1H'"
    alias claer "printf '\033[2J\033[3J\033[1;1H'"
    alias pamcan pacman
    alias q 'qs -c ii'
    if test "$TERM" != "linux"
        alias ls 'eza --icons'
    end
end
