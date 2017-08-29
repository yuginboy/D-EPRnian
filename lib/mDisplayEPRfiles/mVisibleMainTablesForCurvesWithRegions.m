function mVisibleMainTablesForCurvesWithRegions(B,ON_OFF)
% Функция управления видимостью/сокрытием ранее созданных таблиц для отображения в строках всех
% кривых, для которых происходила процедура поиска пика и создания региона/ов.
% Данные таблицы будут отображаться под графиком, расположенном на главной
% закладке.
%  2 таблицы:
% --- главная таблица со списком всех кривых на которых были созданы регионы по
% поиску пиков -> B.ui_mainBottomTableCurves
% --- и второстепенная таблица, в которой раскрываются все управляющие
% параметры, характерные для данного региона/пика/линии ->
% B.ui_mainBottomTableRegion
%
% ON_OFF = 'on/off'

% =================
switch ON_OFF
    case 'off'
        set(B.ui_mainBottomTableCurves.h, 'Visible',0);
        set(B.ui_mainBottomTableRegion.h, 'Visible',0);
    case 'on'
        set(B.ui_mainBottomTableCurves.h, 'Visible',1);
        set(B.ui_mainBottomTableRegion.h, 'Visible',1);
end
% set(B.ui_mainBottomTableCurves.h, 'Visible',ON_OFF);

% =================

% set(B.ui_mainBottomTableRegion.h, 'Visible',ON_OFF);


end