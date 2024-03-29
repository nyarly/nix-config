function fish_user_key_bindings
    bind \eh prevd 'commandline -f repaint'
    bind \el nextd 'commandline -f repaint'
    bind \ek cd 'commandline -f repaint'
    bind \ej 'cd -' 'commandline -f repaint'

    bind \eq jq_paginate

    bind \e\[1~ beginning-of-line
    bind \e\[3~ delete-char
    bind \e\[4~ end-of-line
    bind \e` clobber_history
    bind \es 'prepend_command sudo'
    bind \eg grepify
    bind \ez cd_fasd_fzf
    ### bang-bang ###
    bind ! bind_bang
    bind '$' bind_dollar
    ### bang-bang ###
    ### fzf ###
    set -q FZF_LEGACY_KEYBINDINGS
    or set -l FZF_LEGACY_KEYBINDINGS 1
    if test "$FZF_LEGACY_KEYBINDINGS" -eq 1
        bind \ct '__fzf_find_file'
        bind \cr '__fzf_reverse_isearch'
        bind \cx '__fzf_find_and_execute'
        bind \ec '__fzf_cd'
        bind \eC '__fzf_cd_with_hidden'
        if bind -M insert &>/dev/null
            bind -M insert \ct '__fzf_find_file'
            bind -M insert \cr '__fzf_reverse_isearch'
            bind -M insert \cx '__fzf_find_and_execute'
            bind -M insert \ec '__fzf_cd'
            bind -M insert \eC '__fzf_cd_with_hidden'
        end
    else
        bind \cf '__fzf_find_file'
        bind \cr '__fzf_reverse_isearch'
        bind \ex '__fzf_find_and_execute'
        bind \ed '__fzf_cd'
        bind \eD '__fzf_cd_with_hidden'
        if bind -M insert &>/dev/null
            bind -M insert \cf '__fzf_find_file'
            bind -M insert \cr '__fzf_reverse_isearch'
            bind -M insert \ex '__fzf_find_and_execute'
            bind -M insert \ed '__fzf_cd'
            bind -M insert \eD '__fzf_cd_with_hidden'
        end
    end
    ### fzf ###
    ### xfhalf2vsrnjfqhicwfqpm9kfzvj2xq4-source ###
    bind ! bind_bang
    bind '$' bind_dollar
    ### xfhalf2vsrnjfqhicwfqpm9kfzvj2xq4-source ###
    ### rd7pzzdxs7jrqx89j4ynjq1kappyky5k-nyarly_fish-bang-bang ###
    bind ! bind_bang
    bind '$' bind_dollar
    ### rd7pzzdxs7jrqx89j4ynjq1kappyky5k-nyarly_fish-bang-bang ###
end
