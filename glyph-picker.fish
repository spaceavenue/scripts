#!/usr/bin/env fish


argparse 'fzf' 'fuzzel' 'wtype' -- $argv; or exit 1

set -l list_url "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/css/nerd-fonts-generated.css"
set -l cache_dir (set -q XDG_CACHE_HOME; and echo $XDG_CACHE_HOME; or echo ~/.cache)
set -l parsed_list "$cache_dir/glyph-list"
set -l font "Symbols Nerd Font:size=16"

# parse list if it doesnt exist
if not test -f $parsed_list
  curl -s $list_url \
  | awk '/:before/ { gsub(/^\.nf-|:before/, "", $1); name=$1 } 
          /content:/ { gsub(/[^0-9a-fA-F]/, "", $2); 
          printf("%c %s\n", strtonum("0x" $2), name) }' \
  > $parsed_list
end

# selectors
set -l selection
if set -q _flag_fzf
  set selection (fzf < $parsed_list)
else
  set selection (fuzzel --dmenu --prompt "> " --placeholder "Search glyphs..." --font "$font" < $parsed_list)
end

# exit if cancelled
test -z "$selection"; and exit 0

# output
if set -q _flag_wtype
  echo "$selection" | string split -f1 ' ' | string join ' ' | wtype -
else
  echo "$selection" | string split -f1 ' ' | wl-copy --trim-newline
end

