#!/bin/bash
vim16_dir=~/.vim/bundle/base16-vim/colors
script_dir=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
for script in $script_dir/base16*.sh; do
  script_name=$(basename $script .sh)
  variation=dark
  if [[ $script_name == *"light"* ]]; then
    variation=light
  fi
  cat <<FUNC
$script_name()
{
  . $script
  ln -fs $script ~/.base16_theme 
  export BASE16_THEME=$script_name
  export BASE16_VARIATION=$variation
  echo $variation > ~/.base16_variation.rc
  if type tmux_${variation} >/dev/null; then
    tmux_${variation}
  fi
  [ -f ~/.vimrc_background ] && rm ~/.vimrc_background
  cat <<VIMRC_BACKGROUND > ~/.vimrc_background
"set background=$variation
colorscheme $script_name
VIMRC_BACKGROUND
}
FUNC
done;
[ -f ~/.base16_theme ] && echo ". ~/.base16_theme"
