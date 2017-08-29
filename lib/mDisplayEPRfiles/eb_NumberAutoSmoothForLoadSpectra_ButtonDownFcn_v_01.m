function eb_NumberAutoSmoothForLoadSpectra_ButtonDownFcn_v_01 (B)
% По нажатию мышки в поле Edit для числа точек сглаживания перезаписываем поле у B.eb_Smooth
% на введенное в данном поле число, показываемое вверху главного окна программы
B = getappdata(B.hFig,'B');
set(B.eb_Smooth, 'String', get(B.eb_NumberAutoSmoothForLoadSpectra, 'String'));
B.valeAutoSmoothForLoadSpectra_number = str2num(get(B.eb_NumberAutoSmoothForLoadSpectra, 'String'));
B.valeAutoSmoothForLoadSpectra = get(B.cb_EnableAutoSmoothForLoadSpectra, 'Value');

setappdata(B.hFig,'B',B);
mDisplayEPRfiles_ReLoadData_v_01(B);
B = getappdata(B.hFig,'B');
    
setappdata(B.hFig,'B',B);
end