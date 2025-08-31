# Discover the sha by removing the @sha part and running: timeout 5 docker buildx build --pull --no-cache .
# Alternatively find the sha in Dockerhub UI https://github.com/docker/roadmap/issues/262
FROM fedora:42@sha256:6c53109bbf345c2612ada5bd06e8e352b45d85c0a2d770167b61c8d1d047e124

# https://docs.docker.com/engine/reference/builder/#automatic-platform-args-in-the-global-scope
ARG TARGETPLATFORM
ARG TARGETARCH

RUN echo platform $TARGETPLATFORM
RUN echo arch $TARGETARCH
RUN echo uname -m $(uname -m)

LABEL name="GPAW Openmpi" \
      url="https://wiki.fysik.dtu.dk/gpaw/"

ENV GPAW_VERSION=25.7.0
ENV FEDORA_RELEASE=2.fc42

RUN set -x \
    && dnf install -y \
       python3-gpaw-openmpi-${GPAW_VERSION}-${FEDORA_RELEASE} \
       python3-gpaw-${GPAW_VERSION}-${FEDORA_RELEASE} \
    && dnf clean all

CMD ["/bin/bash"]
