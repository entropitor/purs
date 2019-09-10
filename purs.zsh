$(cd $(dirname ${BASH_SOURCE[0]:-${(%):-%x}}) && cargo build --release 2> /dev/null)

function zle-line-init zle-keymap-select {
  PROMPT=`$(dirname ${BASH_SOURCE[0]:-${(%):-%x}})/target/release/purs prompt -k "$KEYMAP" -r "$?" --venv "${${VIRTUAL_ENV:t}%-*}"`
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

autoload -Uz add-zsh-hook

function _prompt_purs_precmd() {
  $(dirname ${BASH_SOURCE[0]:-${(%):-%x}})/target/release/purs precmd
}
add-zsh-hook precmd _prompt_purs_precmd
