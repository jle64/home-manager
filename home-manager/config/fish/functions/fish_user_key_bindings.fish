# for fedora
source /usr/share/skim/key-bindings.fish &>/dev/null

function fish_user_key_bindings
    if functions -q sk_key_bindings
        sk_key_bindings
    end
end
