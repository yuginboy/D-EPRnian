function mDisplayEPRfiles_EnableShadowView_Before_ButtonDownFcn_v_01(B)
% Показываем как бы тенью на пару шагов назад спектры от текущего, для
% одновременного просмотра на графике нескольких файлов/спектров. Будет как
% бы тянуться за основной линией еще и след, состоящий из линий спектров
% других файлов или угловых.
B = getappdata(B.hFig,'B');

% проверяем есть ли в данном случае просмотра угловые спектры:
B.valBefore = get(B.sl_EnableShadowView_Before, 'Value');
set(B.sl_EnableShadowView_Before,'Value', round(B.valBefore));

% Включаем галочку по отображению спектров режима тени:
set(B.cb_EnableShadowView, 'Value', 1);
% set (B.dataXY, 'LineWidth', 1 );
% figure(B.hFig);

% Делаем все дополнительные прямые невидимыми
for i = 1:3
    set (B.dataXY_before(i), 'Visible', 'off');
%     set (B.dataXY_after(i), 'Visible', 'off');
end
if B.valBefore > 0
    % Делаем основную линию жирной
    set (B.dataXY, 'LineWidth', 2 );
    for i = 1:B.valBefore
        set (B.dataXY_before(i), 'Visible', 'on');
    end
end

% setappdata(B.hFig,'B',B);
% mDisplayEPRfiles_pltData_v_02 (B);
% B = getappdata(B.hFig,'B');

% figure(B.hFigOptions);

setappdata(B.hFig,'B',B);
end