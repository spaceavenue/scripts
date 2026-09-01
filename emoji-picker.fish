#!/usr/bin/env fish

argparse 'fzf' 'fuzzel' 'wtype' -- $argv; or exit 1

set -l emoji_ver "17.0.0"
set -l list_url "https://www.unicode.org/Public/$emoji_ver/emoji/emoji-test.txt"
set -l cache_dir (set -q XDG_CACHE_HOME; and echo $XDG_CACHE_HOME; or echo ~/.cache)
set -l parsed_list "$cache_dir/emoji-list"
set -l font "Iosevka Etoile:size=16"

# parse list
if not test -f $parsed_list
  mkdir -p (dirname $parsed_list)
  curl -s $list_url \
  | awk -F'# ' '/; fully-qualified/ {gsub(/E[0-9.]* /, ""); print $2}' \
  > $parsed_list
end

# selector
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
