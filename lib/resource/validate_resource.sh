validate_env() {
	# RESOURCE_ACTION チェック
	if [ -z "${RESOURCE_ACTION:-}" ]; then
		echo "Error: RESOURCE_ACTION is not specified" >&2
		return 1
	fi

	case "$RESOURCE_ACTION" in
	create | delete) ;;
	*)
		echo "Error: RESOURCE_ACTION must be 'create' or 'delete'" >&2
		return 1
		;;
	esac

	# RESOURCE_PATH チェック
	if [ -z "${RESOURCE_PATH:-}" ]; then
		echo "Error: RESOURCE_PATH is not specified" >&2
		return 1
	fi

	return 0
}

validate_cli_args() {
	# 引数チェック
	if [ $# -lt 1 ]; then
		echo "Error: subcommand is required" >&2
		return 1
	fi

	local subcommand="$1"
	shift

	case "$subcommand" in
	local)
		if [ $# -ne 1 ]; then
			echo "Error: local requires exactly 1 argument" >&2
			return 1
		fi

		local path="$1"

		if [ ! -e "$path" ]; then
			echo "Error: path not found: $path" >&2
			return 1
		fi

		# 呼び出し元で使えるように export
		RESOURCE_FILE_PATH="$path"
		CLI_SUBCOMMAND="$subcommand"
		export RESOURCE_FILE_PATH CLI_SUBCOMMAND
		;;
	*)
		echo "Error: unknown subcommand: $subcommand" >&2
		return 1
		;;
	esac

	return 0
}
