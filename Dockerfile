# Discover the sha by removing the @sha part and running: timeout 5 docker buildx build --pull --no-cache .
# Dockerhub used to not show the overall sha https://github.com/docker/roadmap/issues/262
FROM fedora:40@sha256:5ce8497aeea599bf6b54ab3979133923d82aaa4f6ca5ced1812611b197c79eb0

# https://docs.docker.com/engine/reference/builder/#automatic-platform-args-in-the-global-scope
ARG TARGETPLATFORM
ARG TARGETARCH

RUN echo platform $TARGETPLATFORM
RUN echo arch $TARGETARCH
RUN echo uname -m $(uname -m)

LABEL name="GPAW Openmpi" \
      url="https://wiki.fysik.dtu.dk/gpaw/"

ENV GPAW_VERSION 24.1.0
ENV FEDORA_RELEASE 1.fc40

RUN set -x \
    && dnf install -y \
       python3-gpaw-openmpi-${GPAW_VERSION}-${FEDORA_RELEASE} \
       python3-gpaw-${GPAW_VERSION}-${FEDORA_RELEASE} \
    && dnf clean all

CMD ["/bin/bash"]
