function mDisplayEPRfiles_setRectanglePosition_v_01 (B,vector)
    % vector = [B.p(1),B.p(2),B.wgr,B.hgr]
    % Меняем координаты у прямоугольника при помощи set и patch, т.к. матлабовцы, суки, не
    % сделали у rectangle свойства прозрачности
    B = getappdata(B.hFig,'B');
    x = vector(1);
    y = vector(2);
    w = vector(3);
    h = vector(4);
    set(B.mcpRecZoom,'XData',[x; (x+w); (x+w); x], ...
         'YData',[y; y; (y+h); (y+h)]);
%     hPatch = patch(X,Y,);
   setappdata(B.hFig,'B',B);
end