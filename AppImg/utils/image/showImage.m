function showImage(app, axes, image, rescale)
arguments
    app
    axes
    image
    rescale = true
end

    if rescale

    % hack to force matlab to scale the image in order to fit
    app.UIFigure.Position(3:4) = [app.UIFigure.Position(3)+1, app.UIFigure.Position(4)+1];
    drawnow 
    
   
    app.currentImage = imshow(image, 'Parent', axes);
    app.currentImage.HitTest = 'off';
    
    axes.Position = [0 0 app.UIFigure.Position(3:4)];
    axes.XLim = [0 app.currentImage.XData(2)];
    axes.YLim = [0 app.currentImage.YData(2)];


    app.UIFigure.Position(3:4) = [app.UIFigure.Position(3)-1, app.UIFigure.Position(4)-1];
    
    else
        if class(image) == "char"
            image = imread(image);
        end
        if size(axes.Children) > 0
            axes.Children(1)
            if size(image,3) == 1
                image = repmat(image, [1 1 3]);
            end
            axes.Children(1).CData = image;
            
            axes.Children(1)
            axes.Children(1).HitTest = 'off';
        else
            showImage(app, axes, image, true);
        end
    end
end

