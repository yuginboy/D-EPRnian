function mReDrawPeakRegion (B)
% Функция перерисовки графических элементов выбранного региона
 B = getappdata(B.hFig,'B');
 cn = B.currentCurveNumber;
 i = B.currentPeakNumber;
 
 xMax = B.Curve(cn).Peak(i).P1.Coor(1);
 yMax = B.Curve(cn).Peak(i).P1.Coor(2);
 
 xMin = B.Curve(cn).Peak(i).P2.Coor(1);
 yMin = B.Curve(cn).Peak(i).P2.Coor(2);
 
 x0 = B.Curve(cn).Peak(i).Bo.Coor;
 % Устанавливаем номер кривой и координаты всех возможных регионов данной
 % кривой
 set(B.hAxes, 'XLim', B.Curve(cn).Peak(i).RegionPozition, 'YLim', B.hgrReal);
set(B.Curve(cn).Peak(i).h_RegionBox, 'XData',B.Curve(cn).Peak(i).h_RegionBox_xv,'YData',B.Curve(cn).Peak(i).h_RegionBox_yv);
set(B.Curve(cn).Peak(i).hL_RegionBox, 'XData',B.Curve(cn).Peak(i).hL_RegionBox_xv,'YData',B.Curve(cn).Peak(i).hL_RegionBox_yv);
set(B.Curve(cn).Peak(i).hR_RegionBox, 'XData',B.Curve(cn).Peak(i).hR_RegionBox_xv,'YData',B.Curve(cn).Peak(i).hR_RegionBox_yv);

set(B.Curve(cn).Peak(i).h_CurveArea, 'XData',B.Curve(cn).Peak(i).h_CurveArea_xv,'YData',B.Curve(cn).Peak(i).h_CurveArea_yv);

str1 = sprintf(' B = %0.5g Oe, I = %0.5g a.u.\n', xMax, yMax);
set(B.Curve(cn).Peak(i).P1.hText, 'Position', [xMax, yMax], 'String', str1);
set(B.Curve(cn).Peak(i).P1.hLineVert, 'XData', [xMax, xMax], 'YData', [0, yMax]);

% x,y координаты второго пика 
str1 = sprintf(' B = %0.5g Oe, I = %0.5g a.u.\n', xMin, yMin);
set(B.Curve(cn).Peak(i).P2.hText, 'Position', [xMin, yMin], 'String', str1);
set(B.Curve(cn).Peak(i).P2.hLineVert, 'XData', [xMin, xMin], 'YData', [0, yMin]);

set(B.Curve(cn).Peak(i).Bo.hLineVert, 'XData', [x0, x0], 'YData', [yMin, yMax]);
set(B.Curve(cn).Peak(i).Bo.hLineHorzTop,'XData', B.Curve(cn).Peak(i).Bo.hLineHorzTop_xv, 'YData', B.Curve(cn).Peak(i).Bo.hLineHorzTop_yv);
set(B.Curve(cn).Peak(i).Bo.hLineHorzBot, 'XData', B.Curve(cn).Peak(i).Bo.hLineHorzBot_xv, 'YData', B.Curve(cn).Peak(i).Bo.hLineHorzBot_yv);

str1 = sprintf(' Bo = %0.5g Oe', B.Curve(cn).Peak(i).Bo.Coor);
set(B.Curve(cn).Peak(i).Bo.hText, 'Position', B.Curve(cn).Peak(i).Bo.hText_Pos, 'String', str1);

% Амплитуда линии – Imax – соответствует по шкале амплитуды сигнала расстоянию между экстремумами на кривой линии;
str1 = sprintf(' I_{max} = %0.5g a.u.', B.Curve(cn).Peak(i).Imax.Coor);
set(B.Curve(cn).Peak(i).Imax.hText, 'Position', B.Curve(cn).Peak(i).Imax.hText_Pos, 'String', str1);

% Ширина линии – dВmax – cоответствует расстоянию по полю между экстремумами на кривой линии;
set(B.Curve(cn).Peak(i).dBmax.hLine, 'XData', [xMax, xMin], 'YData', [0, 0]);
str1 = sprintf(' dB_{max} = %0.5g Oe', B.Curve(cn).Peak(i).dBmax.Coor);
set(B.Curve(cn).Peak(i).dBmax.hText, 'Position', B.Curve(cn).Peak(i).dBmax.hText_Pos, 'String', str1);


str1 = sprintf(' G = %0.7g\n Area = %0.3e', B.Curve(cn).Peak(i).G.Coor, B.Curve(cn).Peak(i).Area.TotalVal);
set(B.Curve(cn).Peak(i).Text.hText, 'Position', B.Curve(cn).Peak(i).Text.hText_Pos, 'String', str1);

% 
% setappdata(B.hFig,'B',B);
% mUpdateScaleVars (B);
% B = getappdata(B.hFig,'B');

 setappdata(B.hFig,'B',B);
end