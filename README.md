[![Build Status](https://travis-ci.org/marcindulak/docker-gpaw-openmpi.svg?branch=master)](https://travis-ci.org/marcindulak/docker-gpaw-openmpi)

# Description

Dockerfile for GPAW https://wiki.fysik.dtu.dk/gpaw/ built against openmpi, based on Fedora.

The docker images are available at [dockerhub](https://hub.docker.com/r/marcindulak/gpaw-openmpi)


# Usage

First, make sure you are able to run the `docker run hello-world` example https://docs.docker.com/get-started/.
**Note** on MS Windows install https://hub.docker.com/editions/community/docker-ce-desktop-windows.

Then test the basic GPAW functionality

```sh
docker run --rm -it marcindulak/gpaw-openmpi:latest bash -c '. /etc/profile.d/modules.sh&& module use /usr/share/modulefiles&& module load mpi/openmpi-x86_64&& mpiexec --allow-run-as-root -np 2 gpaw-python3_openmpi -c "import gpaw.mpi; print(gpaw.mpi.rank)"'
```

**Note**: if on MS Windows you are getting 'image operating system "linux" cannot be used on this platform' follow https://docs.docker.com/docker-for-windows/#switch-between-windows-and-linux-containers

When running GPAW jobs inside of the container you want the output files created by GPAW to
be accessible locally on the machine running the job.
In order to achieve this create a local storage directory for this particular myjob.

```sh
mkdir myjob
```

Create a GPAW input script and save into the `myjob` directory.

Then start the job mounting the local storage directory as a docker volume https://docs.docker.com/storage/volumes/ inside of the container.
You have two choices, listed below.

## Run a job with docker-compose

```sh
docker-compose -f docker-compose.myjob.yml up
```

Remove the terminated container

```sh
docker-compose -f docker-compose.myjob.yml down
```

## Run a job manually

```sh
docker run --name myjob --rm -it -v "$(pwd)/myjob:/mnt" marcindulak/gpaw-openmpi:latest bash -c '. /etc/profile.d/modules.sh&& module use /usr/share/modulefiles&& module load mpi/openmpi-x86_64&& cd /mnt&& mpiexec --allow-run-as-root -np 2 which gpaw-python3_openmpi h2.py'
```

## Examine the created output file

```sh
cat myjob/h2.txt
```


# Building

## Locally

Build based on the local [Dockerfile](Dockerfile)

```sh
docker build -t gpaw-openmpi .
```

List images

```sh
docker images
```


# Docker image tagging convention

The docker image is tagged with the GPAW upstream version appended by a build number,
for example the first docker image of GPAW version `1.4.0` is tagged with `1.4.0-1`.
Note that this docker image may correspond to e.g. Fedora's RPM `1.4.0-10.fc30.x86_64`.
See the `ENV` values in [Dockerfile](Dockerfile).


# Dependencies

docker and optionally docker-compose


# License of this Dockerfile

Apache-2.0

**Note** please consult the GPAW software https://gitlab.com/gpaw/gpaw/blob/master/LICENSE


# Todo
