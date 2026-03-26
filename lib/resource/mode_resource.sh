if ! type info >/dev/null 2>&1; then
	source "$(dirname "$BASH_SOURCE[0]")/log_resource.sh"
fi

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
	local new_mode="$RESOURCE_MODE"

	local normalized_cur_mode="$(normalize_mode "$current_mode")"
	local normalized_new_mode="$(normalize_mode "$new_mode")"

	# 同一なら何もしない
	if [ "$normalized_cur_mode" = "$normalized_new_mode" ]; then
		return 0
	fi

	info "Changing mode from ${current_mode} to ${new_mode}"
	chmod "$new_mode" "$target"
	return 2
}
