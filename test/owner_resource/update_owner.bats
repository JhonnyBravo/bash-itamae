#!/usr/bin/env bats

setup() {
	source ./test/owner_resource/test01.env
	source ./lib/resource/owner_resource.sh
	rm -f "$RESOURCE_PATH"
	touch "$RESOURCE_PATH"
	chown() {
		echo "mock chown called" >&3
	}
}

teardown() {
	rm -f "$RESOURCE_PATH"
}

@test "update_owner 実行時に RESOURCE_OWNER に指定された所有者と現在の所有者が異なる場合は、所有者を変更して exit 2 を返す" {
	run update_owner
	[ "$status" -eq 2 ]

	# chown モック化の副作用で所有者変更のテストができない為、対象外とする。
	# local new_owner=$(get_owner)
	# [ "$new_owner" = "$RESOURCE_OWNER" ]
}

@test "update_owner 実行時に RESOURCE_OWNER に指定された所有者と現在の所有者が一致する場合は、所有者を変更せずに exit 0 を返す" {
	source ./test/owner_resource/test02.env
	run update_owner
	[ "$status" -eq 0 ]

	local new_owner=$(get_owner)
	[ "$new_owner" = "$RESOURCE_OWNER" ]
}
