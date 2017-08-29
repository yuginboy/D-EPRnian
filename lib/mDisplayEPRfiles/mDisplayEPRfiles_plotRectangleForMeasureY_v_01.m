function mDisplayEPRfiles_plotRectangleForMeasureY_v_01 (B,vector)
    % Строим закрашенный прямоугольник и две горизонтальные линии для
    % измерения высоты пиков.
    % vector = [B.p(1),B.p(2),B.wgr,B.hgr]
    % Строим прямоугольник при помощи patch, т.к. матлабовцы, суки, не
    % сделали у rectangle свойства прозрачности
    B = getappdata(B.hFig,'B');
    x = vector(1);
    y = vector(2);
    w = vector(3);
    h = vector(4);
    
    % Рисуем прямоугольник
    B.mcpRecMeasureY = patch('XData',[x; (x+w); (x+w); x],'YData',[y; y; (y+h); (y+h)],...
        'EdgeColor', [0.1,0.5,0.7],'LineStyle','--', 'FaceColor', [0.85,0.4,0.4], 'FaceAlpha', 0.3);
    %     hPatch = patch(X,Y,);
    % Рисуем горизонтальные линии уровня
    dW = (B.wgrReal(2) - B.wgrReal(1))*1;
    dH = (B.hgrReal(2) - B.hgrReal(1))*1;
    B.mcpFirstLineMeasureX = plot( [x-dW, (x+w)+dW], [y,y], 'Color',[1,0.14,0.04]);
    B.mcpSecondLineMeasureX = plot( [x-dW, (x+w)+dW], [y,y], 'Color',[1,0.14,0.04]);
    B.mcpFirstLineMeasureY = plot( [x-dW, (x+w)+dW], [y,y], 'Color',[1,0.14,0.04]);
    B.mcpSecondLineMeasureY = plot( [x, x], [y-dH,y], 'Color',[1,0.14,0.04]);
    set(B.mcpRecMeasureY, 'Visible', 'off');
    set(B.mcpFirstLineMeasureX, 'Visible', 'off');
    set(B.mcpSecondLineMeasureX, 'Visible', 'off');
    set(B.mcpFirstLineMeasureY, 'Visible', 'off');
    set(B.mcpSecondLineMeasureY, 'Visible', 'off');
    % Пишем текст разницы между уровнями по ординате Y:
    str_txt = sprintf('dH = %0.5g',h);
    B.ht_deltaH = text ('Position',[0.5,0.5],'string','0,0','FontSize',15,'BackGroundColor', [198,198,198]/255, 'EdgeColor', [20, 134, 100]/255, 'LineWidth', 1);
%     set(B.ht_deltaH, 'HorizontalAlignment', 'center');
    set(B.ht_deltaH, 'Visible', 'off');
    
    setappdata(B.hFig,'B',B);
end