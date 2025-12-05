# Default configuration for a custom dataset without ground-truth masks.
# Update datapath to point to the parent folder that contains your class
# subfolders (e.g., keeping the default `data` when using `data/custom`).
datapath=/mnt/d/04_KNL/data
datasets=(
  'custom'
)
dataset_flags=($(for dataset in "${datasets[@]}"; do echo '-d '"${dataset}"; done))

python3 main.py \
--gpu 0 \
--seed 0 \
--log_group simplenet_custom \
--log_project CustomAD \
--results_path results \
--run_name run \
net \
-b resnet18 \
-le layer2 \
-le layer3 \
--pretrain_embed_dimension 384 \
--target_embed_dimension 384 \
--patchsize 3 \
--meta_epochs 40 \
--embedding_size 256 \
--gan_epochs 4 \
--noise_std 0.015 \
--dsc_hidden 512 \
--dsc_layers 2 \
--dsc_margin .5 \
--pre_proj 1 \
dataset \
--batch_size 8 \
--resize 128 \
--imagesize 128 "${dataset_flags[@]}" mvtec $datapath
