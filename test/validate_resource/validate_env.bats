#!/usr/bin/env bats

setup() {
	unset RESOURCE_ACTION RESOURCE_PATH
	source ./lib/resource/validate_resource.sh
}

@test "正常系: RESOURCE_NAME=file + RESOURCE_ACTION=create + RESOURCE_PATHあり → 0" {
	source ./test/validate_resource/cases/valid_action_create.env

	run validate_env
	[ "$status" -eq 0 ]
}

@test "正常系: RESOURCE_NAME=directory + RESOURCE_ACTION=delete + RESOURCE_PATHあり → 0" {
	source ./test/validate_resource/cases/valid_action_delete.env

	run validate_env
	[ "$status" -eq 0 ]
}

@test "異常系: RESOURCE_ACTION 未指定 → 1" {
	source ./test/validate_resource/cases/no_action.env

	run validate_env
	echo "$output" >&3
	[ "$status" -eq 1 ]
}

@test "異常系: RESOURCE_ACTION 不正 → 1" {
	source ./test/validate_resource/cases/invalid_action.env

	run validate_env
	echo "$output" >&3
	[ "$status" -eq 1 ]
}

@test "異常系: RESOURCE_PATH 未指定 → 1" {
	source ./test/validate_resource/cases/no_path.env

	run validate_env
	echo "$output" >&3
	[ "$status" -eq 1 ]
}

@test "異常系: RESOURCE_NAME 未指定 → 1" {
	source ./test/validate_resource/cases/no_name.env

	run validate_env
	echo "$output" >&3
	[ "$status" -eq 1 ]
}

@test "異常系: RESOURCE_NAME 不正 → 1" {
	source ./test/validate_resource/cases/invalid_name.env

	run validate_env
	echo "$output" >&3
	[ "$status" -eq 1 ]
}
