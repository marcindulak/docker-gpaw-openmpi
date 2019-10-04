FROM fedora:32

LABEL name="GPAW Openmpi" \
      url="https://wiki.fysik.dtu.dk/gpaw/"

ENV GPAW_VERSION 19.8.1
ENV FEDORA_RELEASE 2.fc32
ENV FEDORA_ARCH x86_64

RUN set -x \
    && dnf install -y python3-gpaw-openmpi-${GPAW_VERSION}-${FEDORA_RELEASE}.${FEDORA_ARCH} \
    && dnf clean all

CMD ["/bin/bash"]
