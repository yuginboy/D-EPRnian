function mReScaleMainTablesForCurvesWithRegions(B)
% Функция автомасштабирования ранее созданных таблиц для отображения в строках всех
% кривых, для которых происходила процедура поиска пика и создания региона/ов.
% Данные таблицы будут отображаться под графиком, расположенном на главной
% закладке.
% Создаем 2 таблицы:
% --- главная таблица со списком всех кривых на которых были созданы регионы по
% поиску пиков -> B.ui_mainBottomTableCurves
% --- и второстепенная таблица, в которой раскрываются все управляющие
% параметры, характерные для данного региона/пика/линии ->
% B.ui_mainBottomTableRegion
%
B = getappdata(B.hFig,'B');

hAxesPosition = get(B.hAxes, 'Position');
% disp(hAxesPosition);
hHideTableButtonPosition = get(B.tb_hideTable, 'Position');
% disp(hHideTableButtonPosition);
ht_filenamePosition = get(B.ht_filename, 'Position');
% disp(ht_filenamePosition);
lb_structPosition = get(B.lb_struct, 'Position');
% disp(lb_structPosition);

% =================

width = hAxesPosition(3) - B.btLongTypeSize(1) - B.btSmallTypeSize(1);
x = hAxesPosition(1);
height = hHideTableButtonPosition(2) - hHideTableButtonPosition(4) - 2*B.btDstBtw - (ht_filenamePosition(4) + ht_filenamePosition(2));
y = (ht_filenamePosition(4) + ht_filenamePosition(2)) + B.btDstBtw;

set(B.ui_mainBottomTableCurves.h, 'Position',[x, y, width, height]);

% =================
xRightConer_bigTable = (x +width);
width = (lb_structPosition(1) + lb_structPosition(3)) - xRightConer_bigTable - B.btSmallTypeSize(1);
x = xRightConer_bigTable + B.btSmallTypeSize(1);
height = hHideTableButtonPosition(2) - hHideTableButtonPosition(4) - 2*B.btDstBtw - (ht_filenamePosition(4) + ht_filenamePosition(2));
y = (ht_filenamePosition(4) + ht_filenamePosition(2)) + B.btDstBtw;

set(B.ui_mainBottomTableRegion.h, 'Position',[x, y, width, height]);


setappdata(B.hFig,'B',B);
end