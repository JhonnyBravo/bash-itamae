if ! type info >/dev/null 2>&1; then
	source "$(dirname "${BASH_SOURCE[0]}")/log_resource.sh"
fi

create_file() {
	local target="$RESOURCE_PATH"
	local action="$RESOURCE_ACTION"
	info "file[${target}] action ${action}"

	# 既に存在する場合
	if [ -e "$target" ]; then
		return 0
	fi

	# ファイル作成
	info "Creating ${target}"
	touch "$target"
	return 2
}

delete_file() {
	local target="$RESOURCE_PATH"
	local action="$RESOURCE_ACTION"
	info "file[${target}] action ${action}"

	# ファイル存在チェック
	if [ ! -e "$target" ]; then
		return 0
	fi

	# 削除
	info "Deleting ${target}"
	rm "$target"
	return 2
}
