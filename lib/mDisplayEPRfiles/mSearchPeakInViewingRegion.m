function mSearchPeakInViewingRegion (B)
% Функция поиска ЭПР пиков в заданной области просмотра графика
% Данная функция делает проверку на совпадение с уже редактировавшимися
% ранее кривыми. 

axes(B.hAxes);
hold on;
cn = 1;

% Проверяем, если кривая из серии "две точки", которая рисуется в случае
% захода в папку, в которой нет рабочих файлов с EPR спектрами, то выходим
% без выполнениякаких либо действий
if strcmp(B.currentCurveFullFileName, 'filename')
    return
end

check = isfield(B,'Curve');
if ~check
    cn = 1;
else
    while cn <= length(B.Curve)
        % Проверяем не является ли текущая кривая уже обработанной ранее 
        chk = mCompareDataWithCurrentCurve (B, cn);
        if chk
            %cn = cn - 1;
            mVisibleGraphElementsForAllCurves (B,'off');
            mVisibleGraphElementsForCurrentCurve (B, 'on');
            break;
        end
        cn = cn + 1;
    end
    
end
B = mSaveDataToCurrentCurve (B, cn);

% Проверяем наличие массива пиков для данной кривой(делалась ли данная процедура для данного графика)
check = isfield(B.Curve,'Peak');
if ~check
    i = 1;
else
    i = length(B.Curve(cn).Peak) + 1;
end



% Размер по оси ОХ (разница между максимальной правой и минимально левой ОХ координатой в окошке графика)
OX_length = abs(B.wgr);
% Диапазон анализа пика
% Задаю как регион с отступами по 5% (от размера по ОХ) от каждой из сторон отображаемой зоны
% во вьювере окна графика
RegionSearchCoord = [(B.wgrReal(1) + 0.05*OX_length),  (B.wgrReal(2) - 0.05*OX_length)];

% Ищем максимум и минимум на данном отрезке:
ii = find(B.x >= RegionSearchCoord(1) & B.x <= RegionSearchCoord(2));
Y2 = max(max(B.y(ii)));

[x0, xMax, yMax, xMin, yMin, yShift] = mFindNextMinimumAndXinterceptPoint (B.x,B.y, Y2);

if x0 == 0 && xMax == 0 && xMin == 0
    return;
end

Y2 = yMax + yShift;
Y1 = yMin + yShift;
dY = Y2 - Y1;
B.hgrReal(2) = Y2 + 0.05*dY;
B.hgrReal(1) = Y1 - 0.05*dY;

% Центрируем в окне вьювера найденный в данном регионе пик
Xo1 = xMax;
Xo2 = xMin;
Xo = x0;
dX = abs(Xo2 - Xo1);
B.wgrReal = [Xo - 1*dX, Xo + 1*dX];
set(B.hAxes, 'XLim', B.wgrReal, 'YLim', B.hgrReal);

setappdata(B.hFig,'B',B);
mUpdateScaleVars (B);
B = getappdata(B.hFig,'B');

% Проверяем все найденные пики на совпадение, чтобы данные не дублировались
% понапрасну
if i > 1
for k = 1:length(B.Curve(cn).Peak)
    if abs( B.Curve(cn).Peak(k).Xo1 - Xo1 ) < 3*abs( B.x(2)-B.x(1) )
        
        hold off;% Обязательно делаем это, чтобы не плодить на графике лишних линий
        set(B.hAxes, 'xLim', B.Curve(cn).Peak(k).RegionPozition);
        setappdata(B.hFig,'B',B);
        mUpdateScaleVars (B);
        B = getappdata(B.hFig,'B');
        return;
    end
end
end
% Делаем реперную точку проверки
B.Curve(cn).Peak(i).Xo1 = Xo1;

% Перезаписываем новые координаты в соответствующие переменные:
% Размер по оси ОХ (разница между максимальной правой и минимально левой ОХ координатой в окошке графика)
OX_length = abs(B.wgrReal(2) - B.wgrReal(1));
% Положение региона в окне для отображения данных, чтобы впоследствии можно
% было центрировать окно с графиком, когда выбирается заданный пик из
% таблицы пиков
B.Curve(cn).Peak(i).RegionPozition = B.wgrReal;
B.Curve(cn).Peak(i).RegionHeight = B.hgrReal;
% Диапазон анализа пика
% Задаю как регион с отступами по 5% (от размера по ОХ) от каждой из сторон отображаемой зоны
% во вьювере окна графика
B.Curve(cn).Peak(i).RegionSearchCoord = [(B.wgrReal(1) + 0.05*OX_length),  (B.wgrReal(2) - 0.05*OX_length)];


% Проверяем на концовые совпадение конечных точек в регионе с крайними
% точками на графике:
if B.Curve(cn).Peak(i).RegionSearchCoord(1)< B.x(1)
    B.Curve(cn).Peak(i).RegionSearchCoord(1) = B.x(1);
end
if B.Curve(cn).Peak(i).RegionSearchCoord(2)> B.x(end)
    B.Curve(cn).Peak(i).RegionSearchCoord(2) = B.x(end);
end

% Задаем это значение для параметра, который будет необходим как стартовая
% точка отсчета во время редактирования региона с помощью движений мышки.
% Изменение положения нового региона будут проводится в такой способ, что
% будут менятся значения RegionSearchCoord как сумма RegionSearchCoordOld и
% некого параметра сдвижки dx. После того, как левая кнопка мышки
% отпускается, то происходит переопределение данного параметра точно также
% как и здесь:
B.Curve(cn).Peak(i).RegionSearchCoordOld = B.Curve(cn).Peak(i).RegionSearchCoord;
% В mReCalcPeakRegion (B) этот параметр трогать нельзя! т.к. тогда не будет
% работать подсчет правильного смещения.


% Для пропагирования свойств на совершенно различные спектры, когда
% диапазон измерений не будет совпадать, создаем относительные координаты
% региона поиска, зависящие от длины спетра:
B.Curve(cn).Peak(i).RegionSearchCoordRelative = (B.Curve(cn).Peak(i).RegionSearchCoord - B.x(1))/abs(B.x(end) - B.x(1));
B.Curve(cn).Peak(i).RegionSearchCoordRelativeOld = B.Curve(cn).Peak(i).RegionSearchCoordRelative;




OX_length = abs(B.Curve(cn).Peak(i).RegionSearchCoord(2) - B.Curve(cn).Peak(i).RegionSearchCoord(1))/0.9;
B.wgrReal(2) = (B.Curve(cn).Peak(i).RegionSearchCoord(2) + B.Curve(cn).Peak(i).RegionSearchCoord(1))*0.5 + OX_length*0.5;
B.wgrReal(1) = (B.Curve(cn).Peak(i).RegionSearchCoord(2) + B.Curve(cn).Peak(i).RegionSearchCoord(1))*0.5 - OX_length*0.5;
B.Curve(cn).Peak(i).RegionPozition = B.wgrReal;

% Номера выбранных в массиве значений ЭПР спектра точек, которые попали в
% данный регион
B.Curve(cn).Peak(i).SelectedNumPointsByRegion = find(B.x >= B.Curve(cn).Peak(i).RegionSearchCoord(1) & B.x <= B.Curve(cn).Peak(i).RegionSearchCoord(2));
ii = B.Curve(cn).Peak(i).SelectedNumPointsByRegion;

x = B.Curve(cn).Peak(i).RegionSearchCoord(1);
y = B.hgrReal(1);
w = 0.9*OX_length;
h = B.hgrReal(2) - B.hgrReal(1);
B.Curve(cn).Peak(i).RegionBoxFaceColor = [0.8, 0.9 , 0.3];
B.Curve(cn).Peak(i).h_RegionBox = patch('XData',[x; (x+w); (x+w); x],'YData',[y; y; (y+h); (y+h)],...
        'EdgeColor', [0.1,0.5,0.7],'LineStyle','--', 'FaceColor', B.Curve(cn).Peak(i).RegionBoxFaceColor, 'FaceAlpha', 0.1);

    %Задаем дополнительные переменные, чтобы не делать дополнительный вызов
    %функции get для задания области в которой впоследствии будем
    %отслеживать нажатие мышки
B.Curve(cn).Peak(i).h_RegionBox_xv =   [x; (x+w); (x+w); x];
B.Curve(cn).Peak(i).h_RegionBox_yv =   [y; y; (y+h); (y+h)];

% Значение площади зоны пика, для сравнения с площадью зоны окна просмотра
% и дальнейшего управления видимостью текстовых элементов данной кривой в
% зависимости от соотношения величин их масштабов.
B.Curve(cn).Peak(i).RegionBoxArea = w*h;

% Название пика, которое может быть задано любым другим именем. По
% умолчанию есть порядковый номер пика:
B.Curve(cn).Peak(i).Tag.Name = num2str(i);
Xc = x + 0.5*(B.Curve(cn).Peak(i).RegionSearchCoord(2) - B.Curve(cn).Peak(i).RegionSearchCoord(1));
Yc = (y+h);
B.Curve(cn).Peak(i).Tag.hText_Pos = [Xc, Yc];
B.Curve(cn).Peak(i).Tag.hText = text(Xc, Yc, [B.Curve(cn).TagName, ' : ', B.Curve(cn).Peak(i).Tag.Name],'Clipping','on');
set(B.Curve(cn).Peak(i).Tag.hText, 'BackgroundColor',...
    B.Curve(cn).Peak(i).RegionBoxFaceColor+ 0.6*(1-B.Curve(cn).Peak(i).RegionBoxFaceColor),'FontName',B.figFontName);

% Рисуем левую управляющую ручку для изменения размера региона с помощью
% мышки
w = 0.05*( B.wgr );
x = x - w;
B.Curve(cn).Peak(i).hL_RegionBox = patch('XData',[x; (x+w); (x+w); x],'YData',[y; y; (y+h); (y+h)],...
        'EdgeColor', [0.1,0.5,0.7],'LineStyle','-', 'FaceColor', [0.1,0.5,0.7], 'FaceAlpha', 0.5);
    B.Curve(cn).Peak(i).hL_RegionBox_xv =   [x; (x+w); (x+w); x];
    B.Curve(cn).Peak(i).hL_RegionBox_yv =   [y; y; (y+h); (y+h)];

x = B.Curve(cn).Peak(i).RegionSearchCoord(2);
B.Curve(cn).Peak(i).hR_RegionBox = patch('XData',[x; (x+w); (x+w); x],'YData',[y; y; (y+h); (y+h)],...
        'EdgeColor', [0.1,0.5,0.7],'LineStyle','-', 'FaceColor', [0.1,0.5,0.7], 'FaceAlpha', 0.5);
    B.Curve(cn).Peak(i).hR_RegionBox_xv =   [x; (x+w); (x+w); x];
    B.Curve(cn).Peak(i).hR_RegionBox_yv =   [y; y; (y+h); (y+h)];

% Записываем величину смещения средней линии (точки разницы высот минимума и максимума)
B.Curve(cn).Peak(i).yShift = yShift;
% Задаем уровень фона для данного пика:
B.Curve(cn).Peak(i).BaseLine =  yShift;
    
% Рисуем площадь под кривой в выбранном регионе:
x = B.Curve(cn).Peak(i).RegionSearchCoord(1);
w = 0.9*OX_length;
ye = interp1(B.x,B.y,(x+w));
ys = interp1(B.x,B.y,x);
B.Curve(cn).Peak(i).h_CurveArea = patch('XData',[B.x(ii); (x+w); (x+w);x ;x],'YData',[B.y(ii); ye; yShift; yShift; ys],...
        'EdgeColor', [0.1,0.5,0.7],'LineStyle','-', 'FaceColor', [0.9,0.5,0.7], 'FaceAlpha', 0.5);
    B.Curve(cn).Peak(i).h_CurveArea_xv =   [B.x(ii); (x+w); (x+w);x ;x];
    B.Curve(cn).Peak(i).h_CurveArea_yv =   [B.y(ii); ye; yShift; yShift; ys];
    
% x,y координаты первого пика - Максимума (пик находится слева)
B.Curve(cn).Peak(i).P1.Coor = [xMax, yMax + yShift];
B.Curve(cn).Peak(i).P1.CoorLocal = [xMax, yMax];

% Рисуем стрелку с данными по пику:
str1 = sprintf(' B = %0.7g Oe, I = %0.7g a.u.\n', B.Curve(cn).Peak(i).P1.Coor(1), B.Curve(cn).Peak(i).P1.Coor(2));
% str1 = ['\leftarrow', str1];
B.Curve(cn).Peak(i).P1.hText = text(B.Curve(cn).Peak(i).P1.Coor(1), B.Curve(cn).Peak(i).P1.Coor(2),str1,'Clipping','on');
B.Curve(cn).Peak(i).P1.hText_Pos = [B.Curve(cn).Peak(i).P1.Coor(1), B.Curve(cn).Peak(i).P1.Coor(2)];

B.Curve(cn).Peak(i).P1.hLineVert = plot([xMax, xMax], [yShift, yMax + yShift],'--' ,'Color', [1,0,0]/4, 'LineWidth', 1.5);
B.Curve(cn).Peak(i).P1.hLineVert_xv = [xMax, xMax];
B.Curve(cn).Peak(i).P1.hLineVert_yv = [yShift, yMax + yShift];

% x,y координаты второго пика
B.Curve(cn).Peak(i).P2.Coor = [xMin, yMin + yShift];
B.Curve(cn).Peak(i).P2.CoorLocal = [xMin, yMin];
% Рисуем стрелку с данными по пику:
str1 = sprintf('\n B = %0.7g Oe, I = %0.7g a.u.', B.Curve(cn).Peak(i).P2.Coor(1), B.Curve(cn).Peak(i).P2.Coor(2));
% str1 = ['\leftarrow', str1];
Xc = B.Curve(cn).Peak(i).P2.Coor(1) - 0.35*dX;
B.Curve(cn).Peak(i).P2.hText = text(Xc, B.Curve(cn).Peak(i).P2.Coor(2),str1,'Clipping','on');
B.Curve(cn).Peak(i).P2.hText_Pos = [Xc, B.Curve(cn).Peak(i).P2.Coor(2)];

B.Curve(cn).Peak(i).P2.hLineVert = plot([xMin, xMin], [yShift, yMin + yShift],'--' ,'Color', [1,0,0]/4, 'LineWidth', 1.5);
B.Curve(cn).Peak(i).P2.hLineVert_xv = [xMin, xMin];
B.Curve(cn).Peak(i).P2.hLineVert_yv = [yShift, yMin + yShift];


% Объекты ручной настройки положения точек на графике:
B.Curve(cn).Peak(i).ManualTune.P1.Coor_ = [xMax, yMax + yShift];
B.Curve(cn).Peak(i).ManualTune.P1.CoorLocal = [xMax, yMax];
B.Curve(cn).Peak(i).ManualTune.P2.Coor_ = [xMin, yMin + yShift];
B.Curve(cn).Peak(i).ManualTune.P2.CoorLocal = [xMin, yMin];
B.Curve(cn).Peak(i).ManualTune.Bo.Coor = (xMax+xMin)/2;
% B.Curve(cn).Peak(i).ManualTune.Bo.Graph = mPlotLineWithTwoHandles ([xMin,xMax], [yMin,yMax] + yShift, B);

% datacursormode (B.hFig);
% Положение линии – Вo – соответствует пересечению контура производной dI/dB с нулевой линией (линией тренда);
B.Curve(cn).Peak(i).Bo.Coor = x0;
% Рисуем жирную линию, проходящую через центр Bo
B.Curve(cn).Peak(i).Bo.hLineVert = plot([x0, x0], [yMin + yShift, yMax + yShift], 'Color', [1,1,1]/4, 'LineWidth', 1.5);
B.Curve(cn).Peak(i).Bo.hLineVert_xv = [x0, x0];
B.Curve(cn).Peak(i).Bo.hLineVert_yv = [yMin + yShift, yMax + yShift];

B.Curve(cn).Peak(i).Bo.hLineHorzTop = plot([xMax - dX*0.15, x0 + dX*0.15], [yMax + yShift, yMax + yShift], 'Color', [1,1,1]/4, 'LineWidth', 1);
B.Curve(cn).Peak(i).Bo.hLineHorzTop_xv = [xMax - dX*0.15, x0 + dX*0.15];
B.Curve(cn).Peak(i).Bo.hLineHorzTop_yv = [yMax + yShift, yMax + yShift];

B.Curve(cn).Peak(i).Bo.hLineHorzBot = plot([x0 - dX*0.15, xMin + dX*0.15], [yMin + yShift, yMin + yShift], 'Color', [1,1,1]/4, 'LineWidth', 1);
B.Curve(cn).Peak(i).Bo.hLineHorzBot_xv = [x0 - dX*0.15, xMin + dX*0.15];
B.Curve(cn).Peak(i).Bo.hLineHorzBot_yv = [yMin + yShift, yMin + yShift];

% if yShift >=0
%     Yc = (yShift) + 0.05*abs(yMax - yMin);
%     coeff = 1.75;
% else
%     Yc = (yShift) + 0.05*abs(yMax - yMin);
%     coeff = 2.25;
% 
% end

str1 = sprintf(' Bo = %0.7g Oe', B.Curve(cn).Peak(i).Bo.Coor);
 Yc = (yShift) - 0.05*abs(yMax - yMin);
 Xc = x0 - dX*0.05;
B.Curve(cn).Peak(i).Bo.hText = text(Xc, Yc, str1,'Clipping','on', 'Rotation', 90, 'HorizontalAlignment', 'right');
B.Curve(cn).Peak(i).Bo.hText_Pos = [Xc, Yc];
% Амплитуда линии – Imax – соответствует по шкале амплитуды сигнала расстоянию между экстремумами на кривой линии;
B.Curve(cn).Peak(i).Imax.Coor = abs(yMax - yMin);
str1 = sprintf(' I_{max} = %0.7g a.u.', B.Curve(cn).Peak(i).Imax.Coor);
 Yc = (yShift) + 0.4*abs(yMax - yMin);
 Xc = x0 + dX*0.05;
B.Curve(cn).Peak(i).Imax.hText = text(Xc,  Yc, str1,'Clipping','on', 'Rotation', -90);
B.Curve(cn).Peak(i).Imax.hText_Pos = [Xc, Yc];

% Ширина линии – dВmax – cоответствует расстоянию по полю между экстремумами на кривой линии;
B.Curve(cn).Peak(i).dBmax.Coor = abs(xMin - xMax);
B.Curve(cn).Peak(i).dBmax.hLine = plot([xMax, xMin], [yShift, yShift], 'Color', [1,1,1]/4, 'LineWidth', 1.5);
B.Curve(cn).Peak(i).dBmax.hLine_xv = [xMax, xMin];
B.Curve(cn).Peak(i).dBmax.hLine_yv = [yShift, yShift];

str1 = sprintf(' dB_{max} = %0.7g Oe', B.Curve(cn).Peak(i).dBmax.Coor);
 Yc = (yShift) + 0.02*abs(yMax - yMin);
 Xc = x0 + dX*0.1;
B.Curve(cn).Peak(i).dBmax.hText = text(Xc, Yc, str1,'Clipping','on');
B.Curve(cn).Peak(i).dBmax.hText_Pos = [Xc, Yc];

% Интенсивность – Io – значение вероятности в точке МАХ на кривой поглощения, вычисляется при интегрировании по контуру линии записи;
B.Curve(cn).Peak(i).Io.Coor = yMax;
str1 = sprintf(' I_{0} = %0.7g a.u.', B.Curve(cn).Peak(i).Io.Coor);
 Yc = (yShift) + 0.1*abs(yMax - yMin);
 Xc = xMax - dX*0.05;
B.Curve(cn).Peak(i).Io.hText = text(Xc,  Yc, str1,'Clipping','on', 'Rotation', 90);
B.Curve(cn).Peak(i).Io.hText_Pos = [Xc, Yc];
% G-фактор:
B.Curve(cn).Peak(i).G.Coor = B.freq*1000/(1.39968*B.Curve(cn).Peak(i).Bo.Coor);
% Площадь под кривой
B.Curve(cn).Peak(i).Area.TotalVal = trapz( abs( B.y(B.Curve(cn).Peak(i).SelectedNumPointsByRegion) ) );

str1 = sprintf(' G = %0.7g\n Area = %0.7e\n \\DeltaB = %0.7g Oe\n I_{max} = %0.7g a.u.\n B_{0} = %0.7g Oe', ...
               B.Curve(cn).Peak(i).G.Coor, B.Curve(cn).Peak(i).Area.TotalVal, B.Curve(cn).Peak(i).dBmax.Coor, B.Curve(cn).Peak(i).Imax.Coor, B.Curve(cn).Peak(i).Bo.Coor);
Xc = xMin - 0.25*dX;
Yc = (yShift) + 0.25*abs(yMax - yMin);
B.Curve(cn).Peak(i).Text.hText = text(Xc, Yc, str1,'Clipping','on', 'FontSize', 13, 'FontWeight', 'bold',...
    'BackgroundColor', [255, 239, 209]/255, 'EdgeColor', [20, 134, 100]/255, 'LineWidth', 1);
B.Curve(cn).Peak(i).Text.hText_Pos = [Xc, Yc];

% Уникальная информация о пике:





uistack(B.Curve(cn).Peak(i).Tag.hText, 'top');
B.currentCurveNumber = cn;
B.currentPeakNumber = i;

setappdata(B.hFig,'B',B);
mUpdateScaleVars (B);
B = getappdata(B.hFig,'B');

setappdata(B.hFig,'B',B);
mWriteDataToMainBottomTableCurves (B);
B = getappdata(B.hFig,'B');
setappdata(B.hFig,'B',B);
mWriteDataToMainBottomTableRegion (B);
B = getappdata(B.hFig,'B');

hold off;
setappdata(B.hFig,'B',B);
end