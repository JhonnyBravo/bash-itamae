if ! type info >/dev/null 2>&1; then
	source "$(dirname "${BASH_SOURCE[0]}")/log_resource.sh"
	source "$(dirname "${BASH_SOURCE[0]}")/message_resource.sh"
fi

create_directory() {
	local target="$RESOURCE_PATH"
	local action="$RESOURCE_ACTION"
	info "$I001" "directory" "$target" "$action"

	# 既に存在する場合
	if [ -d "$target" ]; then
		return 0
	fi

	# ディレクトリ作成
	info "$I002" "$target"
	mkdir "$target"
	return 2
}

delete_directory() {
	local target="$RESOURCE_PATH"
	local action="$RESOURCE_ACTION"
	info "$I001" "directory" "$target" "$action"

	# ディレクトリ存在チェック
	if [ ! -d "$target" ]; then
		return 0
	fi

	# 削除
	info "$I003" "$target"
	rmdir "$target"
	return 2
}
