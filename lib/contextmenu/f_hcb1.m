function f_hcb1(src,eventdata,B)
% Функции по работе с контекстным меню
        B = getappdata(B.hFig,'B');
        set(B.hAxes, 'Color', [0.87,0.5,0.87]);        
        setappdata(B.hFig,'B',B);
        
    end