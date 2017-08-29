function mWriteDataToMainBottomTableRegion (B)
% Функция записи данных в таблицу mainBottomTableRegion
B = getappdata(B.hFig,'B');
% Проверяем, нажата ли кнопка скрыть или открыть таблицу
chkHideTbl = get(B.tb_hideTable, 'Value');

cn = B.currentCurveNumber;
i = B.currentPeakNumber;

% rowName = {'Curve ID',
%            'Curve Name',
%            'Angle',
%            'Start',
%            'End',
%            'BG Type',
%            'Av Width',
%            'Offset',
%            'G-faktor',
%            'Imax',
%            'Bo (Gs)',
%            'dB (Gs)',
%            'Area',
%            'Io',...
%             'automatic:',
%             'left Bo',
%             'left Io',
%             'right Bo',
%             'right Io',...
%             'manual:',
%             'left Bo',
%             'left Io',
%             'right Bo',
%             'right Io'};
% Data = {'10','YAl_01_Ru_Angle_0_120_T_10K','0', '3370','3426','Linear', '0','48514','1.9747','3.3372e+6','3398.4','31.25','4.69e+7','1.67e+6',...
%             '----------------------------------------','3386.2', '1.71e+6', '3417.5', '-1.63e+6',...
%             '----------------------------------------','3386.2', '1.71e+6', '3417.5', '-1.63e+6'}';
rowName = {'Curve ID','Curve Name','Angle','Start','End','BG Type', 'Av Width','Offset','G-faktor','Imax','Bo (Gs)','dB (Gs)','Area','Io',...
            'automatic:','left Bo', 'left Io', 'right Bo', 'right Io',...
            'manual:','left Bo', 'left Io', 'right Bo', 'right Io'};
% Проверяем была ли создана таблица
check = isfield(B,'ui_mainBottomTableRegion');
Data = rowName';

if chkHideTbl == 1 && check
    % Перебираем все имеющиеся редактированные кривые и соответствующие им пики
        if isfield(B,'Curve') && ~isempty(B.Curve) 
                if isfield(B.Curve,'Peak')
                    if cn < 1 
                        cn = 1;
                    end
                    if i < 1
                        cn = length(B.Curve(cn));
                    end
                    Data (1,2) = {num2str(cn)};
                    Data (2,2) = {B.Curve(cn).FileName};
                    Data (3,2) = {B.Curve(cn).AngleValue};
                    Data (4,2) = mGetSelectedDataFromCurrentPeak (B, cn, i, 'Start');
                    Data (5,2) = mGetSelectedDataFromCurrentPeak (B, cn, i, 'End');
                    Data (6,2) = mGetSelectedDataFromCurrentPeak (B, cn, i, 'BG Type');
                    Data (7,2) = mGetSelectedDataFromCurrentPeak (B, cn, i, 'Av Width');
                    Data (8,2) = mGetSelectedDataFromCurrentPeak (B, cn, i, 'Offset');
                    Data (9,2) = mGetSelectedDataFromCurrentPeak (B, cn, i, 'G-faktor');
                    Data (10,2) = mGetSelectedDataFromCurrentPeak (B, cn, i, 'Imax');
                    Data (11,2) = mGetSelectedDataFromCurrentPeak (B, cn, i, 'Bo');
                    Data (12,2) = mGetSelectedDataFromCurrentPeak (B, cn, i, 'dB');
                    Data (13,2) = mGetSelectedDataFromCurrentPeak (B, cn, i, 'Area');
                    Data (14,2) = mGetSelectedDataFromCurrentPeak (B, cn, i, 'Io');
                    Data (15,2) = {'----------------------------------------'};
                    Data (16,2) = mGetSelectedDataFromCurrentPeak (B, cn, i, 'auto left Bo');
                    Data (17,2) = mGetSelectedDataFromCurrentPeak (B, cn, i, 'auto left Io');
                    Data (18,2) = mGetSelectedDataFromCurrentPeak (B, cn, i, 'auto right Bo');
                    Data (19,2) = mGetSelectedDataFromCurrentPeak (B, cn, i, 'auto right Io');
                    Data (20,2) = {'----------------------------------------'};
                    Data (21,2) = mGetSelectedDataFromCurrentPeak (B, cn, i, 'manual left Bo');
                    Data (22,2) = mGetSelectedDataFromCurrentPeak (B, cn, i, 'manual left Io');
                    Data (23,2) = mGetSelectedDataFromCurrentPeak (B, cn, i, 'manual right Bo');
                    Data (24,2) = mGetSelectedDataFromCurrentPeak (B, cn, i, 'manual right Io');
                end
        end
     %set( B.ui_mainBottomTableCurves.h, 'Data', Data);
     setappdata(B.hFig,'B',B);
     mSetJTableDataToMainBottomTableRegion(B, Data);
     B = getappdata(B.hFig,'B');
%      jtable.setValueAt(value,rowIdx,colIdx);
     %B.ui_mainBottomTableCurves.h.setData, Data;
     B.ui_mainBottomTableRegion.Data = Data;
end

setappdata(B.hFig,'B',B);
end