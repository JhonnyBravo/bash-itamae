#!/usr/bin/env bats

setup() {
	source ./lib/resource/file_resource.sh
}

teardown() {
	rm -f "$RESOURCE_PATH"
}

@test "create_file 実行時に RESOURCE_PATH が存在する場合は exit 0 を返す" {
	source ./test/file_resource/cases/create_exists.env
	rm -f "$RESOURCE_PATH"
	touch "$RESOURCE_PATH"

	run create_file
	echo "$output" >&3
	[ "$status" -eq 0 ]
}

@test "create_file 実行時に RESOURCE_PATH が存在しない場合は新規作成され exit 2 を返す" {
	source ./test/file_resource/cases/create_new.env
	rm -f "$RESOURCE_PATH"

	run create_file
	echo "$output" >&3
	[ "$status" -eq 2 ]
	[ -f "$RESOURCE_PATH" ]
}
