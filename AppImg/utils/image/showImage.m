function showImage(app, axes, imagePath)
    % hack to force matlab to scale the image in order to fit
    %app.UIFigure.Position(3:4) = [app.UIFigure.Position(3)+1, app.UIFigure.Position(4)+1];
    %drawnow 

    app.currentImage = imshow(imagePath, 'Parent',axes);
    app.currentImage.HitTest = 'off';
    
    axes.Position = [0 0 app.UIFigure.Position(3:4)];
    axes.XLim = [0 app.currentImage.XData(2)];
    axes.YLim = [0 app.currentImage.YData(2)];

    % restore the original dimensions
    %app.UIFigure.Position(3:4) = [app.UIFigure.Position(3)-1, app.UIFigure.Position(4)-1];
end

