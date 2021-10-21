local _PROMPT_USERNAME="%{$fg_bold[white]%}%n%{$reset_color%}"
local _PROMOPT_STATION="%{$fg_bold[white]%}%M%{$reset_color%}"
local _PROMPT_LOCATION="%{$fg_bold[white]%}%(5~|…/%3~|%~)%{$reset_color%}"
local _PROMPT_ENDCAP=" 𝑓%{$fg[red]%}%(?: : %? )%{$reset_color%}"

function _prompt_subject_git_current_branch() {
  local ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?

  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

function _prompt_subject() {
  local HAS_GIT=$(command git rev-parse --is-inside-work-tree 2>/dev/null)

  if [[ -n $HAS_GIT ]]; then
    local HAS_DIRTY=$(command git status --porcelain 2> /dev/null | tail -n1)
    local CURRENT_BRANCH=$(_prompt_subject_git_current_branch)

    if [[ -n $HAS_DIRTY ]]; then
      echo " on ± %{$fg[yellow]%}$CURRENT_BRANCH%{$reset_color%}"
    else
      echo " on ± %{$fg[white]%}$CURRENT_BRANCH%{$reset_color%}"
    fi
  fi
}

PROMPT='${_PROMPT_USERNAME}@${_PROMOPT_STATION} at ${_PROMPT_LOCATION}$(_prompt_subject)${_PROMPT_ENDCAP}'
