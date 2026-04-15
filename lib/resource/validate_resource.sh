if ! type info >/dev/null 2>&1; then
	source "$(dirname "${BASH_SOURCE[0]}")/log_resource.sh"
	source "$(dirname "${BASH_SOURCE[0]}")/message_resource.sh"
fi

validate_env() {
	# RESOURCE_NAME チェック
	if [ -z "${RESOURCE_NAME:-}" ]; then
		error "$E101" "RESOURCE_NAME"
		return 1
	fi

	case "$RESOURCE_NAME" in
	file | directory) ;;
	*)
		error "$E103"
		return 1
		;;
	esac

	# RESOURCE_ACTION チェック
	if [ -z "${RESOURCE_ACTION:-}" ]; then
		error "$E101" "RESOURCE_ACTION"
		return 1
	fi

	case "$RESOURCE_ACTION" in
	create | delete) ;;
	*)
		error "$E102"
		return 1
		;;
	esac

	# RESOURCE_PATH チェック
	if [ -z "${RESOURCE_PATH:-}" ]; then
		error "$E101" "RESOURCE_PATH"
		return 1
	fi

	return 0
}

validate_cli_args() {
	# 引数チェック
	if [ $# -lt 1 ]; then
		error "$E001"
		return 1
	fi

	local subcommand="$1"
	shift

	case "$subcommand" in
	local)
		if [ $# -ne 1 ]; then
			error "$E002"
			return 1
		fi

		local path="$1"

		if [ ! -e "$path" ]; then
			error "$E201" "path" "$path"
			return 1
		fi

		# 呼び出し元で使えるように export
		RESOURCE_FILE_PATH="$path"
		CLI_SUBCOMMAND="$subcommand"
		export RESOURCE_FILE_PATH CLI_SUBCOMMAND
		;;
	*)
		error "$E202" "subcommand" "$subcommand"
		return 1
		;;
	esac

	return 0
}
