# make sure pointing existing flake, not downloading new one

alias rebuild="sh ~/.nix-configs/rebuild.sh"
alias nsh="nix shell --inputs-from ~/.nix-configs"

alias nd="nix develop"
alias nb="nix build"

# Jump to a flake input's source in /nix/store
nix-jump() {
	local INPUT_NAME="${1:-nixpkgs}"     # Default to 'nixpkgs'
	local LOCK_FILE="${2:-./flake.lock}" # Default to './flake.lock'
	local STORE_PATH

	# 1. Extract the store path from the lock file
	if ! STORE_PATH=$(jq -r --arg input "$INPUT_NAME" '
        .nodes[$input].locked
        | if has("store-path") then ."store-path"
          else "\(.narHash)-source" end' "$LOCK_FILE" 2>/dev/null); then
		echo "❌ Error parsing lock file: $LOCK_FILE"
		return 1
	fi

	# 2. Check if the path exists
	if [[ -z "$STORE_PATH" || "$STORE_PATH" == "null" ]]; then
		echo "❌ Input '$INPUT_NAME' not found in $LOCK_FILE"
		# Optional: List available inputs
		echo "    Available inputs:"
		jq -r '.nodes | keys[]' "$LOCK_FILE" 2>/dev/null | sed 's/^/      - /'
		return 1
	fi

	# 3. Navigate
	if [[ -d "/nix/store/$STORE_PATH" ]]; then
		cd "/nix/store/$STORE_PATH" || return 1
		echo "📁 Jumped to $INPUT_NAME → $(pwd)"
	else
		echo "⚠️  Store path exists but directory missing. Input might need fetching."
		echo "   Try: nix flake lock --update-input $INPUT_NAME"
		return 1
	fi
}
