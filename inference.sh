#!/usr/bin/env bash
set -euo pipefail

# Default configuration for running inference with a pre-trained SimpleNet model
# on a custom dataset without ground-truth masks.
#
# - Update `datapath` to point to the parent folder containing your class
#   subfolders (e.g., keep the default `data` when using `data/custom`).
# - Set `checkpoint_dir` to the directory that holds `models.ckpt` from training.
#   By default, checkpoints are stored under:
#   results/<log_project>/<log_group>/<run_name>/models/<model_idx>/<dataset_name>
#
# The rest of the options mirror the training settings so the model and
# dataloaders are reconstructed exactly for evaluation.

# Data configuration
# ---------------------------------------------------------------------------
datapath=/mnt/d/04_KNL/data
datasets=(
  'custom'
)
dataset_flags=($(for dataset in "${datasets[@]}"; do echo '-d '"${dataset}"; done))

# Checkpoint to load for inference
checkpoint_dir=results/CustomAD/simplenet_custom/run/models/0/custom_custom

# Inference command
# ---------------------------------------------------------------------------
python3 main.py \
--gpu 0 \
--seed 0 \
--log_group simplenet_custom \
--log_project CustomAD \
--results_path results \
--run_name run \
net \
-b wideresnet50 \
-le layer2 \
-le layer3 \
--pretrain_embed_dimension 1536 \
--target_embed_dimension 1536 \
--patchsize 3 \
--meta_epochs 40 \
--embedding_size 256 \
--gan_epochs 4 \
--noise_std 0.015 \
--dsc_hidden 1024 \
--dsc_layers 2 \
--dsc_margin .5 \
--pre_proj 1 \
dataset \
--batch_size 8 \
--resize 128 \
--imagesize 128 "${dataset_flags[@]}" custom "$datapath" \
infer --checkpoint_dir "$checkpoint_dir"
