#!/usr/bin/env bats

setup() {
	source ./lib/resource/directory_resource.sh
}

teardown() {
	if [ -d "$RESOURCE_PATH" ]; then
		rmdir "$RESOURCE_PATH"
	fi
}

@test "delete_directory 実行時に RESOURCE_PATH が存在する場合はファイルを削除して exit 2 を返す" {
	source ./test/directory_resource/cases/delete_exists.env

	if [ -d "$RESOURCE_PATH" ]; then
		rmdir "$RESOURCE_PATH"
	fi

	mkdir "$RESOURCE_PATH"

	run delete_directory
	echo "$output" >&3
	[ "$status" -eq 2 ]
	[ ! -d "$RESOURCE_PATH" ]
}

@test "delete_directory 実行時に RESOURCE_PATH が存在しない場合は exit 0 を返す" {
	source ./test/directory_resource/cases/delete_not_exists.env

	if [ -d "$RESOURCE_PATH" ]; then
		rmdir "$RESOURCE_PATH"
	fi

	run delete_directory
	echo "$output" >&3
	[ "$status" -eq 0 ]
}
