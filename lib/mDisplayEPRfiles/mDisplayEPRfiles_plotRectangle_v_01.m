function mDisplayEPRfiles_plotRectangle_v_01 (B,vector)
    % vector = [B.p(1),B.p(2),B.wgr,B.hgr]
    % Строим прямоугольник при помощи patch, т.к. матлабовцы, суки, не
    % сделали у rectangle свойства прозрачности
    B = getappdata(B.hFig,'B');
    x = vector(1);
    y = vector(2);
    w = vector(3);
    h = vector(4);
    B.mcpRecZoom = patch('XData',[x; (x+w); (x+w); x],'YData',[y; y; (y+h); (y+h)],...
        'EdgeColor', [0.1,0.5,0.7],'LineStyle','--', 'FaceColor', [0.5,0.7,0.7], 'FaceAlpha', 0.5);
%     hPatch = patch(X,Y,);
    setappdata(B.hFig,'B',B);
end