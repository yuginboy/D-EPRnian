function [x0, xMax, yMax, xMin, yMin, yShift] = mFindMinMaxInRegion (X,Y, x1, x2) 
% функция поиска Max Min значений в заданном регионе.
% x1 - x2 - диапазон поиска по ОХ
% xMin,yMin - coor point of local minimum
% xMax,yMax - coor point of local maximum
% yMax - Y-coor point of selected local maximum
% yShift - смещение по оси OY если, к примеру, перепады пиков ищем в отсутствии
% пересечения с осью Y=0. Высчитываем как расстояние от Y=0 точки половины
% высоты между Bmax и Bmin на выбранном участке

% Задаем возвращаемые значения по умолчанию, если случится ошибка в поиске
% и ничего не найдется из пиков:
x0 = 0;
xMax = 0;
xMin = 0;
yMax = 0;
yMin = 0;
yShift = 0;
ii = find((X >= x1) & (X <= x2));
if length(ii)< 3
    txt = sprintf('The region has %d points, which is not enough for interpolation.\nReturn from mFindMinMaxInRegion.', length(ii));
    disp(txt);
    return;
end
yMin = min(min(Y(ii)));
yMax = max(max(Y(ii)));

iMax = find(Y == yMax);

iMin = find(Y == yMin);
xMax = X(iMax);
xMin = X(iMin);
yShift = (Y(iMax) + Y(iMin))/2;
if iMax > iMin
    % Если во время редактирования региона с левой стороны стал минимум а с
    % правой максимум то необходимо поменять значения индексов чтобы не
    % было реверсной нумерации в массиве ii = iMax:iMin;
            [iMin,iMax] = mChangeTwoVariablesPlaces (iMin,iMax);
end
n = length(X);
    if iMax < n
        

        ii = iMax:iMin;
        
%         txt = sprintf('iMax = %g, iMin = %g, len = %g', iMax, iMin, numel(ii));
%         disp(txt);
        
        % Ищем величину смещения
        yShift = (Y(iMax) + Y(iMin))/2;
        % Смещаем значения Y
        Y = Y - yShift;


        % интерполируем данные сплайнами, создавая избыточное, в 3 раза большее,
        % количество точек на выбранном отрезке
        xx = linspace(X(ii(1)), X(ii(end)), 3*length(ii));
        yy = interp1(X(ii), Y(ii), xx, 'pchip');

        % Ищем максимум и минимум
        yMax = max(max(yy));
        yMin = min(min(yy));

        xMax = xx (yy == yMax);
        xMin = xx (yy == yMin);

        if xMax > xMin
            [xMin,xMax] = mChangeTwoVariablesPlaces (xMin,xMax);
            [yMin,yMax] = mChangeTwoVariablesPlaces (yMin,yMax);
            ii = find ((xx < xMin) & (xx > xMax));
            [xMin,xMax] = mChangeTwoVariablesPlaces (xMin,xMax);
            [yMin,yMax] = mChangeTwoVariablesPlaces (yMin,yMax);
        else
            ii = find ((xx < xMin) & (xx > xMax));
        end


            x0 = interp1(yy(ii),xx(ii),((yMax+yMin)/2));
    end
end