#!/usr/bin/bash
## dotsave.sh
# STATUS: OPERATIONAL
#
# Fetch managed paths from chezmoi, split by encryption state,
# then re-add each one individually.

add_managed_to_chezmoi() {
  local include="$1"
  local exclude="$2"
  local encrypt="$3"

  local args=('managed' '--path-style' 'absolute')
  [ -n "$include" ] && args+=("--include=$include")
  [ -n "$exclude" ] && args+=("--exclude=$exclude")

  local paths
  paths=$(chezmoi "${args[@]}" 2>/dev/null)

  if [ -z "$paths" ]; then
    echo "No managed paths found (include=$include exclude=$exclude)"
    return
  fi

  while IFS= read -r path; do
    # strip CR and surrounding whitespace (mirrors .Trim() in the ps1)
    path=$(printf '%s' "$path" | tr -d '\r' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    [ -z "$path" ] && continue

    if [ ! -e "$path" ]; then
      echo "Skipping missing path: $path"
      continue
    fi

    if [ "$encrypt" = "true" ]; then
      echo "Encrypting and re-adding: $path"
      # chezmoi re-add --re-encrypt -- "$path"
      chezmoi re-add -- "$path"
    else
      echo "Re-adding: $path"
      chezmoi re-add -- "$path"
    fi
  done <<< "$paths"
}

# Process all non-encrypted managed entries
add_managed_to_chezmoi "" "encrypted" "false"

# Process only encrypted managed entries
add_managed_to_chezmoi "encrypted" "" "true"

echo " "
echo "Dotsave is done, go to Chezmoi directory to push to git manually"