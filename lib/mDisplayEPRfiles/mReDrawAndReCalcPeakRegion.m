function mReDrawAndReCalcPeakRegion (B)
% Функция перерисовки графических элементов выбранного региона
 B = getappdata(B.hFig,'B');
 cn = B.currentCurveNumber;
 i = B.currentPeakNumber;
 % Устанавливаем номер кривой и координаты всех возможных регионов данной
 % кривой
 


B.currentCurveNumber = cn;

setappdata(B.hFig,'B',B);
mUpdateScaleVars (B);
B = getappdata(B.hFig,'B');

 setappdata(B.hFig,'B',B);
end