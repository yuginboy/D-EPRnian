function fTableRegionButtonDownFcn (B,cc,cr)
% Функция обработки нажатия мышки на таблице главного окна, которая
% отображает информацию конкретного пика
% Когда произошло двойное нажатие, то в таблице отображения всех пиков
% редактируемых кривых в позициях пиков изменяем значения отображаемых
% переменных. К примеру по умолчанию отображаются значения 'G-faktor' а мы
% хотим вывести значения для всех пиков интенсивности Io или значение поля
% Bo. Для этого в данной таблице кликаем на соответствующую строку.

B = getappdata(B.hFig,'B');
% Переводим значения индексов из Явы в Матлаб нотацию
% Номер выделенного столбца в таблице параметров региона|пика
cc = cc + 1;

% Номер выделенной строки в таблице параметров региона|пика
cr = cr + 1;
switch cr
    case 2
        B.currentViewParameterCurve = 'Curve Name';
    case 3
        B.currentViewParameterCurve = 'Angle';
    case 4
        B.currentViewParameterRegion = 'Start';
    case 5
        B.currentViewParameterRegion = 'End';
    case 6
        B.currentViewParameterRegion = 'BG Type';
    case 7 
        B.currentViewParameterRegion = 'Av Width';
    case 8
        B.currentViewParameterRegion = 'Offset';
    case 9
        B.currentViewParameterRegion = 'G-faktor';
    case 10
        B.currentViewParameterRegion = 'Imax';
    case 11
        B.currentViewParameterRegion = 'Bo' ;
    case 12
        B.currentViewParameterRegion = 'dB';
    case 13
        B.currentViewParameterRegion = 'Area';
    case 14
        B.currentViewParameterRegion = 'Io';
    case 16
        B.currentViewParameterRegion = 'auto left Bo';
    case 17
        B.currentViewParameterRegion = 'auto left Io';
    case 18
        B.currentViewParameterRegion = 'auto right Bo';
    case 19
        B.currentViewParameterRegion = 'auto right Io';
    case 21
        B.currentViewParameterRegion = 'manual left Bo';
    case 22
        B.currentViewParameterRegion = 'manual left Io';
    case 23
        B.currentViewParameterRegion = 'manual right Bo';
    case 24
        B.currentViewParameterRegion = 'manual right Io';
    otherwise
        B.currentViewParameterCurve = 'Curve Name';
        B.currentViewParameterRegion = 'G-faktor';
end


%disp('click');
setappdata(B.hFig,'B',B);
end