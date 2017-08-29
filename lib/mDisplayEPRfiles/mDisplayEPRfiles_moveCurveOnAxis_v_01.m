function mDisplayEPRfiles_moveCurveOnAxis_v_01(B)
% Меняем положение кривой относительно осей координат, иными словами просто
% тягаем кривую подбно тому, как происходит позиционирование объекта в 3ds
% Max по зажатой средней кнопке мышки
% Масштабируем оси по движению колесика мышки
B = getappdata(B.hFig,'B');

% set(B.hFig, 'Pointer', 'fleur');

B.wgrReal = get(B.hAxes,'XLim');
B.wgr = B.wgrReal(2) - B.wgrReal(1);
B.hgrReal = get(B.hAxes,'YLim');
B.hgr = B.hgrReal(2) - B.hgrReal(1);
x1 = B.wgrReal_start(1);
x2 = B.wgrReal_start(2);
y1 = B.hgrReal_start(1);
y2 = B.hgrReal_start(2);
% Текущие координаты курсора:
x = B.new_x ;
y = B.new_y ;
% Начальная позиция курсора сразу же после нажантия на кнопку мышки
x0 = B.start_x;
y0 = B.start_y;
dx = -(x-x0);
dy = -(y-y0);

    % new X coordinates
    B.wgrReal(1) = x1+dx;
    B.wgrReal(2) = x2+dx;
    B.wgrReal = sort(B.wgrReal);
    % new Y coordinates
    B.hgrReal(1) = y1+dy;
     B.hgrReal(2) = y2+dy;
    B.hgrReal = sort(B.hgrReal);

set(B.hAxes, 'XLim', B.wgrReal, 'YLim', B.hgrReal, 'XLimMode', 'manual', 'YLimMode', 'manual');

% Необходимо пересчитать точку, в которой произошло зажатие средней кнопки
% мышки в новых осях координат:
B.wgrReal_start(1) = x1+dx;
B.wgrReal_start(2) = x2+dx;
B.hgrReal_start(1) = y1+dy;
B.hgrReal_start(2) = y2+dy;



    setappdata(B.hFig,'B',B);
    mUpdateScaleVars (B);
    B = getappdata(B.hFig,'B');
% % B.wgrReal = get(B.hAxes,'XLim');
% % B.hgrReal = get(B.hAxes,'YLim');
% B.wgr = B.wgrReal(2) - B.wgrReal(1);
% B.hgr = B.hgrReal(2) - B.hgrReal(1);
% B.scw = B.waxe/B.wgr; % масштаб по x
% B.sch = B.haxe/B.hgr; % масштаб по y

setappdata(B.hFig,'B',B);
% % mDisplayEPRfiles_pltData_v_02(B);
mRedraw_pltData(B);
B = getappdata(B.hFig,'B');

setappdata(B.hFig,'B',B);
% pause(0.5);
end%end manualCorrectedExt_moveCurveOnAxis_setZero