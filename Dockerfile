FROM fedora:34@sha256:e6c6b6e158333b8d1b03095b1c70795f1ed19a7b0353e6986e9e255bbe6412da

LABEL name="GPAW Openmpi" \
      url="https://wiki.fysik.dtu.dk/gpaw/"

ENV GPAW_VERSION 20.1.0
ENV FEDORA_RELEASE 3.fc34
ENV FEDORA_ARCH x86_64

RUN set -x \
    && dnf install -y \
       python3-gpaw-openmpi-${GPAW_VERSION}-${FEDORA_RELEASE}.${FEDORA_ARCH} \
       python3-gpaw-${GPAW_VERSION}-${FEDORA_RELEASE}.${FEDORA_ARCH} \
    && dnf clean all

CMD ["/bin/bash"]
