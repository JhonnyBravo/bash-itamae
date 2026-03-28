#!/usr/bin/env bats

setup() {
	source ./lib/resource/directory_resource.sh
}

teardown() {
	rmdir "$RESOURCE_PATH"
}

@test "create_directory 実行時に RESOURCE_PATH が存在する場合は exit 0 を返す" {
	source ./test/directory_resource/cases/create_exists.env

	if [ -d "$RESOURCE_PATH" ]; then
		rmdir "$RESOURCE_PATH"
	fi

	mkdir "$RESOURCE_PATH"

	run create_directory
	echo "$output" >&3
	[ "$status" -eq 0 ]
}

@test "create_directory 実行時に RESOURCE_PATH が存在しない場合は新規作成され exit 2 を返す" {
	source ./test/directory_resource/cases/create_new.env
	if [ -d "$RESOURCE_PATH" ]; then
		rmdir "$RESOURCE_PATH"
	fi

	run create_directory
	echo "$output" >&3
	[ "$status" -eq 2 ]
	[ -d "$RESOURCE_PATH" ]
}
