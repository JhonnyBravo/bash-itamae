#!/usr/bin/env bats

setup() {
	source ./test/mode_resource/test01.env
	source ./lib/resource/mode_resource.sh
	rm -f "$RESOURCE_PATH"
	touch "$RESOURCE_PATH"
	chmod 644 "$RESOURCE_PATH"
}

teardown() {
	rm -f "$RESOURCE_PATH"
}

@test "update_mode 実行時に RESOURCE_MODE に指定されたパーミッション設定値と現在のパーミッション設定値が異なる場合は、パーミッション設定値を変更して exit 2 を返す" {
	run update_mode
	[ "$status" -eq 2 ]

	local act_mode=$(get_mode)
	local normalized_act_mode=$(normalize_mode "$act_mode")
	local normalized_exp_mode=$(normalize_mode "$RESOURCE_MODE")
	[ "$normalized_act_mode" = "$normalized_exp_mode" ]
}

@test "update_mode 実行時に RESOURCE_MODE に指定されたパーミッション設定値と現在のパーミッション設定値が一致する場合は、パーミッション設定値を変更せずに exit 0 を返す" {
	source ./test/mode_resource/test02.env
	run update_mode
	[ "$status" -eq 0 ]

	local act_mode=$(get_mode)
	local normalized_act_mode=$(normalize_mode "$act_mode")
	local normalized_exp_mode=$(normalize_mode "$RESOURCE_MODE")
	[ "$normalized_act_mode" = "$normalized_exp_mode" ]
}
