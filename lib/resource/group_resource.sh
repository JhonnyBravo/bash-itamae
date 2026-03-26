if ! type info >/dev/null 2>&1; then
	source "$(dirname "${BASH_SOURCE[0]}")/log_resource.sh"
fi

get_group() {
	local target="$RESOURCE_PATH"
	stat -c %G "$target"
}

update_group() {
	local target="$RESOURCE_PATH"

	# 現在のグループ所有者取得
	local current_group=$(get_group)
	local new_group="$RESOURCE_GROUP"

	# 同一なら何もしない
	if [ "$current_group" = "$new_group" ]; then
		return 0
	fi

	info "Changing group from ${current_group} to ${new_group}"

	chgrp "$new_group" "$target"
	return 2
}
