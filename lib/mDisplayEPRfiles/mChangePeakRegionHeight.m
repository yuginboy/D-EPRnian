function mChangePeakRegionHeight (B)
% Функция перерисовки и изменения высоты региона отрисовки у каждого
% региона для выбранной кривой в зависимости от масштаба по оси OY
 B = getappdata(B.hFig,'B');
 
 cn = B.currentCurveNumber; 

if cn > 0 &&  ~isempty(B.Curve)
    % Проверяем, содержит ли данная кривая пики:
    check = isfield(B.Curve,'Peak');
    if check
        if ~isempty(B.Curve(cn).Peak)
            for i = 1 : length(B.Curve(cn).Peak)
                % Переопределяем и пересчитываем только высоту у регионов:

                OX_length = abs(B.Curve(cn).Peak(i).RegionSearchCoord(2) - B.Curve(cn).Peak(i).RegionSearchCoord(1))/0.9;

                B.Curve(cn).Peak(i).RegionHeight = B.hgrReal;


                x = B.Curve(cn).Peak(i).RegionSearchCoord(1);
                y = B.hgrReal(1);
                w = 0.9*OX_length;
                h = B.hgrReal(2) - B.hgrReal(1);
                    B.Curve(cn).Peak(i).h_RegionBox_xv =   [x; (x+w); (x+w); x];
                    B.Curve(cn).Peak(i).h_RegionBox_yv =   [y; y; (y+h); (y+h)];


                Xc = x + 0.5*(B.Curve(cn).Peak(i).RegionSearchCoord(2) - B.Curve(cn).Peak(i).RegionSearchCoord(1));
                Yc = (y+0.95*h);% Тег - номер пика или его название
                B.Curve(cn).Peak(i).Tag.hText_Pos = [Xc, Yc];

                w = 0.05*( OX_length );
                x = x - w;
                    B.Curve(cn).Peak(i).hL_RegionBox_xv =   [x; (x+w); (x+w); x];
                    B.Curve(cn).Peak(i).hL_RegionBox_yv =   [y; y; (y+h); (y+h)];

                x = B.Curve(cn).Peak(i).RegionSearchCoord(2);
                    B.Curve(cn).Peak(i).hR_RegionBox_xv =   [x; (x+w); (x+w); x];
                    B.Curve(cn).Peak(i).hR_RegionBox_yv =   [y; y; (y+h); (y+h)];

                    % Обнавляем графические элементы с уже пересчитанными значениями
    %                 setappdata(B.hFig,'B',B);
                    mUpdatePeakHeightForCurrentCurve(B,i);
    %                 B = getappdata(B.hFig,'B');
            end
        end
    end
end
 
     

setappdata(B.hFig,'B',B);
mUpdateScaleVars (B);
B = getappdata(B.hFig,'B');



 setappdata(B.hFig,'B',B);
end