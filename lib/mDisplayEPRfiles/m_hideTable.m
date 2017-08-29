function m_hideTable(B)
% Функция которая используется для hide/unhide таблицы с ЭПР данными пиков.
% В ней происходит изменение значений высоты hAxes и затем сразу же
% вызывается функция mDisplayEPRfiles_resizeFcn_v_01, которая обычно
% срабатывает при изменении размеров главного окна программы
B = getappdata(B.hFig,'B');

B.tb_hideTable_ok = -B.tb_hideTable_ok;
% disp(B.tb_hideTable_ok);
B.tableWinSize = [B.wscr - B.axShiftX - B.lb_borderSize, ...
    round(B.haxe*B.tableWinSizeK) - B.axShiftY ]; % размер таблицы с информацией о пиках
% % Проверяем, нажата ли кнопка скрыть или открыть таблицу
% chkHideTbl = get(B.tb_hideTable, 'Value');
% if chkHideTbl == 1
% % Пересчитываем размер таблицы о пиках
% B.tableSize = [B.wscr - B.axShiftX - B.lb_borderSize, ...
%     round(B.haxe*B.tableSizeK) - B.lb_borderSize - B.btLastLineShft - B.btDstBtw - B.btSmallTypeSize(2)]; % размер таблицы с информацией о пиках
% end
% dh = B.tableSize (2)  + B.btDstBtw + B.btSmallTypeSize(2) + B.lb_borderSize;
dh = B.tableWinSize (2);
% disp(dh);

if B.tb_hideTable_ok == -1
    % Таблица должна показаться
    set(B.tb_hideTable,'CData', imread('./icons/24x23/hide_table_pr.jpg'));
    B.dh_forAxes = dh;
%     B.axShiftY = B.axShiftY + dh;
elseif B.tb_hideTable_ok == 1
    set(B.tb_hideTable,'CData', imread('./icons/24x23/hide_table_n.jpg'));
    B.dh_forAxes = 0;
%     B.axShiftY = B.axShiftY - dh;
end

% set(B.hAxes,'Position',[B.axShiftX B.axShiftY B.waxe B.haxe]);
% if chkHideTbl == 0
%     set(B.tb_hideTable,'CData', imread('./icons/24x23/hide_table_n.jpg'));
% elseif chkHideTbl == 1
%     set(B.tb_hideTable,'CData', imread('./icons/24x23/hide_table_pr.jpg'));
%     
% end

    setappdata(B.hFig,'B',B);
    mDisplayEPRfiles_resizeFcn_v_01(B);
    B = getappdata(B.hFig,'B');

setappdata(B.hFig,'B',B);
end