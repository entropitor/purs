HERE=$(dirname ${BASH_SOURCE[0]:-${(%):-%x}})
function _prompt_purs () {
  local exit_code="$0"
  PROMPT="$(_preprompt_purs) `$HERE/target/release/purs prompt -k "$KEYMAP" -r "$exit_code" --venv "${${VIRTUAL_ENV:t}%-*}"`"
}

function zle-line-init zle-keymap-select {
  local exit_code="$?"
  _prompt_purs $exit_code
  zle reset-prompt
  return $exit_code
}

zle -N zle-line-init
zle -N zle-keymap-select

autoload -Uz add-zsh-hook

function _prompt_purs_precmd() {
  local extra_args=""
  if [[ ! -z $1 ]]; then
    extra_args="--current-dir=$1 $extra_args"
  fi
  $HERE/target/release/purs precmd --git-detailed $extra_args
}
add-zsh-hook precmd _prompt_purs_precmd

function _preprompt_purs () {
  echo "[%{$fg[magenta]%}$(kubectl config current-context)%{$reset_color%}] "
}
_prompt_purs 0
