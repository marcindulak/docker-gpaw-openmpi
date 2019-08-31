FROM fedora:30

LABEL name="GPAW Openmpi" \
      url="https://wiki.fysik.dtu.dk/gpaw/"

ENV GPAW_VERSION 1.4.0
ENV FEDORA_RELEASE 10.fc30
ENV FEDORA_ARCH x86_64

RUN set -x \
    && dnf install -y python3-gpaw-openmpi-${GPAW_VERSION}-${FEDORA_RELEASE}.${FEDORA_ARCH} \
    && dnf clean all

CMD ["/bin/bash"]
