function [x0, xMax, yMax, xMin, yMin, yShift] = mFindNextMinimumAndXinterceptPoint (X,Y, yMax) 
% функция поиска следующего от данного максимума значения минимума, который
% следует сразу же после того, как кривая ЭПР спектра пересекает ось ОХ 
% x0 - X-interception
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
yMin = 0;

iMax = find(Y == yMax);
n = length(X);
i = iMax;
    if iMax < n
        % ищем индекс, отвечающий следующему за данным максимумом локальному
        % минимуму
        iMin = iMax+1;
        check = 1;
        while check && i < n
            if Y(i)<Y(i+1) || i == (n - 1)
                check = 0;
                iMin = i;
            end
            i = i+1;
        end

        ii = iMax:iMin;
        
        % Ищем величину смещения
        yShift = (Y(iMax) + Y(iMin))/2;
        % Смещаем значения Y
        Y = Y - yShift;
        
        % проверяем, пересекает ли график ось Y=0
        ip = find (Y(ii)>0);
        in = find (Y(ii)<0);

        %if length(ip)>0 && length(in)>0
            x0 = interp1(Y(ii),X(ii),0);
            x2 = X(iMin);
            x1 = X(iMax);
%             dx = x2 - x1;
%             ii = find ( (X < (x2 + dx)) & (X > (x1 - dx)) );

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
            
            
            
            if (yMax > 0) && (yMin < 0)
                % Ищем точку пересечения с ОХ
                
                x0 = interp1(yy(ii),xx(ii),0);
            else 
                % Ищем значения поля для точки среднего значения
                % интенсивности
                x0 = interp1(yy(ii),xx(ii),((yMax+yMin)/2));
            end
        %end
    end
end