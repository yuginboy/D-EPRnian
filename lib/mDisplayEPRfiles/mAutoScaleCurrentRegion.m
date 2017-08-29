function mAutoScaleCurrentRegion(B)
% Автомасштабируем данный регион в окне вьювера (отображения графика)
B = getappdata(B.hFig,'B');
cn = B.currentCurveNumber;
i = B.currentPeakNumber;
B.wgrReal = B.Curve(cn).Peak(i).RegionPozition;
B.hgrReal = B.Curve(cn).Peak(i).RegionHeight;
set(B.hAxes, 'XLim', B.wgrReal, 'YLim', B.hgrReal);
setappdata(B.hFig,'B',B);
mUpdateScaleVars (B);
B = getappdata(B.hFig,'B');

%disp(get(B.hAxes, 'XLim'));

setappdata(B.hFig,'B',B); 
end