function [xv, yv] = mGetCurrentCurveGraphData(B)
% Функция поиска соответствующей кривой из списка уже отредактированных

B = getappdata(B.hFig,'B');


setappdata(B.hFig,'B',B);
end