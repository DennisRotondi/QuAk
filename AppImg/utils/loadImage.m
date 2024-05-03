function [imgPath] = loadImage

    [filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp;*.tif', 'Image Files (*.jpg, *.png, *.bmp, *.tif)'},...
                                      'Select an Image File');
    imgPath = fullfile(pathname,filename);
end