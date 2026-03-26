#!/usr/bin/env bats

setup() {
	source ./lib/resource/file_resource.sh
}

teardown() {
	rm -f "$RESOURCE_PATH"
}

@test "delete_file 実行時に RESOURCE_PATH が存在する場合はファイルを削除して exit 2 を返す" {
	source ./test/file_resource/cases/delete_exists.env
	rm -f "$RESOURCE_PATH"
	touch "$RESOURCE_PATH"

	run delete_file
	echo "$output" >&3
	[ "$status" -eq 2 ]
	[ ! -e "$RESOURCE_PATH" ]
}

@test "delete_file 実行時に RESOURCE_PATH が存在しない場合は exit 0 を返す" {
	source ./test/file_resource/cases/delete_not_exists.env
	rm -f "$RESOURCE_PATH"

	run delete_file
	echo "$output" >&3
	[ "$status" -eq 0 ]
}
