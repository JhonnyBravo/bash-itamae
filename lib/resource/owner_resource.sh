if ! type info >/dev/null 2>&1; then
	source "$(dirname "$BASH_SOURCE[0]")/log_resource.sh"
fi

get_owner() {
	local target="$RESOURCE_PATH"
	stat -c %U "$target"
}

update_owner() {
	local target="$RESOURCE_PATH"

	# 現在の所有者取得
	local current_owner=$(get_owner)
	local new_owner="$RESOURCE_OWNER"

	# 同一なら何もしない
	if [ "$current_owner" = "$new_owner" ]; then
		return 0
	fi

	info "Changing owner from ${current_owner} to ${new_owner}"
	chown "$new_owner" "$target"
	return 2
}
