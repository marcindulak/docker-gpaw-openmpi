# Discover the sha by removing the @sha part and running: timeout 5 docker buildx build --pull --no-cache .
# Dockerhub does not show the overall sha https://github.com/docker/roadmap/issues/262
FROM fedora:37@sha256:f99efcddc4dd6736d8a88cc1ab6722098ec1d77dbf7aed9a7a514fc997ca08e0

# https://docs.docker.com/engine/reference/builder/#automatic-platform-args-in-the-global-scope
ARG TARGETPLATFORM
ARG TARGETARCH

RUN echo platform $TARGETPLATFORM
RUN echo arch $TARGETARCH
RUN echo uname -m $(uname -m)

LABEL name="GPAW Openmpi" \
      url="https://wiki.fysik.dtu.dk/gpaw/"

ENV GPAW_VERSION 22.8.0
ENV FEDORA_RELEASE 2.fc37

RUN set -x \
    && dnf install -y \
       python3-gpaw-openmpi-${GPAW_VERSION}-${FEDORA_RELEASE} \
       python3-gpaw-${GPAW_VERSION}-${FEDORA_RELEASE} \
    && dnf clean all

CMD ["/bin/bash"]
