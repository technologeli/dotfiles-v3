if status is-interactive
    # Commands to run in interactive sessions can go here
    source ~/.aliases

    fish_vi_key_bindings

    function fish_greeting
    end

    starship init fish | source
end
