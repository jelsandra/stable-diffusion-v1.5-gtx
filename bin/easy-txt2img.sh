#!/bin/sh -e

MODEL_PATH=/data/sd-v1-5.ckpt # Path to model on the docker container fs
DIMENSIONS=448 # Width and height of images generated in pixels
DDIM_STEPS=50 # The higher this number, the beter the output tends to look
ITERATIONS=3 # The iterations (number of times we loop over model.sample())
SAMPLES=3 # The number of images each iteration will generate

HEIGHT=$DIMENSIONS
WIDTH=$DIMENSIONS

[ -z "$1" ] && (
    echo "Must provide a prompt!" >&2
    echo "Usage: $0 \"prompt\"" >&2
    exit 1
)

[ ! -f "docker-compose.yml" ] && (
    echo "Must run this from repo root!" >&2
    exit 1
)

docker compose run \
  --build \
  --remove-orphans \
  sd python optimizedSD/optimized_txt2img.py \
    --n_iter $ITERATIONS \
    --n_samples $SAMPLES \
    --ddim_steps $DDIM_STEPS \
    --H $HEIGHT --W $WIDTH\
    --precision full \
    --ckpt "$MODEL_PATH" \
    --prompt "$1"
