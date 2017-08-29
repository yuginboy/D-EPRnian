function mDisplayEPRfiles_dataSmooth_v_01 (B) 
% Делаем сглаживание
    B = getappdata(B.hFig,'B');
    varSmooth = round(str2num(get(B.eb_Smooth, 'String')));
    if varSmooth > 0 & isnumeric(varSmooth)
        B.valeAutoSmoothForLoadSpectra_number = varSmooth;
     
%     if length(B.x) > 2*varSmooth
%         
%         % Заменил название у исходного матлабовского SMOOTH, т.к. идиоты от
%         % easyspin продублировали название стандартной функции и заменили
%         % ее своей, теперь на тех машинах, на которых установлен easyspin
%         % не работает корректно стандартный вызов матлабовской функции
%         % сглаживания.
%         B.y = mDisplayEPRfiles_matlabSmooth_original(B.x, B.y, varSmooth);
%         
%         set(B.dataXY, 'XData',B.x, 'YData', B.y);
%     end

        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_ReLoadData_v_01(B);
        B = getappdata(B.hFig,'B');
        
        % Устанавливаем одинаковые значения числа точек сглаживания для
        % всех зависимых полей от этой величины
        checkBopt = isfield(B,'eb_NumberAutoSmoothForLoadSpectra');
        if checkBopt
            if ~isempty(B.eb_NumberAutoSmoothForLoadSpectra) & ishandle(B.eb_NumberAutoSmoothForLoadSpectra)
                set(B.eb_NumberAutoSmoothForLoadSpectra,'String',num2str(varSmooth));
            end
        end
    end
setappdata(B.hFig,'B',B);

end