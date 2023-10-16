# Kielipankki-asr-backend

This repository contains the code for running Kielipankki's ASR backend, the Dockerfile for building the image, and a script for fetching the models. The Kubernetes deployment is in a separate repository.

## `install_model.sh`

Before building, you need to install models. Running `install_model.sh` will fetch and install a baseline model, `lp_baseline_1600h`, with our configurations. See [here](https://research.aalto.fi/fi/datasets/lahjoita-puhetta-baseline-kaldi-asr-model).

## Image size

The image is quite large, because it uncludes a lot of unnecessary libraries and packages from `kaldi-serve`. The included Dockerfile deletes them, but to get rid of them in the image, you have to merge the layers of the image together with an argument to your build command, if it supports it ("`docker --squash`"), something like [docker-squash](https://github.com/goldmann/docker-squash).
