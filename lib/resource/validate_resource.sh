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
