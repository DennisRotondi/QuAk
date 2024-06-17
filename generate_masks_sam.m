function generate_masks_sam(sam_script, checkpoint_path, model_type, input_dir, output_dir)

% GENERATE_MASKS_SAM Generates masks for the images in the specified input directory <input_dir>.
%
%   generate_masks_sam(sam_script, checkpoint_path, model_type, input_dir, output_dir)
%
%   This function uses a specified model <model_type> and checkpoint <checkpoint_path> to generate masks
%   for all images found in the input directory <input_dir> and saves the results in
%   the output directory <output_dir>.
%
%   Parameters:
%   -----------
%   sam_script : string
%       Path to the segment-anything/scripts/amg.py script that runs the segment anything model.
%
%   checkpoint_path : string
%       Path to the checkpoint file for the model. This file contains the
%       trained weights and other necessary parameters for the model.
%
%   model_type : string
%       Name of the model to be used for mask generation.
%
%   input_dir : string
%       Path to the directory containing the input images. All images in
%       this directory will be processed to generate masks.
%
%   output_dir : string
%       Path to the directory where the generated masks will be saved.
%
%   Example:
%   --------
%   generate_masks_sam('segment-anything/scripts/amg.py', 'checkpoints/sam_vit_h_4b8939.pth', 'vit_h', 'dataset', 'masks')
%
%   This example runs the script 'segment-anything/scripts/amg.py' using the checkpoint
%   file 'checkpoints/sam_vit_h_4b8939.pth' with the 'vit_h' model type to
%   generate masks for images located in 'dataset' and saves them to 'masks'.
%
%   Notes:
%   ------
%   - Ensure that the specified script and checkpoint file exist and are
%     accessible.
%   - The input directory should contain only the images that need to be
%     processed.
%   - The output directory will be created if it does not already exist.

exec = sam_script + " --checkpoint " + checkpoint_path + " --model-type " + model_type + " --input " + input_dir + " --output " + output_dir; 
pyrunfile(exec) 
end

