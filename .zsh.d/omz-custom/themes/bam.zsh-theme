# vim:ft=zsh
#
# Theme originally base on rkj-repos
# (https://github.com/robbyrussell/oh-my-zsh/wiki/Themes#rkj-repos)
#
# Modified from original to:
#   - reorder and simplify the prompt
#     - less "bling" & less bold
#     - change date format and move date
#     - moved PWD to 2nd line and git status to 1st
#   - support using the git-prompt plugin for git status
#
# For git-prompt status to work correctly and not be duplicated, set RPROMPT='' after
# oh-my-zsh has loaded themes & plugins (at the end of your .zshrc or sourced oh-my-zsh rc file )

# user, host, full path, and time/date on two lines for easier vgrepping

function hg_prompt_info {
  if (( $+commands[hg] )) && grep -q "prompt" ~/.hgrc 2>/dev/null; then
    hg prompt --angle-brackets "\
<hg:%{$fg[magenta]%}<branch>%{$reset_color%}><:%{$fg[magenta]%}<bookmark>%{$reset_color%}>\
</%{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[red]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
  fi
}

function git_repo_name() {
  if git rev-parse --is-inside-work-tree &> /dev/null; then
    # Get the full path to the git repo root and extract the basename
    echo $(basename $(git rev-parse --show-toplevel))
  else
    # Not in a git repo, can return an empty string or something else
    echo ""
  fi
}

# if we don't have git-prompt plugin/git_super_status() use these
if ( ! $(type git_super_status 2>&1 >/dev/null) ) ; then
  ZSH_THEME_GIT_PROMPT_ADDED=" %{$fg[cyan]%}+"
  ZSH_THEME_GIT_PROMPT_MODIFIED=" %{$fg[yellow]%}✱"
  ZSH_THEME_GIT_PROMPT_DELETED=" %{$fg[red]%}✗"
  ZSH_THEME_GIT_PROMPT_RENAMED=" %{$fg[blue]%}➦"
  ZSH_THEME_GIT_PROMPT_UNMERGED=" %{$fg[magenta]%}✂"
  ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{$fg[blue]%}✈"
  ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$fg[blue]%}"
  ZSH_THEME_GIT_PROMPT_SHA_AFTER=" %{$reset_color%}"
fi

function mygit() {
  if [[ "$(git config --get oh-my-zsh.hide-status)" != "1" ]]; then
    if $(type git_super_status 2>&1 >/dev/null) ; then
      # When using git_super_status() (from git-promt plugin) you must set $RPROMPT='' in your .zshrc after
      # oh-my-zsh theme/plugin initialization to be able to locate the status somewhere other than the
      # default of the far right side of the (last) prompt line.
      ### color # in ${FG[<#>]} is from `spectrum_ls`
      ZSH_THEME_GIT_PROMPT_PREFIX="(${FG[135]}$(git_repo_name)%{$reset_color%}: "
      echo "$(git_super_status)"
    else
      ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
      ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
      echo "[$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(git_repo_name)$(git_prompt_status)%{$fg_bold[blue]%}%{$reset_color%}$ZSH_THEME_GIT_PROMPT_SUFFIX]"
    fi
  fi
}

function retcode() {}

# Check for SSH and GCP
  if [[ -n $SSH_CONNECTION ]] || [[ $HOST =~ ".*-ssh$" ]]; then
    GCP_PROJECT=$(gcloud info --format="value(config.project)" 2>/dev/null)
    if [[ -n $GCP_PROJECT ]]; then
      REMOTE="[%{$fg[red]%}GCP: ${GCP_PROJECT}%{$reset_color%}]"
    else
      REMOTE="[%{$fg[red]%}REMOTE%{$reset_color%}]"
    fi
    LOC_COLOR0='blue'
    LOC_COLOR1='cyan'
  else
    REMOTE=''
    LOC_COLOR0='green'
    LOC_COLOR1='yellow'
  fi

# Date in prompt
# "%Y-%m-%d %I:%M:%S" - yyyy-mm-dd
#PROMPT_DATE="%Y-%m-%d %I:%M:%S"
# "%a %b %d %I:%M:%S" - WeekDay Mon dd
PROMPT_DATE="%a %b %d %I:%M:%S"

# alternate prompt with git & hg
PROMPT=$'%{$fg[white]%}[%{$fg[${LOC_COLOR0}]%}%n%b%{$fg[white]%}@%{$fg[$LOC_COLOR0]%}%m%{$fg[white]%}]%{$reset_color%} %{$fg[white]%}[%b%{$fg[${LOC_COLOR1}]%}'%D{"$PROMPT_DATE"}%b$'%{$fg[white]%}]%{$reset_color%}${REMOTE} $(mygit)$(hg_prompt_info)
%{$fg[white]%}[%{$fg[magenta]%}%?$(retcode)%{$fg[white]%}]%{$reset_color%} %{$fg[white]%}%{$fg[white]%}%~%{$fg[white]%}%{$reset_color%}$ '
PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '
