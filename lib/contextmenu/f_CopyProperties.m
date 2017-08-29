function f_CopyProperties(src,eventdata,B)
% Функции по работе с контекстным меню для lb_struct поля.
% Копируем свойства выделенной кривой для последующей передачи данных
% свойств другим кривым 
% (propagate: regions,components,processing,annotation,autoFit comp-regions,Regions Errors,Components Errors).
B = getappdata(B.hFig,'B');
cn = B.currentCurveNumber;
if cn > 0
    if isfield(B, 'masterCurve')
        B.masterCurve = [];
        disp('purge master curve');
        disp(B.masterCurve);
    end
    B.masterCurve = B.Curve(cn);
    B.cmenu.lb_struct.pmPastProperties.Enable = 'on';
end
setappdata(B.hFig,'B',B);
end