function mMovePeakRegion (B)
% Функция передвижения региона пика без поиска основных характеристик.
% Создана для более улучшенной работы с пиками при помощи мышки. Было
% неудобно, когда во время передвижения региона график автомасштабировался
% и пользователь тратил контроль над тем куда именно передвинулся регион в
% сравнении с рисунком полного спектра.
% Пересчет всех характеристик пика производится функцией: mReCalcPeakRegion
% Предполагается, что изменяется параметр: B.Curve(cn).Peak(i).RegionSearchCoord
 B = getappdata(B.hFig,'B');
 
 cn = B.currentCurveNumber;
 i = B.currentPeakNumber;
 
% Ищем максимум и минимум на данном отрезке:
ii = find(B.x >= B.Curve(cn).Peak(i).RegionSearchCoord(1) & B.x <= B.Curve(cn).Peak(i).RegionSearchCoord(2));
Y2 = max(max(B.y(ii)));
x1 = B.Curve(cn).Peak(i).RegionSearchCoord(1);
x2 = B.Curve(cn).Peak(i).RegionSearchCoord(2);
if x2 < x1
    tmpVar = x2;
    x2 = x1;
    x1 = tmpVar;
end
[x0, xMax, yMax, xMin, yMin, yShift] = mFindMinMaxInRegion (B.x,B.y, x1, x2 );

while x0 == 0 && xMax == 0 && xMin == 0
    txt = sprintf('Chenge the Region size automatically in mMovePeakRegion. ');
    disp(txt);
    % Если размер региона слишком мал
    % ---------------------------необходимо переопределить значения региона
    if x1 <= B.x(1)
        x1 = B.x(1);
        x2 = x2 + 10*abs(B.x(2)-B.x(1));
    elseif x2 >= B.x(end)
        x1 = x1 - 10*abs(B.x(2)-B.x(1));
        x2 = B.x(end);
    elseif abs(x2-x1) > abs(B.x(2)-B.x(1))
        x2 = x2 + 4*(x2-x1);
        x1 = x1 - 4*(x2-x1);
    else
        x2 = x2 + 10*abs(B.x(2)-B.x(1));
        x1 = x1 - 10*abs(B.x(2)-B.x(1));
    end
    if x2 < x1
        tmpVar = x2;
        x2 = x1;
        x1 = tmpVar;
    end
    txt = sprintf('New region is\nx1 = %f x2 = %f ', x1, x2);
    disp(txt);
    [x0, xMax, yMax, xMin, yMin, yShift] = mFindMinMaxInRegion (B.x,B.y, x1, x2 );
end

% Переопределяем значения концевых точек региона, если они выходят за рамки
% значений данной кривой
if x1<= B.x(1)
        x1 = B.x(1);
elseif  x2 >= B.x(end)
        x2 = B.x(end);
end

B.Curve(cn).Peak(i).RegionSearchCoord(1) = x1;
B.Curve(cn).Peak(i).RegionSearchCoord(2) = x2;

Xo1 = xMax;
Xo1 = xMax;
Xo2 = xMin;
Xo = x0;
dX = abs(Xo2 - Xo1);


Y2 = yMax + yShift;
Y1 = yMin + yShift;
dY = Y2 - Y1;

% Не делаем автомасштабирования. Оставляем данную опцию для функции mReCalcPeakRegion
% B.hgrReal(2) = Y2 + 0.05*dY;
% B.hgrReal(1) = Y1 - 0.05*dY;

% После найденного максимума:
% Проверяем все найденные пики на совпадение, чтобы данные не дублировались
% понапрасну
if i > 1
    % Делаем просмотр всех пиков кроме текущего.
    
    k2 = 1:length(B.Curve(cn).Peak);
%     kk = k2(~ismember(k2,i));
    kk = find(k2 ~= i);
    for k = 1:length(kk)
        
        if abs( B.Curve(cn).Peak(kk(k)).Xo1 - Xo1 ) < 3*abs( B.x(2)-B.x(1) )
            % ---------------------------необходимо удалить данный пик!!!!
            % либо предложить сделать что-то другое
            disp(i)
            return;
        end
    end
end
% Если измененный регион по параметрам не совпал с другими регионами, то
% продолжаем работу

% Обновляем реперную точку проверки
B.Curve(cn).Peak(i).Xo1 = Xo1;
% Высчитываем новое положение окна региона
OX_length = abs(B.Curve(cn).Peak(i).RegionSearchCoord(2) - B.Curve(cn).Peak(i).RegionSearchCoord(1))/0.9;

% Не делаем автомасштабирования. Оставляем данную опцию для функции mReCalcPeakRegion
% B.wgrReal(2) = (B.Curve(cn).Peak(i).RegionSearchCoord(2) + B.Curve(cn).Peak(i).RegionSearchCoord(1))*0.5 + OX_length*0.5;
% B.wgrReal(1) = (B.Curve(cn).Peak(i).RegionSearchCoord(2) + B.Curve(cn).Peak(i).RegionSearchCoord(1))*0.5 - OX_length*0.5;
B.Curve(cn).Peak(i).RegionPozition = B.wgrReal;
B.Curve(cn).Peak(i).RegionHeight = B.hgrReal;

% Номера выбранных в массиве значений ЭПР спектра точек, которые попали в
% данный регион
B.Curve(cn).Peak(i).SelectedNumPointsByRegion = find(B.x >= B.Curve(cn).Peak(i).RegionSearchCoord(1) & B.x <= B.Curve(cn).Peak(i).RegionSearchCoord(2));
ii = B.Curve(cn).Peak(i).SelectedNumPointsByRegion;

x = B.Curve(cn).Peak(i).RegionSearchCoord(1);
y = B.hgrReal(1);
w = 0.9*OX_length;
h = B.hgrReal(2) - B.hgrReal(1);
    B.Curve(cn).Peak(i).h_RegionBox_xv =   [x; (x+w); (x+w); x];
    B.Curve(cn).Peak(i).h_RegionBox_yv =   [y; y; (y+h); (y+h)];

    
% Значение площади зоны пика, для сравнения с площадью зоны окна просмотра
% и дальнейшего управления видимостью текстовых элементов данной кривой в
% зависимости от соотношения величин их масштабов.
B.Curve(cn).Peak(i).RegionBoxArea = w*dY;

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
    
% Обнавляем величину смещения средней линии (точки разницы высот минимума и максимума)
B.Curve(cn).Peak(i).yShift = yShift;
% Обнавляем уровень фона для данного пика:
B.Curve(cn).Peak(i).BaseLine =  yShift;

    % Рисуем площадь под кривой в выбранном регионе:
x = B.Curve(cn).Peak(i).RegionSearchCoord(1);
w = 0.9*OX_length;
ye = interp1(B.x,B.y,(x+w));
ys = interp1(B.x,B.y,x);
    B.Curve(cn).Peak(i).h_CurveArea_xv =   [B.x(ii); (x+w); (x+w);x ;x];
    B.Curve(cn).Peak(i).h_CurveArea_yv =   [B.y(ii); ye; yShift; yShift; ys];
    
% x,y координаты первого пика - Максимума (пик находится слева)
B.Curve(cn).Peak(i).P1.Coor = [xMax, yMax + yShift];
B.Curve(cn).Peak(i).P1.CoorLocal = [xMax, yMax];
B.Curve(cn).Peak(i).P1.hText_Pos = [B.Curve(cn).Peak(i).P1.Coor(1), B.Curve(cn).Peak(i).P1.Coor(2)];
B.Curve(cn).Peak(i).P1.hLineVert_xv = [xMax, xMax];
B.Curve(cn).Peak(i).P1.hLineVert_yv = [yShift, yMax + yShift];

% x,y координаты второго пика
B.Curve(cn).Peak(i).P2.Coor = [xMin, yMin + yShift];
B.Curve(cn).Peak(i).P2.CoorLocal = [xMin, yMin];
Xc = B.Curve(cn).Peak(i).P2.Coor(1) - 0.35*dX;
B.Curve(cn).Peak(i).P2.hText_Pos = [Xc, B.Curve(cn).Peak(i).P2.Coor(2)];
B.Curve(cn).Peak(i).P2.hLineVert_xv = [xMin, xMin];
B.Curve(cn).Peak(i).P2.hLineVert_yv = [yShift, yMin + yShift];


% Объекты ручной настройки положения точек на графике:
B.Curve(cn).Peak(i).ManualTune.P1.Coor_ = [xMax, yMax + yShift];
B.Curve(cn).Peak(i).ManualTune.P1.CoorLocal = [xMax, yMax];
B.Curve(cn).Peak(i).ManualTune.P2.Coor_ = [xMin, yMin + yShift];
B.Curve(cn).Peak(i).ManualTune.P2.CoorLocal = [xMin, yMin];

% Положение линии – Вo – соответствует пересечению контура производной dI/dB с нулевой линией (линией тренда);
B.Curve(cn).Peak(i).Bo.Coor = x0;
dX = abs(dX);
B.Curve(cn).Peak(i).Bo.hLineVert_xv = [x0, x0];
B.Curve(cn).Peak(i).Bo.hLineVert_yv = [yMin + yShift, yMax + yShift];
% Рисуем жирную линию, проходящую через центр Bo
if xMax < xMin
    B.Curve(cn).Peak(i).Bo.hLineHorzTop_xv = [xMax - dX*0.15, x0 + dX*0.15];
    B.Curve(cn).Peak(i).Bo.hLineHorzTop_yv = [yMax + yShift, yMax + yShift];

    B.Curve(cn).Peak(i).Bo.hLineHorzBot_xv = [x0 - dX*0.15, xMin + dX*0.15];
    B.Curve(cn).Peak(i).Bo.hLineHorzBot_yv = [yMin + yShift, yMin + yShift];
else 
    B.Curve(cn).Peak(i).Bo.hLineHorzTop_xv = [xMax + dX*0.15, x0 - dX*0.15];
    B.Curve(cn).Peak(i).Bo.hLineHorzTop_yv = [yMax + yShift, yMax + yShift];

    B.Curve(cn).Peak(i).Bo.hLineHorzBot_xv = [x0 + dX*0.15, xMin - dX*0.15];
    B.Curve(cn).Peak(i).Bo.hLineHorzBot_yv = [yMin + yShift, yMin + yShift];
    
end
 Yc = (yShift) - 0.05*abs(yMax - yMin);
 Xc = x0 - dX*0.05;
B.Curve(cn).Peak(i).Bo.hText_Pos = [Xc, Yc];

% Амплитуда линии – Imax – соответствует по шкале амплитуды сигнала расстоянию между экстремумами на кривой линии;
B.Curve(cn).Peak(i).Imax.Coor = abs(yMax - yMin);
 Yc = (yShift) + 0.4*abs(yMax - yMin);
 Xc = x0 + dX*0.05;
B.Curve(cn).Peak(i).Imax.hText_Pos = [Xc, Yc];


% Ширина линии – dВmax – cоответствует расстоянию по полю между экстремумами на кривой линии;
B.Curve(cn).Peak(i).dBmax.Coor = abs(xMin - xMax);
 Yc = (yShift) + 0.02*abs(yMax - yMin);
 Xc = x0 + dX*0.1;
B.Curve(cn).Peak(i).dBmax.hText_Pos = [Xc, Yc];

B.Curve(cn).Peak(i).dBmax.hLine_xv = [xMax, xMin];
B.Curve(cn).Peak(i).dBmax.hLine_yv = [yShift, yShift];

% Интенсивность – Io – значение вероятности в точке МАХ на кривой поглощения, вычисляется при интегрировании по контуру линии записи;
B.Curve(cn).Peak(i).Io.Coor = yMax;
 Yc = (yShift) + 0.1*abs(yMax - yMin);
 Xc = xMax - dX*0.05;
B.Curve(cn).Peak(i).Io.hText_Pos = [Xc, Yc];
% G-фактор:
B.Curve(cn).Peak(i).G.Coor = B.freq*1000/(1.39968*B.Curve(cn).Peak(i).Bo.Coor);
% Площадь под кривой
B.Curve(cn).Peak(i).Area.TotalVal = trapz( abs( B.y(B.Curve(cn).Peak(i).SelectedNumPointsByRegion) ) );
Xc = xMin - 0.25*dX;
Yc = (yShift) + 0.25*abs(yMax - yMin);
B.Curve(cn).Peak(i).Text.hText_Pos = [Xc, Yc];


% Обнавляем графические элементы с уже пересчитанными значениями
setappdata(B.hFig,'B',B);
mUpdateNewGraphDataForCurrentCurve(B);
B = getappdata(B.hFig,'B');



% setappdata(B.hFig,'B',B);
% mUpdateScaleVars (B);
% B = getappdata(B.hFig,'B');


 setappdata(B.hFig,'B',B);
end