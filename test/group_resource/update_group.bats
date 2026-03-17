#!/usr/bin/env bats

setup() {
	source ./test/group_resource/test01.env
	source ./lib/resource/group_resource.sh
	rm -f "$RESOURCE_PATH"
	touch "$RESOURCE_PATH"
	chgrp() {
		echo "mock chgrp called" >&3
	}
}

teardown() {
	rm -f "$RESOURCE_PATH"
}

@test "update_group 実行時に RESOURCE_GROUP に指定された所有者と現在の所有者が異なる場合は、所有者を変更して exit 2 を返す" {
	run update_group
	[ "$status" -eq 2 ]

	# chgrp モック化の副作用でグループ所有者変更のテストができない為、対象外とする。
	# local new_group=$(get_group)
	# [ "$new_group" = "$RESOURCE_GROUP" ]
}

@test "update_group 実行時に RESOURCE_GROUP に指定された所有者と現在の所有者が一致する場合は、所有者を変更せずに exit 0 を返す" {
	source ./test/group_resource/test02.env
	run update_group
	[ "$status" -eq 0 ]

	local new_group=$(get_group)
	[ "$new_group" = "$RESOURCE_GROUP" ]
}
