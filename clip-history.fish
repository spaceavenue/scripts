#!/usr/bin/env fish


argparse 'fzf' 'fuzzel' 'wtype' 'nline' -- $argv; or exit 1

# selector
set -l selection
if set -q _flag_fzf
  set selection (cliphist list | fzf)
else
  set selection (cliphist list | fuzzel --dmenu --prompt "> " --placeholder "Search clipboard..." --with-nth 2)
end

# exit if cancelled
test -z "$selection"; and exit 0

# output
if set -q _flag_wtype
  if set -q _flag_nline
    echo "$selection" | cliphist decode | wtype -
  else
    echo "$selection" | cliphist decode | string join ' ' | wtype -
  end
else
    echo "$selection" | cliphist decode | wl-copy
end
