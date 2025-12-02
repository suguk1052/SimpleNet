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

#### Custom dataset without ground-truth masks

SimpleNet now supports training and evaluation on datasets that only provide images.
Use the following directory layout:

```
data/custom/train/good/*.jpg
data/custom/test/good/*.jpg
data/custom/test/bad/*.jpg
```

Notes:
- The `ground_truth` directory is optional; segmentation masks are not required.
- Good images in the test split will automatically receive a zero mask during
  evaluation, so alignment errors will not occur even without GT files.
- Because pixel-level metrics depend on masks, they are disabled when no masks
  are present or all provided masks are empty. Instance-level AUROC continues to
  be reported normally.

Update `run.sh` to point to your custom data folder and classname. Replace the
default MVTec setup by setting `datapath` to the parent folder that contains
your class subfolders (for example, `data` when using `data/custom`) and
listing each class folder inside the `datasets` array in `run.sh` (for
instance, `datasets=('custom')` for a single class). The script builds the
appropriate flags automatically and runs SimpleNet with the custom layout.

#### MvTecAD

Download the dataset from [here](https://www.mvtec.com/company/research/datasets/mvtec-ad/).

The dataset folders/files follow its original structure.

### Run

#### Demo train

Set `datapath` and `datasets` in `run.sh` before running so they match your
custom dataset layout. The script now defaults to the custom directory structure
without ground-truth masks (with `datapath=data` and `datasets=('custom')` for
`data/custom/...`) and uses `resize/imagesize=128` to match a 128x128 custom
dataset; switch the path, class list, or image sizes if you want to run on
MVTecAD instead.
```
bash run.sh
```

#### Inference only (using a trained checkpoint)

Use the `infer` subcommand to load a saved checkpoint and evaluate the test split without running training. Point `--checkpoint_dir` to the folder that contains `models.ckpt` (created during training), and pass the same `net`/`dataset` settings you used for training so the model and dataloader are rebuilt correctly. For the custom dataset setup described above, you can keep the configuration in `inference.sh` (update `datapath` and `checkpoint_dir` if needed) and simply run:

```
sh inference.sh
```

The script rebuilds the dataloader with the correct options and reports AUROC/PRO metrics along with FPS for the restored model. Optionally save segmentation images by adding `--save_segmentation_images` inside the script command.

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
