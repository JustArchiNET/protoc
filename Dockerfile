FROM debian:stable-slim AS download
ARG PROTOC_VERSION=v3.13.0
WORKDIR /tmp
RUN apt-get update && apt-get install -y unzip wget && wget "https://github.com/protocolbuffers/protobuf/releases/download/${PROTOC_VERSION}/protoc-$(echo "$PROTOC_VERSION" | cut -c 2-)-linux-x86_64.zip" -O protoc.zip && unzip protoc.zip -d protoc && rm protoc.zip

FROM debian:stable-slim AS runtime
LABEL maintainer="JustArchi <JustArchi@JustArchi.net>"
COPY --from=download /tmp/protoc /opt/protoc
ENV PATH=$PATH:/opt/protoc/bin
ENTRYPOINT ["protoc"]
