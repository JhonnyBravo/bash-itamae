#!/usr/bin/env bats

setup() {
	source ./lib/resource/validate_resource.sh

	# テスト用ファイル
	TEST_FILE="/tmp/validate_cli_args_test.env"
	touch "$TEST_FILE"
}

teardown() {
	rm -f "$TEST_FILE"
	unset RESOURCE_FILE_PATH CLI_SUBCOMMAND
}

@test "引数なし → exit 1" {
	run validate_cli_args
	echo "$output" >&3
	[ "$status" -eq 1 ]
}

@test "不正なサブコマンド → exit 1" {
	run validate_cli_args invalid
	echo "$output" >&3
	[ "$status" -eq 1 ]
}

@test "local だが引数なし → exit 1" {
	run validate_cli_args local
	echo "$output" >&3
	[ "$status" -eq 1 ]
}

@test "local だが引数が2つ → exit 1" {
	run validate_cli_args local a b
	echo "$output" >&3
	[ "$status" -eq 1 ]
}

@test "存在しない path → exit 1" {
	run validate_cli_args local /not/exist/file.env
	echo "$output" >&3
	[ "$status" -eq 1 ]
}

@test "正常系 → exit 0 + export される" {
	run validate_cli_args local "$TEST_FILE"
	[ "$status" -eq 0 ]

	# run はサブシェルなので export は見えない
	# → 直接実行で検証
	validate_cli_args local "$TEST_FILE"

	[ "$RESOURCE_FILE_PATH" = "$TEST_FILE" ]
	[ "$CLI_SUBCOMMAND" = "local" ]
}
