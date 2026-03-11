get_owner() {
	local target="$RESOURCE_PATH"
	stat -c %U "$target"
}

update_owner() {
	local target="$RESOURCE_PATH"

	# 現在の所有者取得
	local current_owner=$(get_owner)

	# 同一なら何もしない
	if [ "$current_owner" = "$RESOURCE_OWNER" ]; then
		return 0
	fi

	chown "$RESOURCE_OWNER" "$target"
	return 2
}
