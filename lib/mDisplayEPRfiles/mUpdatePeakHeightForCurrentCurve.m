function mUpdatePeakHeightForCurrentCurve(B,currentPeakNumber)
% Функция update всех графических элементов для новых значений элементов
% выбранного региона

% B = getappdata(B.hFig,'B');

cn = B.currentCurveNumber;
 i = currentPeakNumber;
 
set (B.Curve(cn).Peak(i).h_RegionBox, 'xData', B.Curve(cn).Peak(i).h_RegionBox_xv, 'yData', B.Curve(cn).Peak(i).h_RegionBox_yv);

%set(B.Curve(cn).Peak(i).Tag.hText, 'Position',B.Curve(cn).Peak(i).Tag.hText_Pos, 'string', B.Curve(cn).Peak(i).Tag.Name);
set(B.Curve(cn).Peak(i).Tag.hText, 'Position',B.Curve(cn).Peak(i).Tag.hText_Pos, 'string', [B.Curve(cn).TagName, ' : ', B.Curve(cn).Peak(i).Tag.Name]);

set (B.Curve(cn).Peak(i).hL_RegionBox, 'xData', B.Curve(cn).Peak(i).hL_RegionBox_xv, 'yData', B.Curve(cn).Peak(i).hL_RegionBox_yv);
set (B.Curve(cn).Peak(i).hR_RegionBox, 'xData', B.Curve(cn).Peak(i).hR_RegionBox_xv, 'yData', B.Curve(cn).Peak(i).hR_RegionBox_yv);
set (B.Curve(cn).Peak(i).h_CurveArea, 'xData', B.Curve(cn).Peak(i).h_CurveArea_xv, 'yData', B.Curve(cn).Peak(i).h_CurveArea_yv);


% drawnow;

% setappdata(B.hFig,'B',B);
end