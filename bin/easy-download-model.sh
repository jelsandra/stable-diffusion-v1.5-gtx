#!/bin/sh -xe

MODEL_PATH=sd-data/sd-v1-5.ckpt
MODEL_URL=https://huggingface.co/stable-diffusion-v1-5/stable-diffusion-v1-5/resolve/main/v1-5-pruned.ckpt

# Download the v1.5 model (run from repo root)
[ ! -d "$(dirname "$MODEL_PATH")" ] && (
    echo "Must run this from repo root!"
    exit 1
)

# source: https://huggingface.co/stable-diffusion-v1-5/stable-diffusion-v1-5
wget -cO "$MODEL_PATH" "$MODEL_URL"
