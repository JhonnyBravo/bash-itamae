if ! type info >/dev/null 2>&1; then
	source "$(dirname "${BASH_SOURCE[0]}")/log_resource.sh"
	source "$(dirname "${BASH_SOURCE[0]}")/message_resource.sh"
fi

create_file() {
	local target="$RESOURCE_PATH"
	local action="$RESOURCE_ACTION"
	info "$I001" "file" "$target" "$action"

	# 既に存在する場合
	if [ -e "$target" ]; then
		return 0
	fi

	# ファイル作成
	info "$I002" "$target"
	touch "$target"
	return 2
}

delete_file() {
	local target="$RESOURCE_PATH"
	local action="$RESOURCE_ACTION"
	info "$I001" "file" "$target" "$action"

	# ファイル存在チェック
	if [ ! -e "$target" ]; then
		return 0
	fi

	# 削除
	info "$I003" "$target"
	rm "$target"
	return 2
}
