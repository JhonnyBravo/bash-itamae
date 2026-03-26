if ! type info >/dev/null 2>&1; then
	source "$(dirname "${BASH_SOURCE[0]}")/log_resource.sh"
fi

validate_env() {
	# RESOURCE_ACTION チェック
	if [ -z "${RESOURCE_ACTION:-}" ]; then
		error "RESOURCE_ACTION is not specified"
		return 1
	fi

	case "$RESOURCE_ACTION" in
	create | delete) ;;
	*)
		error "RESOURCE_ACTION must be 'create' or 'delete'"
		return 1
		;;
	esac

	# RESOURCE_PATH チェック
	if [ -z "${RESOURCE_PATH:-}" ]; then
		error "RESOURCE_PATH is not specified"
		return 1
	fi

	return 0
}

validate_cli_args() {
	# 引数チェック
	if [ $# -lt 1 ]; then
		error "subcommand is required"
		return 1
	fi

	local subcommand="$1"
	shift

	case "$subcommand" in
	local)
		if [ $# -ne 1 ]; then
			error "local requires exactly 1 argument"
			return 1
		fi

		local path="$1"

		if [ ! -e "$path" ]; then
			error "path not found: $path"
			return 1
		fi

		# 呼び出し元で使えるように export
		RESOURCE_FILE_PATH="$path"
		CLI_SUBCOMMAND="$subcommand"
		export RESOURCE_FILE_PATH CLI_SUBCOMMAND
		;;
	*)
		error "unknown subcommand: $subcommand"
		return 1
		;;
	esac

	return 0
}
