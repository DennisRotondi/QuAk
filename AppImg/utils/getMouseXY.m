function [row,col,rgb] = getMouseXY(app, axes)
    row = nan;
    col = nan;
    rgb = nan;
    
    % UIAxes does not have a "move mouse" callback so we need to check in
    % its UIFigure parent if the mouse is inside the image
    cp = app.UIFigure.CurrentPoint;

    
    rows = app.currentImage.YData(2);
    cols = app.currentImage.XData(2);

    isInImage = 0 <= axes.CurrentPoint(1,1) && axes.CurrentPoint(1,1) <= cols && ...
                0 <= axes.CurrentPoint(1,2) && axes.CurrentPoint(1,2) <= rows;
    if isInImage
        x = axes.CurrentPoint(1,1);
        y = axes.CurrentPoint(1,2);
        row = ceil(y);
        col = ceil(x);
        rgb = app.currentImage.CData(row,col,:);
    end
    
end

