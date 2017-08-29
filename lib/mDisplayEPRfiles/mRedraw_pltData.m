function mRedraw_pltData (B) 
% Перерисовываем основные линии курсора: перекрестие, выделяемые области
% для увеличения (зеленоватый прямоугольник) или подсчета ширины пика (красныя полоска)
%  функция перерисовывания всех графических элементов на графике
% Функция перерисовывания основных элементов на графике во время
% перетаскивания графика при зажатой средней кнопке мышки

% Рисуем сплайн
    B = getappdata(B.hFig,'B');
    
    B.p = get(B.hFig, 'CurrentPoint');
    B.new_x = (B.p(1)-B.axShiftX + B.wgrReal(1)*B.scw)/B.scw;
    B.new_y = (B.p(2)-(B.axShiftY + B.dh_forAxes) + B.hgrReal(1)*B.sch)/B.sch;
    
    set(B.mcpLineY, 'XData',[B.new_x,B.new_x], 'YData', B.hgrReal);
    set(B.mcpLineX, 'XData',B.wgrReal, 'YData',[B.new_y,B.new_y]);
    set(B.Y0, 'XData',B.wgrReal);
    
    
    
    
    str_txt = sprintf('%0.5g, %0.5g',B.new_x, B.new_y);
    set(B.txtXY, 'String', str_txt );
    set(B.txtXY,'Position',[B.wgrReal(1)+0.01*(B.wgrReal(2) - B.wgrReal(1)), ...
    B.hgrReal(1)+ 0.02*(B.hgrReal(2) - B.hgrReal(1))]);
    
    % Цифры около курсора:
    str_txt = sprintf('%6.5e, %6.5e\nG = %6.5e',B.new_x, B.new_y, B.freq*1000/(1.39968*B.new_x));
    set(B.ht_coordinates, 'String', str_txt );
    switch B.mip 
        case 1
            if inpolygon(B.p(1), B.p(2), B.axPoligonX, B.axPoligonY)
                set(B.ht_coordinates, 'Visible', 'on' );
            else
                set(B.ht_coordinates, 'Visible', 'off' );
            end
        case 2 % зажата правая кнопка мышки
            if inpolygon(B.p(1), B.p(2), B.axPoligonX, B.axPoligonY)
                set(B.ht_deltaH, 'Visible', 'on' );
                
            else
                set(B.ht_deltaH, 'Visible', 'off' );
            end
        otherwise
            set(B.ht_coordinates, 'Visible', 'off' );
            set(B.ht_deltaH, 'Visible', 'off' );
    end
    
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
    
    
    
    set(B.hAxes, 'XLim', B.wgrReal, 'YLim', B.hgrReal);
%     set(B.hAxes,'uicontextmenu',B.cmenu);
    setappdata(B.hFig,'B',B);
%     
%     B = getappdata(B.hFig,'B');
%         setappdata(B.hFig,'B',B);
%     return % возврат в вызывающую программу
end