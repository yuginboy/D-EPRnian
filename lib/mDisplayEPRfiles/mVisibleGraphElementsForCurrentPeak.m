function mVisibleGraphElementsForCurrentPeak (B,cn,i, ON_OFF)
% Скрываем все графические элементы для выбранного пика данной кривой
% ON_OFF = 'on' или 'off'- управляющее значение отображения или сокрытия элементов на
% графике

% B = getappdata(B.hFig,'B');

set (B.Curve(cn).Peak(i).h_RegionBox, 'Visible', ON_OFF);
set (B.Curve(cn).Peak(i).hL_RegionBox, 'Visible', ON_OFF);
set (B.Curve(cn).Peak(i).hR_RegionBox, 'Visible', ON_OFF);
set (B.Curve(cn).Peak(i).h_CurveArea, 'Visible', ON_OFF);
set (B.Curve(cn).Peak(i).Tag.hText, 'Visible', ON_OFF);
set (B.Curve(cn).Peak(i).P1.hText, 'Visible', ON_OFF);
set (B.Curve(cn).Peak(i).P1.hLineVert, 'Visible', ON_OFF);
set (B.Curve(cn).Peak(i).P2.hText, 'Visible', ON_OFF);
set (B.Curve(cn).Peak(i).P2.hLineVert, 'Visible', ON_OFF);
set (B.Curve(cn).Peak(i).Bo.hLineVert, 'Visible', ON_OFF);
set (B.Curve(cn).Peak(i).Bo.hLineHorzTop, 'Visible', ON_OFF);
set (B.Curve(cn).Peak(i).Bo.hLineHorzBot, 'Visible', ON_OFF);
set (B.Curve(cn).Peak(i).Bo.hText, 'Visible', ON_OFF);
set (B.Curve(cn).Peak(i).Imax.hText, 'Visible', ON_OFF);
set (B.Curve(cn).Peak(i).dBmax.hLine, 'Visible', ON_OFF);
set (B.Curve(cn).Peak(i).dBmax.hText, 'Visible', ON_OFF);
set (B.Curve(cn).Peak(i).Io.hText, 'Visible', ON_OFF);
set (B.Curve(cn).Peak(i).Text.hText, 'Visible', ON_OFF);

% setappdata(B.hFig,'B',B);
end