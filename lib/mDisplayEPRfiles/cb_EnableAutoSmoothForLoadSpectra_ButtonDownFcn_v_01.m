function cb_EnableAutoSmoothForLoadSpectra_ButtonDownFcn_v_01(B)
% По выставлению или убиранию галочки в поле chekbox данные перезагружаются
% и к ним применяются новые значения для сглаживания спектров
B = getappdata(B.hFig,'B');
B.valeAutoSmoothForLoadSpectra = get(B.cb_EnableAutoSmoothForLoadSpectra, 'Value');
set(B.eb_Smooth, 'String', get(B.eb_NumberAutoSmoothForLoadSpectra, 'String'));
B.valeAutoSmoothForLoadSpectra_number = round(str2num(get(B.eb_NumberAutoSmoothForLoadSpectra, 'String')));
if B.valeAutoSmoothForLoadSpectra == 0
    set(B.eb_Smooth, 'Enable', 'off');
    set(B.hb_Smooth, 'Enable', 'off');
    set(B.eb_NumberAutoSmoothForLoadSpectra, 'Enable', 'off');
end
if B.valeAutoSmoothForLoadSpectra == 1
    set(B.eb_Smooth, 'Enable', 'on');
    set(B.eb_Smooth,'BackgroundColor', B.ht_ColorTxtField, 'SelectionHighlight', 'off');
    set(B.hb_Smooth, 'Enable', 'on');
    set(B.eb_NumberAutoSmoothForLoadSpectra, 'Enable', 'on');
    set(B.eb_NumberAutoSmoothForLoadSpectra,'BackgroundColor', B.ht_ColorTxtField, 'SelectionHighlight', 'off');
end
drawnow;
pause(0.1);
setappdata(B.hFig,'B',B);
mDisplayEPRfiles_ReLoadData_v_01(B);
B = getappdata(B.hFig,'B');

setappdata(B.hFig,'B',B);

end