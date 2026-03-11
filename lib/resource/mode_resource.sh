update_mode() {
	local target="$TARGET"

	# 現在のパーミッション設定取得
	local current_mode
	current_mode=$(stat -c %a "$target")

	# 同一なら何もしない
	if [ "$current_mode" = "$MODE" ]; then
		return 0
	fi

	chmod "$MODE" "$target"
	return 2
}
