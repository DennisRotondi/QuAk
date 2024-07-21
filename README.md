# QuAk: Quick Annotator Kit
## A MATLAB® App for Semantically Annotating Large Datasets
Fine-tuning requires data, and hand-labeling is tedious and time-consuming. The idea for the project arose from the need for quick segmentation and classification. Matlab provides a tool for data labeling, but the task can only be performed manually or using superpixels.
Our tool, QuAk, can utilize state-of-the-art methods to rapidly generate a large number of segmented masks from an image. Then, through a simple GUI, one can select object areas and classify them using the keyboard. This allows dumping all the data in Matlab format and training an available segmentation and classification model directly in Matlab.

The ideal workflow is simple:

- Collect a bunch of images that you want to segment for your task.
- Generate many masks using a state-of-the-art solution. At the time of this project, for example, the Segment Anything Model (SAM). See below for instructions.
- Use our Matlab tool to quickly merge the raw masks into consistent objects to finalize your segmentation, precisely selecting the objects you need and giving a label to each.

## Installation SAM guide [[from official repo]](https://github.com/facebookresearch/segment-anything)

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

## How to use

1) Once you have the dataset, for example [download ours](https://drive.google.com/file/d/1vYKT7q8JimahwEILucVmURDJXQJKkJck/view?usp=sharing), you need to generate masks using any segmentator of your choice.

If you have installed SAM, you can call our MATLAB® function ```generate_masks_sam```. 
This function has the following arguments:
- `sam_script`:  Path to the segment-anything/scripts/amg.py script that runs the segment anything model.
- `checkpoint_path`: Path to the checkpoint file for the model downloaded above.
- `model_type`: Name of the model associated to the checkpoint downloaded above.
- `input_dir`: Path to the directory containing the input images.
- `output_dir`: Path to the directory where the generated masks will be saved.

An usage example is: <br>
```generate_masks_sam('segment-anything/scripts/amg.py', 'checkpoints/sam_vit_h_4b8939.pth', 'vit_h', 'dataset', 'masks')```

Please make sure that your Python environment is the same one on which you have installed SAM. You can verify it in MATLAB® with `pyenv`. You can change the MATLAB® Python environment using `pyversion(<path_to_env>)`. On Unix-based systems, `<path_to_env>` corresponds to the output of `which python` from the terminal.

2) Once you have the masks, install QuAK double clicking on QuAK.mlappinstall. This will add it to your list of apps. Alternatively, you can open quak.mlapp in App Designer, but you must set your working directory in AppImg/. The app will then open and ask you to choose input and output folder. You shall use the one selected in step 1.
   
   > If you already started labelling images in the folder, your label definitions will be loaded, and a popup will appear so that you can choose to start where you left of, or to erase the labels and start fresh.
   
3) Once everything is set up, you will be met with the app interface. To finally get started, define any label you need in the rightmost panel. Then, you can start with the workflow for each image in the dataset:
    1) Select an active label L.
    2) click on an object of class L in the image. You will see that the corresponding mask will be highlighted in the image and the left auxiliary screen. If the mask covered the whole object, select the "Label" button or use the corresponding shortcut. Otherwise, continue clicking on uncovered parts of the objects until you are satisfied with the mask. Press "Label" and repeat this step for each instance of L in the image. If you are unsatisfied with a segmentation, you can always press "< Undo" to cancel the last action.
    3) Do the same for each other label in the label set. Once done, press the "Next Image >" button to save the image and go to the next one.


