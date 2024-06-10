img_path = "frame000003.png";
output_folder = "output/";
% max and min masks dim in %
max_dim = 0.06;
min_dim = 0.005;
I = imread(img_path);
imageSize = size(I);
tot_pixels = prod(imageSize(1:2));
I = 255.*rescale(I);
model = segmentAnythingModel;
embeddings = extractEmbeddings(model,I);

points_per_side = 32;
total_masks = {};
step_h = round(imageSize(1)/points_per_side);
step_w = round(imageSize(2)/points_per_side);
% delete content of otput dir
idx = 1;
for i=1:points_per_side
    for j=1:points_per_side
        pointPrompt = [j*step_w i*step_h];
        [masks,scores,maskLogits] = segmentObjectsFromEmbeddings(model,embeddings,imageSize, ForegroundPoints=pointPrompt);
        img_name = split(img_path, ".");
        pixels = sum(masks(:));
        percentage_non_zero = pixels/tot_pixels;
        if percentage_non_zero > min_dim && percentage_non_zero < max_dim
            disp(percentage_non_zero);
            imwrite(masks,output_folder+"mask"+idx+".png");
            idx = idx + 1;
        end
    end
end
