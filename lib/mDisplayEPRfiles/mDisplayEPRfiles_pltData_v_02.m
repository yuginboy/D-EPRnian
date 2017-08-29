function mDisplayEPRfiles_pltData_v_02 (B) 
% Перерисовываем основные линии курсора: перекрестие, выделяемые области
% для увеличения (зеленоватый прямоугольник) или подсчета ширины пика (красныя полоска)
% Основная функция перерисовывания всех графических элементов на графике


% Рисуем сплайн
    B = getappdata(B.hFig,'B');
    
%     drawnow;
%     pause(0.1)
% 
%     set(B.hAxes,'uicontextmenu',B.cmenu);
% %     set(B.cmenu, 'Visible', 'on');
% %     get(B.cmenu)
    B.p = get(B.hFig, 'CurrentPoint');
    B.new_x = (B.p(1)-B.axShiftX + B.wgrReal(1)*B.scw)/B.scw;
    B.new_y = (B.p(2)-(B.axShiftY + B.dh_forAxes) + B.hgrReal(1)*B.sch)/B.sch;
    
    B.chkMouseInAxesPolygon =  inpolygon(B.new_x,B.new_y, [B.wgrReal(1), B.wgrReal(2), B.wgrReal(2), B.wgrReal(1)],[B.hgrReal(1),B.hgrReal(1),B.hgrReal(2),B.hgrReal(2)]);
    
    
    
    % Высчитываем ширину и высоту прямоугольника зумирования:
    B.recW = B.new_x - B.startRecPosition(1);
    if B.recW == 0 
        B.recW = (B.wgrReal(2) - B.wgrReal(1))*0.0001;
    end
    
    B.recH = B.new_y - B.startRecPosition(2);
    if B.recH == 0 
        B.recH = (B.hgrReal(2) - B.hgrReal(1))*0.0001;
    end

% Проверяем, находится ли курсор в пределах hAxes:
if B.chkMouseInAxesPolygon  
    
    set(B.mcpLineY, 'XData',[B.new_x,B.new_x], 'YData', B.hgrReal);
    set(B.mcpLineX, 'XData',B.wgrReal, 'YData',[B.new_y,B.new_y]);
    set(B.Y0, 'XData',B.wgrReal);
    
   if  B.chkMouseStartClickPointInAxesPolygon
        if B.recW < 0 && B.recH > 0
    %         set(B.mcpRecZoom, 'Position', [B.new_x, B.startRecPosition(2), abs(B.recW), abs(B.recH)]);
            setappdata(B.hFig,'B',B);
            mDisplayEPRfiles_setRectanglePosition_v_01 (B,[B.new_x, B.startRecPosition(2), abs(B.recW), abs(B.recH)]);
            B = getappdata(B.hFig,'B');
            setappdata(B.hFig,'B',B);
            mDisplayEPRfiles_setRectanglePositionForMeasureY_v_01 (B,[B.new_x, B.startRecPosition(2), abs(B.recW), abs(B.recH)]);
            B = getappdata(B.hFig,'B');

        elseif B.recW > 0 && B.recH < 0
    %         set(B.mcpRecZoom, 'Position', [B.startRecPosition(1), B.new_y, abs(B.recW), abs(B.recH)]);
            setappdata(B.hFig,'B',B);
            mDisplayEPRfiles_setRectanglePosition_v_01 (B,[B.startRecPosition(1), B.new_y, abs(B.recW), abs(B.recH)]);
            B = getappdata(B.hFig,'B');
            setappdata(B.hFig,'B',B);
            mDisplayEPRfiles_setRectanglePositionForMeasureY_v_01 (B,[B.startRecPosition(1), B.new_y, abs(B.recW), abs(B.recH)]);
            B = getappdata(B.hFig,'B'); 
        elseif B.recW < 0 && B.recH < 0
    %         set(B.mcpRecZoom, 'Position', [B.new_x, B.new_y, abs(B.recW), abs(B.recH)]);
            setappdata(B.hFig,'B',B);
            mDisplayEPRfiles_setRectanglePosition_v_01 (B,[B.new_x, B.new_y, abs(B.recW), abs(B.recH)]);
            B = getappdata(B.hFig,'B');
            setappdata(B.hFig,'B',B);
            mDisplayEPRfiles_setRectanglePositionForMeasureY_v_01 (B,[B.new_x, B.new_y, abs(B.recW), abs(B.recH)]);
            B = getappdata(B.hFig,'B');
        else
    %         set(B.mcpRecZoom, 'Position', [B.startRecPosition(1), B.startRecPosition(2), B.recW, B.recH]);
            setappdata(B.hFig,'B',B);
            mDisplayEPRfiles_setRectanglePosition_v_01 (B,[B.startRecPosition(1), B.startRecPosition(2), B.recW, B.recH]);
            B = getappdata(B.hFig,'B');
            setappdata(B.hFig,'B',B);
            mDisplayEPRfiles_setRectanglePositionForMeasureY_v_01 (B,[B.startRecPosition(1), B.startRecPosition(2), B.recW, B.recH]);
            B = getappdata(B.hFig,'B');
        end
   end
        
    str_txt = sprintf('%0.7g, %0.7g',B.new_x, B.new_y);
    set(B.txtXY, 'String', str_txt );
    set(B.txtXY,'Position',[B.wgrReal(1)+0.01*(B.wgrReal(2) - B.wgrReal(1)), ...
    B.hgrReal(1)+ 0.02*(B.hgrReal(2) - B.hgrReal(1))]);
    
    % Цифры около курсора:
    str_txt = sprintf('%8.7e, %8.7e\nG = %8.7e',B.new_x, B.new_y, B.freq*1000/(1.39968*B.new_x));
    set(B.ht_coordinates, 'String', str_txt );
        
        
end
    
    
    
    switch B.mip 
        case 1
            if inpolygon(B.p(1), B.p(2), B.axPoligonX, B.axPoligonY)
                set(B.ht_coordinates, 'Visible', 'on' );
            else
                set(B.ht_coordinates, 'Visible', 'off' );
            end
        case 2 % зажата правая кнопка мышки
            if inpolygon(B.p(1), B.p(2), B.axPoligonX, B.axPoligonY) && B.chkMouseStartClickPointInAxesPolygon
                set(B.ht_deltaH, 'Visible', 'on' );
                
            else
                set(B.ht_deltaH, 'Visible', 'off' );
            end
        otherwise
            set(B.ht_coordinates, 'Visible', 'off' );
            set(B.ht_deltaH, 'Visible', 'off' );
    end
    
    
% Проверяем, находится ли курсор в пределах hAxes:
if B.chkMouseInAxesPolygon && B.chkMouseStartClickPointInAxesPolygon
    if B.new_x > B.wgrReal(1)+0.5*(B.wgrReal(2) - B.wgrReal(1))
        x = B.new_x - 0.4*B.waxe0/B.waxe*(B.wgrReal(2) - B.wgrReal(1)); % с коэффициентом,
        % который необходим для выравнивания сдвига надписи после
        % увеличения масштаба окна просмотра
        x_dH = B.new_x - 0.27*B.waxe0/B.waxe*(B.wgrReal(2) - B.wgrReal(1));
    else
        x = B.new_x + 0.05*(B.wgrReal(2) - B.wgrReal(1));
        x_dH = x;
    end
    if B.new_y > B.hgrReal(1)+0.5*(B.hgrReal(2) - B.hgrReal(1))
        y = B.new_y - 0.05*(B.hgrReal(2) - B.hgrReal(1));
    else
        y = B.new_y + 0.05*(B.hgrReal(2) - B.hgrReal(1));
    end
%     x = B.new_x + 0.01*(B.wgrReal(2) - B.wgrReal(1));
%     y = B.new_y + 0.01*(B.hgrReal(2) - B.hgrReal(1));
    set(B.ht_coordinates,'Position',[x,y]);
    set(B.ht_deltaH,'Position',[x_dH,y]);
end    
    
    set(B.hAxes, 'XLim', B.wgrReal, 'YLim', B.hgrReal);
    
    
    
    chkPeakEdit = get (B.tb_peakEdit, 'Value');
    if chkPeakEdit && B.chkMouseInAxesPolygon && B.chkMouseStartClickPointInAxesPolygon
            
        % Перерисовываем высоты у регионов
        % Автоскалируем их по высоте осей
        setappdata(B.hFig,'B',B);  
        mChangePeakRegionHeight (B);
        B = getappdata(B.hFig,'B');
    end
%     set(B.hAxes,'uicontextmenu',B.cmenu);
    setappdata(B.hFig,'B',B);
%     
%     B = getappdata(B.hFig,'B');
%         setappdata(B.hFig,'B',B);
%     return % возврат в вызывающую программу
end