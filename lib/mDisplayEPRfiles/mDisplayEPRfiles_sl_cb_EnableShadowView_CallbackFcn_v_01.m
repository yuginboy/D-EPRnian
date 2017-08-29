function mDisplayEPRfiles_sl_cb_EnableShadowView_CallbackFcn_v_01(B)
% Включаем или выключаем полностью режим отображения пред и по от текущего
% спектра
B = getappdata(B.hFig,'B');

% проверяем включен ли режим отображения:
B.valEnableShadowView = get(B.cb_EnableShadowView, 'Value');

% figure(B.hFig);

% Делаем все дополнительные прямые невидимыми
if B.valEnableShadowView == 0
    for i = 1:3
        set (B.dataXY_before(i), 'Visible', 'off');
        set (B.dataXY_after(i), 'Visible', 'off');
        set (B.dataXY, 'LineWidth', 1 );
    end
end
if B.valEnableShadowView == 1
    set (B.dataXY, 'LineWidth', 2 );
    if B.valBefore > 0
        for i = 1:B.valBefore
            set (B.dataXY_before(i), 'Visible', 'on');
        end
    end
    if B.valAfter > 0
        for i = 1:B.valAfter
            set (B.dataXY_after(i), 'Visible', 'on');
        end
    end
end

% setappdata(B.hFig,'B',B);
% mDisplayEPRfiles_pltData_v_02 (B);
% B = getappdata(B.hFig,'B');

% figure(B.hFigOptions);

setappdata(B.hFig,'B',B);
end