# Discover the sha by removing the @sha part and running: timeout 5 docker buildx build --pull --no-cache .
# Dockerhub does not show the overall sha https://github.com/docker/roadmap/issues/262
FROM fedora:36@sha256:2c5b21348e9b2a0b4c49bd5013be6d406be8594831aba21043393fcfba7252e0

# https://docs.docker.com/engine/reference/builder/#automatic-platform-args-in-the-global-scope
ARG TARGETPLATFORM
ARG TARGETARCH

RUN echo platform $TARGETPLATFORM
RUN echo arch $TARGETARCH
RUN echo uname -m $(uname -m)

LABEL name="GPAW Openmpi" \
      url="https://wiki.fysik.dtu.dk/gpaw/"

ENV GPAW_VERSION 22.1.0
ENV FEDORA_RELEASE 1.fc36

RUN set -x \
    && dnf install -y \
       python3-gpaw-openmpi-${GPAW_VERSION}-${FEDORA_RELEASE} \
       python3-gpaw-${GPAW_VERSION}-${FEDORA_RELEASE} \
    && dnf clean all

CMD ["/bin/bash"]
