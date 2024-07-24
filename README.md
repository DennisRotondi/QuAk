# QuAK: Quick Annotator Kit :baby_chick:
## A MATLAB® App for Semantically Annotating Large Datasets
Fine-tuning an object detection model requires data, and hand-labeling is tedious and time-consuming. This tool can speed up manual segmentation and classification of objects in an image by an order of magnitude.

Current state-of-the-art segmentation models are able to segment everything in an image, but these results are not usable for fine-tuning an object detection model. 
This tool was born from the idea of using the masks obtained by modern segmentation models to make it easier to create a large number of usable segmentation masks and bounding boxes. With our application, we can select the objects in an image and quickly classify them. The results are already in a format usable by Matlab, making it easier than ever to train models directly in Matlab.

The workflow is simple:

- Collect the images that you want labelled.
- Generate masks using a state-of-the-art model. At the time of this project, for example, we used the Segment Anything Model (SAM). See below for instructions.
- Use QuAK to quickly obtain the desired segmentation masks by precisely selecting the objects you need and giving a label to each.

## How to install :floppy_disk:
Open the repository folder with Matlab and double click the `QuAK.mlappinstall` file inside the AppImg folder and that's it! You can now find QuAK under the APPS window directly in Matlab.

## How to use :chart_with_upwards_trend:
The program expects an input folder with the following structure:

```
input folder
├─── img0.png
├─── img1.png
|   ...
├─── img0
|    ├─── 0.png
|    ├─── 1.png
|    ├─── ...
├─── img1
├─── ...
├─── labels.json (optional)
```

where `img<i>.png` is an image to label and `img<i>` is a folder containing the masks obtained from a segmentation model, named `0.png`, `1.png`, and so on. Below we explain all the steps to install the SAM model and to create these masks easily.

Once the input folder is ready QuAK can be launched. Once an input and output folders are selected (the output can be any empty folder) labeling can start.

## Functionalities :closed_book:

### Keeping your progress
This program can be used to label hundreds of images at a time. Your current progress is saved whenever the next image is loaded, so at any time the program can be closed without fear of loosing your work. When reopening the program and selecting the output folder, if you already started using it  the program will ask you if you want to delete its contents or if you want to skip the already labelled images. The first option will reset your work, while the second one will check for the already labelled images in the input folder and load the next unlabelled image, making the transition from the previous labelling session immediate.

### Interface
Once the input and output folders are selected the main interface will open. 

<p align="center">
    <img src="./resources/quak_screenshot.png" width="500">
</p>

We now describe the main interface:

1) The main image used for selecting the objects. Multiple clicks can be used to select different parts of an object.

2) Window two shows the currently selected mask.

3) Window three all the selected objects up to this point.

4) The `Label` button (shortcut **spacebar**) is used to label the currently selected mask

5) The `Undo` button (shortcut **b**) deselects the currently selected object or removes the previously labelled object.

6) The `Next` button (shortcut **n**) saves the masks for the current image and loads the next one.

7) This window can be used to select the desired label from the list. The `+` button can be used to create a new label. Another option is to add a file named *labels.json* in the input folder that specifies the labels to automatically create when launching the program. The file needs to specify the names that will be used for labeling and the color. The color is used by our program when selecting an object to help mkae sure the ibjects are labelled correctly. 
The file should be structured as follows:

Filename: ***labels.json***
``` 
{
    "names": ["obj1", "obj2", "obj3"],
    "colors": [[0,0.45,0.74],[1,1,0],[0.85,0.33,0]]
}
```

8) The Menu can be used to change input and output folders, while Shortcuts shows you the keyboard shortcuts available.

9) Here messages about the actions performed are shown.

## Useful tips :mag:

### Installation SAM guide [[from official repo]](https://github.com/facebookresearch/segment-anything)

The code requires `python>=3.8`, as well as `pytorch>=1.7` and `torchvision>=0.8`. Please follow the instructions [here](https://pytorch.org/get-started/locally/) to install both PyTorch and TorchVision dependencies. Installing both PyTorch and TorchVision with CUDA support is strongly recommended.

Install Segment Anything cloning the repository locally and install with

```
git clone https://github.com/facebookresearch/segment-anything.git
cd segment-anything; pip install -e .
```
Download a model checkpoint [from here](https://github.com/facebookresearch/segment-anything#model-checkpoints).

The following optional dependencies are necessary for mask post-processing, saving masks in COCO format, the example notebooks, and exporting the model in ONNX format.

```
pip install opencv-python pycocotools matplotlib onnxruntime onnx
```

In the future, when MATLAB® will support batch classification in SAM natively, you can skip this step.

### How to use SAM

Once you have the dataset, for example you can [download ours](https://drive.google.com/file/d/1Bk8C8-YYeIyB-IafD7Dbc5g2xkOC_dA3/view?usp=sharing), you need to generate masks using any segmentator of your choice.

If you have installed SAM, you can call our MATLAB® function ```generate_masks_sam```. 
This function has the following arguments:
- `sam_script`:  Path to the segment-anything/scripts/amg.py script that runs the segment anything model.
- `checkpoint_path`: Path to the checkpoint file for the model downloaded above.
- `model_type`: Name of the model associated to the checkpoint downloaded above.
- `input_dir`: Path to the directory containing the input images.
- `output_dir`: Path to the directory where the generated masks will be saved.

An usage example is: <br>
```
generate_masks_sam('segment-anything/scripts/amg.py', 'checkpoints/sam_vit_h_4b8939.pth', 'vit_h', 'dataset', 'masks')
```

Please make sure that your Python environment is the same one on which you have installed SAM. You can verify it in MATLAB® with `pyenv`. You can change the MATLAB® Python environment using `pyversion(<path_to_env>)`. On Unix-based systems, `<path_to_env>` corresponds to the output of `which python` from the terminal.
