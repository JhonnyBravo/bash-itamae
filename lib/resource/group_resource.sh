get_group() {
	local target="$RESOURCE_PATH"
	stat -c %G "$target"
}

update_group() {
	local target="$RESOURCE_PATH"

	# 現在のグループ所有者取得
	local current_group=$(get_group)

	# 同一なら何もしない
	if [ "$current_group" = "$RESOURCE_GROUP" ]; then
		return 0
	fi

	chgrp "$RESOURCE_GROUP" "$target"
	return 2
}
