FROM fedora:36@sha256:486fd5578f93fbc57a519e34ad4b7cac927c3f8a95409baedf0c19e9f287c207

LABEL name="GPAW Openmpi" \
      url="https://wiki.fysik.dtu.dk/gpaw/"

ENV GPAW_VERSION 22.1.0
ENV FEDORA_RELEASE 1.fc36
ENV FEDORA_ARCH x86_64

RUN set -x \
    && dnf install -y \
       python3-gpaw-openmpi-${GPAW_VERSION}-${FEDORA_RELEASE}.${FEDORA_ARCH} \
       python3-gpaw-${GPAW_VERSION}-${FEDORA_RELEASE}.${FEDORA_ARCH} \
    && dnf clean all

CMD ["/bin/bash"]
