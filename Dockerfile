FROM cgr.dev/chainguard/wolfi-base AS build

RUN apk --update add ca-certificates \
	&& mkdir -p /output/etc/ssl/certs \
	&& echo "nobody:x:65534:" > "/output/etc/group" \
	&& echo "nobody:x:65534:65534:nobody:/:" > "/output/etc/passwd" \
	&& cp "/etc/ssl/certs/ca-certificates.crt" "/output/etc/ssl/certs/"

FROM scratch

COPY --from=build /output/etc /etc

USER nobody

ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
