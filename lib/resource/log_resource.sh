#!/usr/bin/env bash

# INFOログ
info() {
	printf "INFO : %s\n" "$*"
}

# ERRORログ（stderr出力）
error() {
	printf "ERROR: %s\n" "$*" >&2
}
