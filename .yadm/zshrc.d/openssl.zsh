function openssl() {
	docker run --rm -i svagi/openssl "$@"
}
