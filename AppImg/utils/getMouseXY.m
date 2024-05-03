function [row,col,rgb] = getMouseXY(app)
    row = nan;
    col = nan;
    rgb = nan;
    
    % UIAxes does not have a "move mouse" callback so we need to check in
    % its UIFigure parent if the mouse is inside the image
    cp = app.UIFigure.CurrentPoint;
    isInAxes = cp(1) >= app.UIAxes.Position(1) && ...
        cp(1) <= sum(app.UIAxes.Position([1,3])) && ...
        cp(2) >= app.UIAxes.Position(2) && ...
        cp(2) <= sum(app.UIAxes.Position([2,4]));
    if isInAxes
        rows = app.currentImage.YData(2);
        cols = app.currentImage.XData(2);
        isInImage = 0 <= app.UIAxes.CurrentPoint(1,1) && app.UIAxes.CurrentPoint(1,1) <= cols && ...
                    0 <= app.UIAxes.CurrentPoint(1,2) && app.UIAxes.CurrentPoint(1,2) <= rows;
        if isInImage 
            x = app.UIAxes.CurrentPoint(1,1);
            y = app.UIAxes.CurrentPoint(1,2);
            row = ceil(y);
            col = ceil(x);
            rgb = app.currentImage.CData(row,col,:);
        end
    end
end

