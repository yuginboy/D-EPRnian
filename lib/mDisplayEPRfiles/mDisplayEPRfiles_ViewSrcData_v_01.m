function mDisplayEPRfiles_ViewSrcData_v_01 (B) 
% Возвращаемся к исходным данным
B = getappdata(B.hFig,'B');
B.y = B.src_y;

set(B.dataXY, 'XData',B.x, 'YData', B.y);


setappdata(B.hFig,'B',B);

end