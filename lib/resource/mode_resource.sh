get_mode() {
	local target="$RESOURCE_PATH"
	stat -c %a "$target"
}

normalize_mode() {
	printf "%o" "$((8#$1))"
}

update_mode() {
	local target="$RESOURCE_PATH"

	# 現在のパーミッション設定取得
	local current_mode=$(get_mode)
	local normalized_cur_mode="$(normalize_mode "$current_mode")"
	local normalized_new_mode="$(normalize_mode "$RESOURCE_MODE")"

	# 同一なら何もしない
	if [ "$normalized_cur_mode" = "$normalized_new_mode" ]; then
		return 0
	fi

	chmod "$RESOURCE_MODE" "$target"
	return 2
}
