# Discover the sha by removing the @sha part and running: timeout 5 docker buildx build --pull --no-cache .
# Dockerhub does not show the overall sha https://github.com/docker/roadmap/issues/262
FROM fedora:38@sha256:8285246bd5fad4e76e17a71c88dee34c49e2f227dab4ce7df704b592f8e72d41

# https://docs.docker.com/engine/reference/builder/#automatic-platform-args-in-the-global-scope
ARG TARGETPLATFORM
ARG TARGETARCH

RUN echo platform $TARGETPLATFORM
RUN echo arch $TARGETARCH
RUN echo uname -m $(uname -m)

LABEL name="GPAW Openmpi" \
      url="https://wiki.fysik.dtu.dk/gpaw/"

ENV GPAW_VERSION 23.6.0
ENV FEDORA_RELEASE 1.fc38

RUN set -x \
    && dnf install -y \
       python3-gpaw-openmpi-${GPAW_VERSION}-${FEDORA_RELEASE} \
       python3-gpaw-${GPAW_VERSION}-${FEDORA_RELEASE} \
    && dnf clean all

CMD ["/bin/bash"]
