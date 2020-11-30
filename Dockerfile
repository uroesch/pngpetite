FROM alpine:edge

LABEL MAINTAINERS="Urs Roesch <github@bun.ch>"

ARG pngpetite_version
ENV VERSION=${pngpetite_version:-v0.3.2}

# Installing package required for the runtime of
# any of the asciidoctor-* functionnalities
RUN \
  apk add --no-cache \
    coreutils \
    bash \
    pngquant \
    zopfli \
    file \
    bc

COPY bin/pngpetite /bin/

ENTRYPOINT ["/bin/pngpetite"]
CMD ["/bin/bash", "-i", "-l"]
