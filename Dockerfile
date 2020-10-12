FROM debian:stable-slim AS download
ARG GIT_REF=refs/tags/v3.13.0
WORKDIR /tmp
RUN protoc_version="$(echo "$GIT_REF" | cut -d '/' -f 3)" && apt-get update && apt-get install -y unzip wget && wget "https://github.com/protocolbuffers/protobuf/releases/download/${protoc_version}/protoc-$(echo "$protoc_version" | cut -c 2-)-linux-x86_64.zip" -O protoc.zip && unzip protoc.zip -d protoc && rm protoc.zip

FROM debian:stable-slim AS runtime
LABEL maintainer="JustArchi <JustArchi@JustArchi.net>"
COPY --from=download /tmp/protoc /opt/protoc
ENV PATH=$PATH:/opt/protoc/bin
ENTRYPOINT ["protoc"]
