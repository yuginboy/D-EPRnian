function mDisplayEPRfiles_pltData_v_01 (B) % рисует график сплайна
% Рисуем сплайн
    B = getappdata(B.hFig,'B');
    B.mip = 0;
        click = get(B.hFig,'SelectionType');
        switch click
            case 'normal'
                B.mip = 1; % Left-button-click
                set(B.hFig, 'Pointer', 'arrow');
            case 'alt'
                B.mip = 2; % Right-button-click
                set(B.hFig, 'Pointer', 'arrow');
            case 'extend'
                B.mip = 3; % Middle-button-click
                set(B.hFig, 'Pointer', 'fleur');
            otherwise
                B.mip = 0;
                set(B.hFig, 'Pointer', 'arrow');
        end
        
        switch B.mip
            case 1 
                % нажата левая кнопка мышки и точка захвачена
%                 B.statusArray(pinp) = ~B.statusArray(pinp);
                setappdata(B.hFig,'B',B);
%                 manualCorrectedExt_pltSpline_setZero(B);
                B = getappdata(B.hFig,'B');
        % перерисовали сплайн и узловые точки
            case 2
                % нажата правая кнопка мышки и точка захвачена
                setappdata(B.hFig,'B',B);
%                 manualCorrectedExt_pltSpline_setZero(B);
                B = getappdata(B.hFig,'B');
            case B.mip == 3 
                % нажата средняя кнопка мыши

                % фиксируем центральную точку относительно которой будем
                % высчитывать сдвиг осей
                B.start_x = B.new_x;
                B.start_y = B.new_y;
                B.wgrReal_start = B.wgrReal;
                B.hgrReal_start = B.hgrReal;
                setappdata(B.hFig,'B',B);
                mDisplayEPRfiles_moveCurveOnAxis_v_01(B);
                B = getappdata(B.hFig,'B');
    end
    
    B.p = get(B.hFig, 'CurrentPoint');
    B.new_x = (B.p(1)-B.axShiftX + B.wgrReal(1)*B.scw)/B.scw;
    B.new_y = (B.p(2)-B.axShiftY + B.hgrReal(1)*B.sch)/B.sch;
    set(B.mcpLineY, 'XData',[B.new_x,B.new_x], 'YData', B.hgrReal);
    set(B.mcpLineX, 'XData',B.wgrReal, 'YData',[B.new_y,B.new_y]);
    
    str_txt = sprintf('%0.5g, %0.5g',B.new_x, B.new_y);
    set(B.txtXY, 'String', str_txt );

    set(B.hAxes, 'XLim', B.wgrReal, 'YLim', B.hgrReal);
    setappdata(B.hFig,'B',B);
%     return % возврат в вызывающую программу
end