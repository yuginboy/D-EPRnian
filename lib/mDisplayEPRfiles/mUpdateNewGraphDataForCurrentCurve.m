function mUpdateNewGraphDataForCurrentCurve(B)
% Функция update всех графических элементов для новых значений элементов
% выбранного региона

B = getappdata(B.hFig,'B');

cn = B.currentCurveNumber;
 i = B.currentPeakNumber;
 
set (B.Curve(cn).Peak(i).h_RegionBox, 'xData', B.Curve(cn).Peak(i).h_RegionBox_xv, 'yData', B.Curve(cn).Peak(i).h_RegionBox_yv);

set(B.Curve(cn).Peak(i).Tag.hText, 'Position',B.Curve(cn).Peak(i).Tag.hText_Pos, 'string', [B.Curve(cn).TagName, ' : ', B.Curve(cn).Peak(i).Tag.Name]);

set (B.Curve(cn).Peak(i).hL_RegionBox, 'xData', B.Curve(cn).Peak(i).hL_RegionBox_xv, 'yData', B.Curve(cn).Peak(i).hL_RegionBox_yv);
set (B.Curve(cn).Peak(i).hR_RegionBox, 'xData', B.Curve(cn).Peak(i).hR_RegionBox_xv, 'yData', B.Curve(cn).Peak(i).hR_RegionBox_yv);
set (B.Curve(cn).Peak(i).h_CurveArea, 'xData', B.Curve(cn).Peak(i).h_CurveArea_xv, 'yData', B.Curve(cn).Peak(i).h_CurveArea_yv);

str1 = sprintf(' B = %0.7g Oe, I = %0.7g a.u.\n', B.Curve(cn).Peak(i).P1.Coor(1), B.Curve(cn).Peak(i).P1.Coor(2));
set (B.Curve(cn).Peak(i).P1.hText, 'Position', B.Curve(cn).Peak(i).P1.hText_Pos, ...
    'string', str1);
set (B.Curve(cn).Peak(i).P1.hLineVert,'xData', B.Curve(cn).Peak(i).P1.hLineVert_xv,'yData', B.Curve(cn).Peak(i).P1.hLineVert_yv);

str1 = sprintf('\n B = %0.7g Oe, I = %0.7g a.u.', B.Curve(cn).Peak(i).P2.Coor(1), B.Curve(cn).Peak(i).P2.Coor(2));
set (B.Curve(cn).Peak(i).P2.hText,'Position', B.Curve(cn).Peak(i).P2.hText_Pos, ...
    'string', str1);
set (B.Curve(cn).Peak(i).P2.hLineVert,'xData', B.Curve(cn).Peak(i).P2.hLineVert_xv,'yData', B.Curve(cn).Peak(i).P2.hLineVert_yv);

set (B.Curve(cn).Peak(i).Bo.hLineVert, 'xData', B.Curve(cn).Peak(i).Bo.hLineVert_xv,'yData', B.Curve(cn).Peak(i).Bo.hLineVert_yv);
set (B.Curve(cn).Peak(i).Bo.hLineHorzTop,'xData', B.Curve(cn).Peak(i).Bo.hLineHorzTop_xv, 'yData', B.Curve(cn).Peak(i).Bo.hLineHorzTop_yv );
set (B.Curve(cn).Peak(i).Bo.hLineHorzBot, 'xData', B.Curve(cn).Peak(i).Bo.hLineHorzBot_xv, 'yData', B.Curve(cn).Peak(i).Bo.hLineHorzBot_yv);

str1 = sprintf(' Bo = %0.7g Oe', B.Curve(cn).Peak(i).Bo.Coor);
set (B.Curve(cn).Peak(i).Bo.hText,'Position', B.Curve(cn).Peak(i).Bo.hText_Pos, ...
    'string', str1);

str1 = sprintf(' I_{max} = %0.7g a.u.', B.Curve(cn).Peak(i).Imax.Coor);
set (B.Curve(cn).Peak(i).Imax.hText, 'Position', B.Curve(cn).Peak(i).Imax.hText_Pos, ...
    'string', str1);

set (B.Curve(cn).Peak(i).dBmax.hLine,'xData', B.Curve(cn).Peak(i).dBmax.hLine_xv,'yData', B.Curve(cn).Peak(i).dBmax.hLine_yv );

str1 = sprintf(' dB_{max} = %0.7g Oe', B.Curve(cn).Peak(i).dBmax.Coor);
set (B.Curve(cn).Peak(i).dBmax.hText, 'Position', B.Curve(cn).Peak(i).dBmax.hText_Pos, ...
    'string', str1);

str1 = sprintf(' I_{0} = %0.7g a.u.', B.Curve(cn).Peak(i).Io.Coor);
set (B.Curve(cn).Peak(i).Io.hText, 'Position', B.Curve(cn).Peak(i).Io.hText_Pos, ...
    'string', str1);

str1 = sprintf(' G = %0.7g\n Area = %0.7e\n \\DeltaB = %0.7g Oe\n I_{max} = %0.7g a.u.\n B_{0} = %0.7g Oe', ...
               B.Curve(cn).Peak(i).G.Coor, B.Curve(cn).Peak(i).Area.TotalVal, B.Curve(cn).Peak(i).dBmax.Coor, B.Curve(cn).Peak(i).Imax.Coor, B.Curve(cn).Peak(i).Bo.Coor);
set (B.Curve(cn).Peak(i).Text.hText, 'Position', B.Curve(cn).Peak(i).Text.hText_Pos, ...
    'string', str1);

set(B.hAxes, 'yLim', B.hgrReal);
% disp('--------8--');
%         disp(get(B.hAxes, 'XLim'));
%         disp('----');
% drawnow;

setappdata(B.hFig,'B',B);
end