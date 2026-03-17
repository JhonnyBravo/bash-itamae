create_file() {
	local target="$RESOURCE_PATH"

	# 既に存在する場合
	if [ -e "$target" ]; then
		return 0
	fi

	# ファイル作成
	touch "$target"
	return 2
}

delete_file() {
	local target="$RESOURCE_PATH"

	# ファイル存在チェック
	if [ ! -e "$target" ]; then
		return 0
	fi

	# 削除
	rm "$target"
	return 2
}
