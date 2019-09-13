# PyTorch Dockerfile

## Build docker image

```bash
docker build -f Dockerfile -t pytorch .
```

## Build docker image on GCP

```bash
cloud builds submit --config cloudbuild.yaml --machine-type=n1-highcpu-32 --timeout=2h .
```
