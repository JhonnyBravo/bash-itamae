#!/usr/bin/bash
set -uo pipefail
changed=0

usage() {
	echo "Usage:"
	echo "  itamae local <path>"
	exit 1
}

run() {
	"$@"
	local rc=$?

	if [ $rc -eq 1 ]; then
		exit 1
	fi

	if [ $rc -eq 2 ]; then
		changed=2
	fi
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
RESOURCE_DIR="$ROOT_DIR/lib/resource"

for f in "$RESOURCE_DIR"/*.sh; do
	source "$f"
done

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

	if [ -n "${OWNER:-}" ]; then
		run update_owner
	fi

	if [ -n "${GROUP:-}" ]; then
		run update_group
	fi

	if [ -n "${MODE:-}" ]; then
		run update_mode
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

exit $changed
