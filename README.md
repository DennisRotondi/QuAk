# QuAk: Quick Annotator Kit

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
git clone git@github.com:facebookresearch/segment-anything.git
cd segment-anything; pip install -e .
```
Download a model checkpoint [from here](https://github.com/facebookresearch/segment-anything#model-checkpoints).

The following optional dependencies are necessary for mask post-processing, saving masks in COCO format, the example notebooks, and exporting the model in ONNX format.

```
pip install opencv-python pycocotools matplotlib onnxruntime onnx
```

In the future, when MATLAB will support batch classification in SAM natively, you can skip this step.

## How to use

(1) Once you have the dataset, for example [download ours](https://drive.google.com/file/d/1vYKT7q8JimahwEILucVmURDJXQJKkJck/view?usp=sharing), you need to generate masks using any segmentator of your choice.

If you have installed SAM, you can call our MATLAB function ```generate_masks_sam```. 
This function has the following arguments:
- `sam_script`:  Path to the segment-anything/scripts/amg.py script that runs the segment anything model.
- `checkpoint_path`: Path to the checkpoint file for the model downloaded above.
- `model_type`: Name of the model associated to the checkpoint downloaded above.
- `input_dir`: Path to the directory containing the input images.
- `output_dir`: Path to the directory where the generated masks will be saved.

An usage example is: <br>
```generate_masks_sam('segment-anything/scripts/amg.py', 'checkpoints/sam_vit_h_4b8939.pth', 'vit_h', 'dataset', 'masks')```

Please make sure that your Python environment is the same one on which you have installed SAM. You can verify it in MATLAB with `pyenv`. You can change the MATLAB Python environment using `pyversion(<path_to_env>)`. On Unix-based systems, `<path_to_env>` corresponds to the output of `which python` from the terminal.

(2) Once you have the mask, you can run the app_image and ...
