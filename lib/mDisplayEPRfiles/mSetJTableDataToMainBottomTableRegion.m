function mSetJTableDataToMainBottomTableRegion(B, data)
% Записываем новые данные в ява-таблицу (createTable)
% B = getappdata(B.hFig,'B');

[nr,nc] = size(data);
celColumnNames = {'Parameters','Peak Values'};

B.ui_mainBottomTableRegion.h.setColumnNames(celColumnNames);
B.ui_mainBottomTableRegion.h.setNumColumns (nc)
B.ui_mainBottomTableRegion.h.setNumRows (nr);
pause(0.05);

for j = 1 : nc
    
    for i = 1 : nr
        val = data{i,j};
        %disp(sprintf('%d, %d', i,j));
        %disp(val)
        if ~isempty(val)
            if isfloat(val)
                B.ui_mainBottomTableRegion.jtable.setValueAt(java.lang.String(sprintf('%0.7g',val)),i-1,j-1);
            end
            if iscellstr(data(i,j))
                %B.ui_mainBottomTableRegion.jtable.setValueAt(java.lang.String(data{i,j}),i-1,j-1);
                B.ui_mainBottomTableRegion.jtable.setValueAt(java.lang.String(data(i,j)),i-1,j-1);
            end
        end
    end
    
end
if nc>0
    B.ui_mainBottomTableRegion.jtable.getColumnModel.getColumn(0).setMaxWidth(100);
    B.ui_mainBottomTableRegion.jtable.getColumnModel.getColumn(0).setMinWidth(100);
    if nc>1
        B.ui_mainBottomTableRegion.jtable.getColumnModel.getColumn(1).setMinWidth(180);
        for i = 0: nc-1
            B.ui_mainBottomTableRegion.jtable.getColumnModel.getColumn(i).setCellRenderer(B.jTableColorRender_1);
        end
        B.ui_mainBottomTableRegion.jtable.setGridColor(java.awt.Color(0.3,0.3,0.3));
        %B.ui_mainBottomTableRegion.jtable.setModel(javax.swing.table.DefaultTableModel);
    end
    
end

% setappdata(B.hFig,'B',B);
end