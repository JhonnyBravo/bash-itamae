#!/usr/bin/env bats

setup() {
	source ./test/file_resource/test01.env
	source ./lib/resource/file_resource.sh
	rm -f "$RESOURCE_PATH"
}

teardown() {
	rm -f "$RESOURCE_PATH"
}

@test "create_file 実行時に RESOURCE_PATH が存在しない場合は新規作成され exit 2 を返す" {
	run create_file

	[ "$status" -eq 2 ]
	[ -f "$RESOURCE_PATH" ]
}

@test "delete_file 実行時に RESOURCE_PATH が存在しない場合は exit 0 を返す" {
	run delete_file

	[ "$status" -eq 0 ]
}
