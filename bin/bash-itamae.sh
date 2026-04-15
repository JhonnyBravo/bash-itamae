#!/usr/bin/bash
set -uo pipefail
changed=0

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

run validate_cli_args "$@"

case "$CLI_SUBCOMMAND" in
local)
	source "$RESOURCE_FILE_PATH"
	run validate_env
	;;
esac

case "$RESOURCE_NAME" in
file)
	case "$RESOURCE_ACTION" in
	create)
		run create_file

		if [ -n "${RESOURCE_OWNER:-}" ]; then
			run update_owner
		fi

		if [ -n "${RESOURCE_GROUP:-}" ]; then
			run update_group
		fi

		if [ -n "${RESOURCE_MODE:-}" ]; then
			run update_mode
		fi
		;;
	delete)
		run delete_file
		;;
	esac
	;;
directory)
	case "$RESOURCE_ACTION" in
	create)
		run create_directory

		if [ -n "${RESOURCE_OWNER:-}" ]; then
			run update_owner
		fi

		if [ -n "${RESOURCE_GROUP:-}" ]; then
			run update_group
		fi

		if [ -n "${RESOURCE_MODE:-}" ]; then
			run update_mode
		fi
		;;
	delete)
		run delete_directory
		;;
	esac
	;;
esac

exit $changed
