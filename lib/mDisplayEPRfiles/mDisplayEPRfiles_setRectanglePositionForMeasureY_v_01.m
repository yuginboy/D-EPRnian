function mDisplayEPRfiles_setRectanglePositionForMeasureY_v_01 (B,vector)
    % vector = [B.p(1),B.p(2),B.wgr,B.hgr]
    % Меняем координаты у прямоугольника при помощи set и patch, т.к. матлабовцы, суки, не
    % сделали у rectangle свойства прозрачности
    % Строим закрашенный прямоугольник и две горизонтальные линии для
    % измерения высоты пиков.
    B = getappdata(B.hFig,'B');
    x = vector(1);
    y = vector(2);
    w = vector(3);
    h = vector(4);
    
    % здесь рисуется прямоугольник области выделения:
%     set(B.mcpRecMeasureY,'XData',[x; (x+w); (x+w); x], ...
%          'YData',[y; y; (y+h); (y+h)]);
     
    % здесь рисуется прямоугольная полоса:
    set(B.mcpRecMeasureY,'XData',[x; (x+w); (x+w); x], ...
         'YData',[B.hgrReal(1); B.hgrReal(1); B.hgrReal(2); B.hgrReal(2)]);
    dW = (B.wgrReal(2) - B.wgrReal(1))*1;
    dH = (B.hgrReal(2) - B.hgrReal(1))*1;
    set(B.mcpFirstLineMeasureX, 'XData', [x-dW, (x+w)+dW], 'YData', [y,y]);
    set(B.mcpSecondLineMeasureX, 'XData', [x-dW, (x+w)+dW], 'YData', [y+h,y+h]);
    set(B.mcpFirstLineMeasureY, 'XData', [x+w, x+w], 'YData', [y-dH,y+h+dH]);
    set(B.mcpSecondLineMeasureY, 'XData', [x, x], 'YData', [y-dH,y+h+dH]);
    % Цифры около курсора:
    str_txt = sprintf('\\DeltaB = %6.2f Oe',abs(w));
%     str_txt = sprintf('dX = %8.7e Oe\ndY = %8.7e a.u.',abs(w),abs(h));
    set(B.ht_deltaH, 'String', str_txt );
    
%     hPatch = patch(X,Y,);
   setappdata(B.hFig,'B',B);
end