__DOTFILES_WIDGET_NAME=abbr


##
## init
##
"__dotfiles_widget-init-${__DOTFILES_WIDGET_NAME}"() {
    ##
    ## alias
    ##
    # fast-syntax-highlighting highlighting of abbreviations (https://github.com/olets/zsh-abbr/issues/24)
    chroma_single_word() {
        (( next_word = 2 | 8192 ))

        local __first_call="$1" __wrd="$2" __start_pos="$3" __end_pos="$4"
        local __style

        (( __first_call )) && { __style=${FAST_THEME_NAME}alias }
        [[ -n "$__style" ]] && (( __start=__start_pos-${#PREBUFFER}, __end=__end_pos-${#PREBUFFER}, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[$__style]}")

        (( this_word = next_word ))
        _start_pos=$_end_pos

        return 0
    }

    # register single word command execpt for the followings:
    # - already in PATH
    # - already in fast-syntax-highlighting chroma map
    register_single_word_chroma() {
        local word=$1
        if [[ ! -x $(command -v $word) ]] && [[ ! -n $FAST_HIGHLIGHT["chroma-$word"] ]]; then
            FAST_HIGHLIGHT+=( "chroma-$word" chroma_single_word )
        fi
    }

    if [[ -n $FAST_HIGHLIGHT ]]; then
        for abbr in ${(f)"$(abbr list-abbreviations)"}; do
            if [[ $abbr != *' '* ]]; then
                register_single_word_chroma ${(Q)abbr}
            fi
        done
    fi
}


##
## update
##
"__dotfiles_widget-update-${__DOTFILES_WIDGET_NAME}"() {
}


##
## clean
##
"__dotfiles_widget-clean-${__DOTFILES_WIDGET_NAME}"() {
}


unset __DOTFILES_WIDGET_NAME
