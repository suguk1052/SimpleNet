# SimpleNet


![](imgs/cover.png)

**SimpleNet: A Simple Network for Image Anomaly Detection and Localization**

*Zhikang Liu, Yiming Zhou, Yuansheng Xu, Zilei Wang**

[Paper link](https://openaccess.thecvf.com/content/CVPR2023/papers/Liu_SimpleNet_A_Simple_Network_for_Image_Anomaly_Detection_and_Localization_CVPR_2023_paper.pdf)

##  Introduction

This repo contains source code for **SimpleNet** implemented with pytorch.

SimpleNet is a simple defect detection and localization network that built with a feature encoder, feature generator and defect discriminator. It is designed conceptionally simple without complex network deisng, training schemes or external data source.

## Get Started 

### Environment 

**Python3.8**

**Packages**:
- torch==1.12.1
- torchvision==0.13.1
- numpy==1.22.4
- opencv-python==4.5.1

(Above environment setups are not the minimum requiremetns, other versions might work too.)


### Data

Edit `run.sh` to edit dataset class and dataset path.

#### MvTecAD

Download the dataset from [here](https://www.mvtec.com/company/research/datasets/mvtec-ad/).

The dataset folders/files follow its original structure.

### Run

#### Demo train

Please specicy dataset path (line1) and log folder (line10) in `run.sh` before running.

`run.sh` gives the configuration to train models on MVTecAD dataset.
```
bash run.sh
```

#### Inference only (using a trained checkpoint)

Use the `infer` subcommand to load a saved checkpoint and evaluate the test split without running training. Point `--checkpoint_dir` to the folder that contains `models.ckpt` (created during training), and pass the same `net`/`dataset` settings you used for training so the model and dataloader are rebuilt correctly. For example:

```
python3 main.py \
  --gpu 0 \
  --results_path results \
  --log_group simplenet_mvtec \
  --log_project MVTecAD_Results \
  --run_name run \
  net -b wideresnet50 -le layer2 -le layer3 --pretrain_embed_dimension 1536 --target_embed_dimension 1536 --patchsize 3 --meta_epochs 40 --embedding_size 256 --gan_epochs 4 --noise_std 0.015 --dsc_hidden 1024 --dsc_layers 2 --dsc_margin .5 --pre_proj 1 \
  dataset --batch_size 8 --resize 329 --imagesize 288 -d bottle mvtec /data4/MVTec_ad \
  infer --checkpoint_dir results/MVTecAD_Results/simplenet_mvtec/run/models/0/mvtec_bottle
```

The command will report AUROC/PRO metrics along with FPS for the restored model, and optionally saves segmentation images if `--save_segmentation_images` is provided.

## Citation
```
@inproceedings{liu2023simplenet,
  title={SimpleNet: A Simple Network for Image Anomaly Detection and Localization},
  author={Liu, Zhikang and Zhou, Yiming and Xu, Yuansheng and Wang, Zilei},
  booktitle={Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition},
  pages={20402--20411},
  year={2023}
}
```

## Acknowledgement

Thanks for great inspiration from [PatchCore](https://github.com/amazon-science/patchcore-inspection)

## License

All code within the repo is under [MIT license](https://mit-license.org/)
