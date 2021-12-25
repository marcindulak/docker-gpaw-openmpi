FROM fedora:35@sha256:762d7c5766839057fd9f96a0f2cedf143e2b818feb7767dc1bb70c00c4c3890a

LABEL name="GPAW Openmpi" \
      url="https://wiki.fysik.dtu.dk/gpaw/"

ENV GPAW_VERSION 21.6.0
ENV FEDORA_RELEASE 1.fc35
ENV FEDORA_ARCH x86_64

RUN set -x \
    && dnf install -y \
       python3-gpaw-openmpi-${GPAW_VERSION}-${FEDORA_RELEASE}.${FEDORA_ARCH} \
       python3-gpaw-${GPAW_VERSION}-${FEDORA_RELEASE}.${FEDORA_ARCH} \
    && dnf clean all

CMD ["/bin/bash"]
