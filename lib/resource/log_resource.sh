#!/usr/bin/env bash

# INFOログ
info() {
	local fmt="$1"
	shift
	printf "INFO: ${fmt}\n" "$@"
}

# ERRORログ（stderr出力）
error() {
	local fmt="$1"
	shift
	printf "ERROR: ${fmt}\n" "$@" >&2
}
