function nvm -d "bash nvm.sh; syncs fish PATH when NVM_BIN is set (use/install)"
    set -q NVM_DIR; or set -gx NVM_DIR $HOME/.nvm
    set -l tmp (mktemp)
    set -l statusfile (mktemp)

    set -gx __NVM_FISH_TMP $tmp
    set -gx __NVM_FISH_STATUS $statusfile

    command env NVM_DIR=$NVM_DIR bash -c '
        [ -s "$NVM_DIR/nvm.sh" ] || exit 127
        . "$NVM_DIR/nvm.sh"
        nvm "$@"
        echo $? > "$__NVM_FISH_STATUS"
        if [ -n "${NVM_BIN:-}" ]; then
            printf %s "$NVM_BIN" > "$__NVM_FISH_TMP"
        fi
    ' bash $argv

    set -l ec 0
    test -f $statusfile; and set ec (cat $statusfile)
    rm -f $statusfile

    if test -s $tmp
        set -l nvm_bin (string trim (cat $tmp))
        rm -f $tmp
        if test -n "$nvm_bin" -a -d "$nvm_bin"
            set -l new_path
            for p in $PATH
                if string match -q "*nvm/versions/node/*" $p
                    continue
                end
                set -a new_path $p
            end
            set -gx PATH $nvm_bin $new_path
        end
    else
        rm -f $tmp
    end

    set -e __NVM_FISH_TMP __NVM_FISH_STATUS
    return $ec
end
