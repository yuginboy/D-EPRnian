function mCreateMainTablesForCurvesWithRegions(B)
% Функция создания и построения таблиц для отображения в строках всех
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

columnName = {'ID','Curve Name'};
columnFormat = {'numeric','char',[],[]};
ii = 1:5;
rowName = num2cell(ii);
for i = 1:5
    columnName(2+i) = num2cell(i);
end
data = {'none', 'none'};
hAxesPosition = get(B.hAxes, 'Position');
% disp(hAxesPosition);
hHideTableButtonPosition = get(B.tb_hideTable, 'Position');
% disp(hHideTableButtonPosition);
ht_filenamePosition = get(B.ht_filename, 'Position');
% disp(ht_filenamePosition);
lb_structPosition = get(B.lb_struct, 'Position');
% disp(lb_structPosition);

width = hAxesPosition(3) - B.btLongTypeSize(1) - B.btSmallTypeSize(1);
x = hAxesPosition(1);
height = hHideTableButtonPosition(2) - hHideTableButtonPosition(4) - 2*B.btDstBtw - (ht_filenamePosition(4) + ht_filenamePosition(2));
y = (ht_filenamePosition(4) + ht_filenamePosition(2)) + B.btDstBtw;

% B.ui_mainBottomTableCurves.Color = [200, 230, 219]/255;% B.hAxesColor
B.ui_mainBottomTableCurves.Data = data;           
% Стандартная заготовка для создания таблицы значений в Матлабе очень мало
% имеет возможностей по собственной настройке. Так отсутствует возможность
% сделать нередактируемыми лишь некоторые поля у таблицы а не целый
% столбец.
% B.ui_mainBottomTableCurves.h = uitable('parent', B.tab_main,...
%                'Units','Pixels',...
%                'Data', data,...
%                'Position',[x, y, width, height],...
%                'SelectionHighlight', 'off',...
%             'ColumnName', columnName,...
%             'ColumnFormat', columnFormat,...
%             'RowName', rowName,...
%             'RearrangeableColumns', 'on',...
%                'TooltipString','Table with data for the Curves and Regions with Peaks/Lines ');
           

           
B.ui_mainBottomTableCurves.h = fCreateTable('Container', B.tab_main,...
               'Units','Pixels',...
               'Position',[x, y, width, height],...
               'Headers',{'ID','Curve Name','1','2'},...
               'Data', {'1','eyryerer','1212','56435';'2','kfbjgf','675','89'},...
               'buttons', 'off','AutoResizeMode',0);
B.ui_mainBottomTableCurves.jtable = B.ui_mainBottomTableCurves.h.getTable; 
B.ui_mainBottomTableCurves.jtable.getColumnModel.getColumn(0).setMaxWidth(80);
% B.ui_mainBottomTableCurves.h.setEditable(1,false);
B.ui_mainBottomTableCurves.h.setEditable(false);
% renderer = B.ui_mainBottomTableCurves.jtable.getColumnModel.getColumn(1).getCellRenderer;
% renderer.setHorizontalAlignment(javax.swing.SwingConstants.RIGHT);
% Set width and height
% B.ui_hBottomnTable.Position(3) = B.ui_hBottomnTable.Extent(3);
% B.ui_hBottomnTable.Position(4) = B.ui_hBottomnTable.Extent(4);  
xRightConer_bigTable = (x +width);
width = (lb_structPosition(1) + lb_structPosition(3)) - xRightConer_bigTable - B.btSmallTypeSize(1);
x = xRightConer_bigTable + B.btSmallTypeSize(1);
height = hHideTableButtonPosition(2) - hHideTableButtonPosition(4) - 2*B.btDstBtw - (ht_filenamePosition(4) + ht_filenamePosition(2));
y = (ht_filenamePosition(4) + ht_filenamePosition(2)) + B.btDstBtw;

rowName = {'Curve ID','Curve Name','Angle','Start','End','BG Type', 'Av Width','Offset','G-faktor','Imax','Bo (Gs)','dB (Gs)','Area','Io',...
            'automatic:','left Bo', 'left Io', 'right Bo', 'right Io',...
            'manual:','left Bo', 'left Io', 'right Bo', 'right Io'};
Data = {'10','YAl_01_Ru_Angle_0_120_T_10K','0', '3370','3426','Linear', '0','48514','1.9747','3.3372e+6','3398.4','31.25','4.69e+7','1.67e+6',...
            '----------------------------------------','3386.2', '1.71e+6', '3417.5', '-1.63e+6',...
            '----------------------------------------','3386.2', '1.71e+6', '3417.5', '-1.63e+6'}';

B.ui_mainBottomTableRegion.Data = Data;
% B.ui_mainBottomTableRegion.h = uitable('parent', B.tab_main,...
%                'Units','Pixels',...
%                'Data', Data,...
%                'Position',[x, y, width, height],...
%                'SelectionHighlight', 'off',...
%             'ColumnName', {'Peak Values'}, 'ColumnWidth', {200},...
%             'ColumnFormat', columnFormat,...
%             'RowName', rowName,...
%                'TooltipString','Table with data for the Curves and Regions with Peaks/Lines ');

B.ui_mainBottomTableRegion.h = fCreateTable('Container', B.tab_main,...
               'Units','Pixels',...
               'Position',[x, y, width, height],...
               'Headers',{'Parameters','Peak Values'},...
               'Data', {'--','--'},...
               'buttons', 'off','AutoResizeMode',0, 'isSorter', 0);
B.ui_mainBottomTableRegion.jtable = B.ui_mainBottomTableRegion.h.getTable;
B.ui_mainBottomTableRegion.jtable.setMiddleSelectionEnabled(0);
set(B.ui_mainBottomTableRegion.jtable, 'MouseClickedCallback', @f_onClick);
% get(B.ui_mainBottomTableRegion.jtable);


% B.ui_mainBottomTableCurves.h.setEditable(1,false);
B.ui_mainBottomTableRegion.h.setEditable(false);


% Изменяем фон у таблицы:
B.jTableColorRender_1 = javax.swing.table.DefaultTableCellRenderer;
B.jTableColorRender_2 = javax.swing.table.DefaultTableCellRenderer;
B.jTableColorRender_3 = javax.swing.table.DefaultTableCellRenderer;
%cr.setForeground(java.awt.Color.red);
%B.jTableColorRender.setBackground(java.awt.Color(0.6784,0.6784,0.6471));
%B.jTableColorRender_1.setBackground(java.awt.Color(0.6902,0.7020,0.6118));
% Создаем палитру цветов:
% для таблицы кривых:
B.jTableColorRender_1.setBackground(java.awt.Color(0.5451,0.6000,0.6353));
B.jTableColorRender_2.setBackground(java.awt.Color(0.6451,0.7000,0.7353));
% для таблицы регионов:
B.jTableColorRender_3.setBackground(java.awt.Color(0.6451,0.7000,0.7353));
% B.ui_mainBottomTableRegion.jtable.getColumnModel.getColumn(1).setCellRenderer(B.jTableColorRender);

% mChgTxtStyleInMainBottomTableRegion(B.ui_mainBottomTableRegion);
% set(B.ui_mainBottomTableRegion.h, 'ButtonDownFcn',{@f_RegionButtonDownFcn});

setappdata(B.hFig,'B',B);
mWriteDataToMainBottomTableCurves (B);
B = getappdata(B.hFig,'B');

setappdata(B.hFig,'B',B);
mWriteDataToMainBottomTableRegion (B);
B = getappdata(B.hFig,'B');

setappdata(B.hFig,'B',B);
    function f_onClick (src,eventdata)
        B = getappdata(B.hFig,'B');
        
        %get(eventdata);
        % Обработака событий нажатия мышкой одинарного или двойного:
        click_type = get(eventdata,'ClickCount');
        switch click_type
            case 2 
                %fprintf('double-click\n');
                % По двойному нажатию мышки автомасштабируем кривую на графике
                cc = src.SelectedColumn();
                %disp(cc);
                cr = src.getSelectedRow();
                %disp(cr);
        
                setappdata(B.hFig,'B',B);
                    fTableRegionButtonDownFcn (B,cc,cr);
                B = getappdata(B.hFig,'B');
                
                % Обнавляем таблицу с данными для редактируемых кривых
                setappdata(B.hFig,'B',B);
                mWriteDataToMainBottomTableCurves (B);
                B = getappdata(B.hFig,'B');
        end
        setappdata(B.hFig,'B',B);
    end

end