function mDisplayEPRfiles_moveMouseFcn_v_01 (B)
%     global B;
%     txtTest = ['Button Motion:'];
    B = getappdata(B.hFig,'B');
    % Функция выбора точек на графике
    B.p = get(B.hFig, 'CurrentPoint');
    % координаты мышки

    B.new_x = (B.p(1)-B.axShiftX + B.wgrReal(1)*B.scw)/B.scw;
    B.new_y = (B.p(2)-B.axShiftY + B.hgrReal(1)*B.sch)/B.sch;
    
    B.chkMouseInAxesPolygon = inpolygon(B.new_x,B.new_y, [B.wgrReal(1), B.wgrReal(2), B.wgrReal(2), B.wgrReal(1)],[B.hgrReal(1),B.hgrReal(1),B.hgrReal(2),B.hgrReal(2)]);
    
    setappdata(B.hFig,'B',B);
    mDisplayEPRfiles_pltData_v_02 (B);
    B = getappdata(B.hFig,'B');
    
    str_txt = sprintf('%0.7g, %0.7g',B.new_x, B.new_y);
    set(B.txtXY, 'String', str_txt );
    set(B.txtXY,'Position',[B.wgrReal(1)+0.01*(B.wgrReal(2) - B.wgrReal(1)), ...
    B.hgrReal(1)+ 0.02*(B.hgrReal(2) - B.hgrReal(1))]);

if B.mip ~= 2
    set(B.ht_deltaH, 'Visible', 'off');
    set(B.mcpRecMeasureY, 'Visible', 'off');
    set(B.mcpFirstLineMeasureX, 'Visible', 'off');
    set(B.mcpSecondLineMeasureX, 'Visible', 'off');
    set(B.mcpFirstLineMeasureY, 'Visible', 'off');
    set(B.mcpSecondLineMeasureY, 'Visible', 'off');
end

if B.mip == 3 && B.chkMouseInAxesPolygon
    % опция по позиционированию графика по зажатой средней кнопке
    setappdata(B.hFig,'B',B);
    mDisplayEPRfiles_moveCurveOnAxis_v_01(B);
    B = getappdata(B.hFig,'B');
    set(B.hFig, 'Pointer', 'fleur');
    setappdata(B.hFig,'B',B);
end

chkPeakEdit = get (B.tb_peakEdit, 'Value');
if chkPeakEdit && round(B.mip) == 4 && B.chkMouseInAxesPolygon
    % Нажата кнопка редактирования пика:
    % Отслеживаем передвижение мышки и соответственно передвигаем регион
    setappdata(B.hFig,'B',B);
    mResizePeakRegion (B);
    B = getappdata(B.hFig,'B');
end

    pFig = get(B.hFig, 'Position');
    if pFig(3)<B.wscr
        set(B.hFig, 'Resize', 'off');
        set(B.hFig, 'Position', [pFig(1) pFig(2) B.wscr B.hscr]);
        set(B.hFig, 'Resize', 'on');
    end
    if pFig(4)<B.hscr
        set(B.hFig, 'Resize', 'off');
        set(B.hFig, 'Position', [pFig(1) pFig(2) B.wscr B.hscr]);
        set(B.hFig, 'Resize', 'on');
    end
    
    setappdata(B.hFig,'B',B);
%     return % возврат в вызывающую программу
end