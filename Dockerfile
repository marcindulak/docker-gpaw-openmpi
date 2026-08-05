# Discover the sha by removing the @sha part and running: timeout 5 docker buildx build --pull --no-cache .
# Alternatively find the sha in Dockerhub UI https://github.com/docker/roadmap/issues/262
FROM fedora:44@sha256:6c75d5bf57cb0fa5aa4b92c6a83c86c791644496d9ac230de7711f5b8ec3b898

# https://docs.docker.com/engine/reference/builder/#automatic-platform-args-in-the-global-scope
ARG TARGETPLATFORM
ARG TARGETARCH

RUN echo platform $TARGETPLATFORM
RUN echo arch $TARGETARCH
RUN echo uname -m $(uname -m)

LABEL name="GPAW Openmpi" \
      url="https://wiki.fysik.dtu.dk/gpaw/"

ENV GPAW_VERSION=26.7.0
ENV FEDORA_RELEASE=1.fc44

RUN set -x \
    && dnf install -y \
       python3-gpaw-openmpi-${GPAW_VERSION}-${FEDORA_RELEASE} \
       python3-gpaw-${GPAW_VERSION}-${FEDORA_RELEASE} \
    && dnf clean all

CMD ["/bin/bash"]
