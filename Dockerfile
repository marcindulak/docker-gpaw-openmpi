FROM fedora:33@sha256:a6840e54fee94092a4298f3b05bfef310e8f7cebae7dbcdadb178f44251d2869

LABEL name="GPAW Openmpi" \
      url="https://wiki.fysik.dtu.dk/gpaw/"

ENV GPAW_VERSION 20.1.0
ENV FEDORA_RELEASE 2.fc33
ENV FEDORA_ARCH x86_64

RUN set -x \
    && dnf install -y python3-gpaw-openmpi-${GPAW_VERSION}-${FEDORA_RELEASE}.${FEDORA_ARCH} \
    && dnf clean all

CMD ["/bin/bash"]
