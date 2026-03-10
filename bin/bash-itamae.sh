#!/usr/bin/bash
set -uo pipefail

usage() {
	echo "Usage:"
	echo "  itamae local <path>"
	exit 1
}

run() {
	"$@"
	rc=$?
	if [ $rc -eq 1 ]; then
		exit 1
	fi
	return $rc
}

create_file() {
	# TARGET チェック
	if [ -z "${TARGET:-}" ]; then
		echo "Error: TARGET is not specified"
		return 1
	fi

	local target="$TARGET"

	# 既に存在する場合
	if [ -e "$target" ]; then
		return 0
	fi

	# ファイル作成
	touch "$target"
	return 2
}

delete_file() {
	# TARGET チェック
	if [ -z "${TARGET:-}" ]; then
		echo "Error: TARGET is not specified"
		return 1
	fi

	local target="$TARGET"

	# ファイル存在チェック
	if [ ! -e "$target" ]; then
		return 0
	fi

	# 削除
	rm "$target"
	return 2
}

set_owner() {
	local target="$TARGET"

	# 現在の所有者取得
	local current_owner
	current_owner=$(stat -c %U "$target")

	# 同一なら何もしない
	if [ "$current_owner" = "$OWNER" ]; then
		return 0
	fi

	chown "$OWNER" "$target"
	return 2
}

set_group() {
	local target="$TARGET"

	# 現在のグループ所有者取得
	local current_group
	current_group=$(stat -c %G "$target")

	# 同一なら何もしない
	if [ "$current_group" = "$GROUP" ]; then
		return 0
	fi

	chgrp "$GROUP" "$target"
	return 2
}

set_mode() {
	local target="$TARGET"

	# 現在のパーミッション設定取得
	local current_mode
	current_mode=$(stat -c %a "$target")

	# 同一なら何もしない
	if [ "$current_mode" = "$MODE" ]; then
		return 0
	fi

	chmod "$MODE" "$target"
	return 2
}

# 引数が1つ未満ならエラー
if [ $# -lt 1 ]; then
	usage
fi

subcommand="$1"
shift

case "$subcommand" in
local)
	if [ $# -ne 1 ]; then
		usage
	fi

	path="$1"

	if [ ! -e "$path" ]; then
		echo "Error: path not found: $path"
		exit 1
	fi

	source "$path"
	;;
*)
	usage
	;;
esac

case "$ACTION" in
create)
	run create_file

	if [-n "${OWNER}"]; then
		run set_owner
	fi

	if [-n "${GROUP}"]; then
		run set_group
	fi

	if [-n "${MODE}"]; then
		run set_mode
	fi
	;;
delete)
	run delete_file
	;;
*)
	echo "Unknown ACTION: $ACTION"
	exit 1
	;;
esac
