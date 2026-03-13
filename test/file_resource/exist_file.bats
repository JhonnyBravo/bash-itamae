#!/usr/bin/env bats

setup() {
	source ./test/file_resource/test01.env
	source ./lib/resource/file_resource.sh
	rm -f "$RESOURCE_PATH"
	touch "$RESOURCE_PATH"
}

teardown() {
	rm -f "$RESOURCE_PATH"
}

@test "create_file 実行時に RESOURCE_PATH が存在する場合は exit 0 を返す" {
	run create_file

	[ "$status" -eq 0 ]
}

@test "delete_file 実行時に RESOURCE_PATH が存在する場合は削除して exit 2 を返す" {
	run delete_file

	[ "$status" -eq 2 ]
	[ ! -e "$RESOURCE_PATH" ]
}
