function mWriteDataToMainBottomTableCurves (B)
% Функция записи данных в таблицу MainBottomTableCurves
B = getappdata(B.hFig,'B');
% Проверяем, нажата ли кнопка скрыть или открыть таблицу
chkHideTbl = get(B.tb_hideTable, 'Value');

% Проверяем была ли создана таблица
check = isfield(B,'ui_mainBottomTableCurves');
Data = cell(0,0);
if chkHideTbl == 1 && check
    % Перебираем все имеющиеся редактированные кривые и соответствующие им пики
        if isfield(B,'Curve');
            for cn = 1 : length(B.Curve)
                Data(cn,1) = {cn};
                if strcmp(B.currentViewParameterCurve,'Curve Name')
                    Data(cn,2) =  {B.Curve(cn).FileName};
                end
                if strcmp(B.currentViewParameterCurve,'Angle')
                    Data(cn,2) =  {B.Curve(cn).AngleValue};
                end
                
                if isfield(B.Curve,'Peak')
                    for i = 1 : length(B.Curve(cn).Peak)
                        Data (cn,i+2) = mGetSelectedDataFromCurrentPeak (B, cn, i, B.currentViewParameterRegion);
                    end
                end
            end
        end
     %set( B.ui_mainBottomTableCurves.h, 'Data', Data);
     setappdata(B.hFig,'B',B);
     mSetJTableDataToMainBottomTableCurves(B, Data);
     B = getappdata(B.hFig,'B');
%      jtable.setValueAt(value,rowIdx,colIdx);
     %B.ui_mainBottomTableCurves.h.setData, Data;
     B.ui_mainBottomTableCurves.Data = Data;
end

setappdata(B.hFig,'B',B);
end