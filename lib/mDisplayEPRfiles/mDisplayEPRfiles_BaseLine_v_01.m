function mDisplayEPRfiles_BaseLine_v_01 (B) 
% Возвращаемся к исходным данным
B = getappdata(B.hFig,'B');
if length(B.x) > 10
%     B.y = B.src_y;
    p = polyfit(B.x,B.y,1);
    B.y = B.y - polyval(p,B.x);
    
    set(B.dataXY, 'XData',B.x, 'YData', B.y);
end
setappdata(B.hFig,'B',B);

end