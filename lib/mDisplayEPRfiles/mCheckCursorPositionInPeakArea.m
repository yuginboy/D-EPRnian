function [chk,chkL,chkR, chkC] = mCheckCursorPositionInPeakArea(B)
% Функция поиска положения курсора и областей пиков данной кривой

B = getappdata(B.hFig,'B');
cn = B.currentCurveNumber;
B.currentPeakNumber = 0;
chk = 0; % если курсор находится в области пика (центральная зона и управляющие элементы)
chkL = 0;% если курсор находится в области левого управляющего элемента
chkR = 0;% если курсор находится в области правого управляющего элемента
chkC = 0;% если курсор находится в области центрального управляющего элемента
if cn > 0
    % Проверяем, содержит ли данная кривая пики:
    check = isfield(B.Curve,'Peak');
    if check
        for i = 1 : length(B.Curve(cn).Peak)
            % Проверяем нахождение точки в регионе данного i-го пика
            inL_RegionBox = inpolygon (B.new_x,B.new_y,B.Curve(cn).Peak(i).hL_RegionBox_xv,B.Curve(cn).Peak(i).hL_RegionBox_yv);
%             disp([B.new_x,B.new_y]);
%             disp([B.Curve(cn).Peak(i).hL_RegionBox_xv,B.Curve(cn).Peak(i).hL_RegionBox_yv]);
            inR_RegionBox = inpolygon (B.new_x,B.new_y,B.Curve(cn).Peak(i).hR_RegionBox_xv,B.Curve(cn).Peak(i).hR_RegionBox_yv);
            inCenter_RegionBox = inpolygon (B.new_x,B.new_y,B.Curve(cn).Peak(i).h_RegionBox_xv,B.Curve(cn).Peak(i).h_RegionBox_yv);
            if inL_RegionBox || inR_RegionBox || inCenter_RegionBox
                B.currentPeakNumber = i;
                chk = 1;
            end
            if inL_RegionBox
                % Если точка находится внутри левого управляющего региона
                % данного пика
                chkL = 1;
            end
            if inR_RegionBox
                % Если точка находится внутри правого управляющего региона
                % данного пика
                chkR = 1;
            end
            if inCenter_RegionBox
                % Если точка находится внутри центральной зоны
                % данного пика
                chkC = 1;
            end
        end
    end
end
% disp(B.currentPeakNumber);

setappdata(B.hFig,'B',B);
end