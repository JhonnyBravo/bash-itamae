#!/usr/bin/env bats

setup() {
	unset RESOURCE_ACTION RESOURCE_PATH
	source ./lib/resource/validate_resource.sh
}

@test "正常系: RESOURCE_ACTION=create + RESOURCE_PATHあり → 0" {
	source ./test/validate_resource/test01.env

	run validate_env
	[ "$status" -eq 0 ]
}

@test "正常系: RESOURCE_ACTION=delete + RESOURCE_PATHあり → 0" {
	source ./test/validate_resource/test05.env

	run validate_env
	[ "$status" -eq 0 ]
}

@test "異常系: RESOURCE_ACTION 未指定 → 1" {
	source ./test/validate_resource/test02.env

	run validate_env
	[ "$status" -eq 1 ]
}

@test "異常系: RESOURCE_ACTION 不正 → 1" {
	source ./test/validate_resource/test03.env

	run validate_env
	[ "$status" -eq 1 ]
}

@test "異常系: RESOURCE_PATH 未指定 → 1" {
	source ./test/validate_resource/test04.env

	run validate_env
	[ "$status" -eq 1 ]
}
