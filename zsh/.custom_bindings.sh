cursor_mode() {
    # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
            [[ $1 = 'block' ]]; then
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
        fi
    }

    zle-line-init() {
        echo -ne $cursor_beam
    }

    zle -N zle-keymap-select
    zle -N zle-line-init
}

cursor_mode

# use vi keybindings for zle
bindkey -v

# colemak-dh bindings for vim command editing
bindkey -M vicmd 'n' vi-backward-char
bindkey -M vicmd 'e' down-line-or-beginning-search
bindkey -M vicmd 'u' up-line-or-beginning-search
bindkey -M vicmd 'i' vi-forward-char

bindkey -M vicmd 'h' vi-insert
bindkey -M vicmd 'H' vi-insert-bol
bindkey -M vicmd 'l' vi-forward-word-end
bindkey -M vicmd 'L' vi-forward-blank-word-end
bindkey -M vicmd 'gl' vi-backward-word-end
bindkey -M vicmd 'gL' vi-backward-blank-word-end
bindkey -M vicmd 'j' vi-repeat-search
bindkey -M vicmd 'J' vi-rev-repeat-search
bindkey -M vicmd 'k' undo
bindkey -M vicmd 'K' redo # should be "undo all changes on the line" but not available in zle, and ^R is for history-incremental-search-backward
bindkey -M vicmd 'E' vi-join

bindkey -M vicmd 'hw' select-in-word
bindkey -M vicmd 'hW' select-in-blank-word
bindkey -M vicmd 'ha' select-in-shell-word

bindkey -M vicmd "^R" history-incremental-search-backward
bindkey -M vicmd "^S" history-incremental-search-forward

# colemak-dh bindings for vim insert mode
bindkey -M viins "^[[A" up-line-or-beginning-search
bindkey -M viins "^[[B" down-line-or-beginning-search
bindkey -M viins "\eOC" forward-char
bindkey -M viins "\eOD" backward-char

# todo: map Shift+arrows to jump vi-backward-word and vi-forward-word

bindkey -M viins "^R" history-incremental-search-backward
bindkey -M viins "^S" history-incremental-search-forward
