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
default MVTec setup by setting `datapath` to your dataset root (for example,
`data/custom`) and listing each class folder inside the `datasets` array in
`run.sh` (for instance, `datasets=('custom')` for a single class). The script
builds the appropriate flags automatically and runs SimpleNet with the custom
layout.

#### MvTecAD

Download the dataset from [here](https://www.mvtec.com/company/research/datasets/mvtec-ad/).

The dataset folders/files follow its original structure.

### Run

#### Demo train

Set `datapath` and `datasets` in `run.sh` before running so they match your
custom dataset layout. The script now defaults to the custom directory structure
without ground-truth masks; switch the path and class list if you want to run on
MVTecAD instead.
```
bash run.sh
```

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
