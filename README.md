![main](https://github.com/marcindulak/docker-gpaw-openmpi/workflows/main/badge.svg)

# Description

Dockerfile for GPAW https://wiki.fysik.dtu.dk/gpaw/ built against openmpi, based on Fedora.

The docker images are available at [dockerhub](https://hub.docker.com/r/marcindulak/gpaw-openmpi)


# Usage

First, make sure you are able to run the `docker run hello-world` example https://docs.docker.com/get-started/.
**Note** on MS Windows install https://hub.docker.com/editions/community/docker-ce-desktop-windows.

Then test the basic GPAW functionality

```sh
docker run --rm -it marcindulak/gpaw-openmpi:latest bash -c '. /etc/profile.d/modules.sh&& module use /usr/share/modulefiles&& module load mpi/openmpi-x86_64&& mpiexec --allow-run-as-root -np 2 python3 -c "import gpaw.mpi; print(gpaw.mpi.rank)"'
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
docker-compose -f docker-compose.myjob.yml up --exit-code-from gpaw
```

Remove the terminated container

```sh
docker-compose -f docker-compose.myjob.yml down
```

## Run a job manually

```sh
docker run --name myjob --rm -it -v "$(pwd)/myjob:/mnt" marcindulak/gpaw-openmpi:latest bash -c '. /etc/profile.d/modules.sh&& module use /usr/share/modulefiles&& module load mpi/openmpi-x86_64&& cd /mnt&& mpiexec --allow-run-as-root -np 2 python3 h2.py'
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


# Releasing

## Docker image tagging convention

The docker image is tagged with the GPAW upstream version appended by a build number,
for example the first docker image of GPAW version `1.4.0` is tagged with `1.4.0-1`.
Note that this docker image may correspond to e.g. Fedora's RPM `1.4.0-10.fc30.x86_64`.
See the `ENV` values in [Dockerfile](Dockerfile).

Build and test the image
```sh
docker-compose -f docker-compose.test.yml build --no-cache
docker-compose -f docker-compose.test.yml up --exit-code-from sut
```

Tag and push the image
```sh
docker tag docker-gpaw-openmpi_sut:latest marcindulak/gpaw-openmpi:1.4.0-1
docker tag docker-gpaw-openmpi_sut:latest marcindulak/gpaw-openmpi:latest
docker push marcindulak/gpaw-openmpi:1.4.0-1
docker push marcindulak/gpaw-openmpi:latest
```

# Dependencies

docker and optionally docker-compose


# License of this Dockerfile

Apache-2.0

**Note** please consult the GPAW software https://gitlab.com/gpaw/gpaw/blob/master/LICENSE


# Todo
