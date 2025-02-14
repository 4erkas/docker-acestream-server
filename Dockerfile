
FROM debian:10.5-slim


ARG ACE_STREAM_VERSION

RUN DEBIAN_FRONTEND="noninteractive" \
	apt-get update && apt-get --yes upgrade && \
	# install packages
	apt-get --no-install-recommends --yes install \
		curl \
		libpython2.7 \
		python-requests \
		net-tools \
		python-apsw \
		python-lxml \
		python-m2crypto \
		python-pkg-resources && \
	# clean up
	apt-get clean && \
	rm --force --recursive /var/lib/apt/lists && \
	# install server
	curl --silent "http://download.acestream.media/linux/acestream_3.1.74_debian_10.5_x86_64.tar.gz" | \
		tar --extract --gzip

EXPOSE 6878/tcp

ENTRYPOINT ["/start-engine"]
CMD ["--client-console"]

