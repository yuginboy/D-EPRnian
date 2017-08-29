function mSetJTableDataToMainBottomTableCurves(B, data)
% Записываем новые данные в ява-таблицу (createTable)
% B = getappdata(B.hFig,'B');

[nr,nc] = size(data);
if nr ~= B.ui_mainBottomTableCurves.h.NumRows
    B.ui_mainBottomTableCurves.h.setNumRows (nr);
end
if nc ~= B.ui_mainBottomTableCurves.h.NumColumns
    B.ui_mainBottomTableCurves.h.setNumColumns (nc);
end
if nr > 0
    celColumnNames = {'<html><b>ID</b></html>',sprintf('<html><b>%s</b></html>',B.currentViewParameterCurve)};
    for i = 1 : nc-2
        celColumnNames{i+2} = sprintf('<html><center /><b>%d</b><br />%s</html>',i,B.currentViewParameterRegion);
    end
    %B.ui_mainBottomTableCurves.jtable.getTableHeader().setPreferredSize(java.awt.Dimension(64,64));
    %B.ui_mainBottomTableCurves.jtable.getTableHeader().setMinimumSize(java.awt.Dimension(225,128));
    B.ui_mainBottomTableCurves.h.setColumnNames(celColumnNames);
    
    %B.ui_mainBottomTableCurves.jtable.getColumnModel.getColumn(1).setWidth(250);
        
    %B.ui_mainBottomTableCurves.jtable.setAutoResizeMode(javax.swing.JTable.AUTO_RESIZE_ALL_COLUMNS);
end
%pause(0.1);
for i = 1 : nr
    for j = 1 : nc
        val = data{i,j};
        if ~isempty(val)
            if isfloat(val)
                if j == 1
                    %B.ui_mainBottomTableCurves.jtable.setValueAt(java.lang.Integer(val),i-1,j-1);
                    %disp(val);
                    B.ui_mainBottomTableCurves.jtable.setValueAt(java.lang.String(sprintf('%d',val)),i-1,j-1);
                else
                    %B.ui_mainBottomTableCurves.jtable.setValueAt(java.lang.Double(val),i-1,j-1);
                    B.ui_mainBottomTableCurves.jtable.setValueAt(java.lang.String(sprintf('%0.7g',val)),i-1,j-1);
                end
            end
            if iscellstr(data(i,j))
                B.ui_mainBottomTableCurves.jtable.setValueAt(java.lang.String(data{i,j}),i-1,j-1);
            end
        end
    end
end

if nr > 0
    B.ui_mainBottomTableCurves.jtable.getColumnModel.getColumn(0).setMaxWidth(80);
    if strcmp(B.currentViewParameterCurve,'Curve Name')
        B.ui_mainBottomTableCurves.jtable.getColumnModel.getColumn(1).setMinWidth(200);
    end
    if strcmp(B.currentViewParameterCurve,'Angle')
        B.ui_mainBottomTableCurves.jtable.getColumnModel.getColumn(1).setMinWidth(80);
    end
    if nc >= 2
        for ic = 2 : nc-1
            B.ui_mainBottomTableCurves.jtable.getColumnModel.getColumn(ic).setMinWidth(120);
        end
    end
    %B.jTableColorRender.setBackground(java.awt.Color(0.5451,0.6000,0.6353));
    for i = 0: nc-1
        if mod(i,2)==1
            B.ui_mainBottomTableCurves.jtable.getColumnModel.getColumn(i).setCellRenderer(B.jTableColorRender_1);
        else
            B.ui_mainBottomTableCurves.jtable.getColumnModel.getColumn(i).setCellRenderer(B.jTableColorRender_2);
        end
        
    end
    B.ui_mainBottomTableCurves.jtable.setGridColor(java.awt.Color(0.3,0.3,0.3))
    % Порой матлаба перестает видеть структуры. Может это из-за нехватки
    % скорости обработки событий, не знаю. Сделал задержку.
    pause(0.1);
end

% setappdata(B.hFig,'B',B);
end