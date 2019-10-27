# PyTorch Dockerfile

## Build docker image

```shell
$ docker build -t pytorch .
```

Build from other base image
```shell
$ docker build --build-arg BASE_IMAGE=nvidia/cuda:10.1-base-ubuntu18.04 -t pytorch .
```

## Build docker image on GCP

```shell
$ cloud builds submit --config cloudbuild.yaml --machine-type=n1-highcpu-32 --timeout=2h .
```

