FROM fedora:34@sha256:6c8b3dea130cfa28babcb4d73450ed64f962e5464ab191bc0539487daf25d533

LABEL name="GPAW Openmpi" \
      url="https://wiki.fysik.dtu.dk/gpaw/"

ENV GPAW_VERSION 21.1.0
ENV FEDORA_RELEASE 1.fc34
ENV FEDORA_ARCH x86_64

RUN set -x \
    && dnf install -y \
       python3-gpaw-openmpi-${GPAW_VERSION}-${FEDORA_RELEASE}.${FEDORA_ARCH} \
       python3-gpaw-${GPAW_VERSION}-${FEDORA_RELEASE}.${FEDORA_ARCH} \
    && dnf clean all

CMD ["/bin/bash"]
