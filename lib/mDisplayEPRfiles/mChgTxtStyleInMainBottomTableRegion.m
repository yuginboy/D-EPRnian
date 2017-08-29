function mChgTxtStyleInMainBottomTableRegion (Table)
% Функция изменения цветовой палитры выводимых в таблице значений для более
% комфортного отображения результатов измерения.
% rowName = {'Curve ID','Curve Name','Start','End','BG Type', 'Av Width','Offset','G-faktor','Imax','Bo (Gs)','dB (Gs)','Area','Io',...
%             'automatic:','left Bo', 'left Io', 'right Bo', 'right Io',...
%             'manual:','left Bo', 'left Io', 'right Bo', 'right Io'};
% Data = {'10','YAl_01_Ru_Angle_0_120_T_10K','3370','3426','Linear', '0','48514','1.9747','3.3372e+6','3398.4','31.25','4.69e+7','1.67e+6',...
%             '--------------------','3386.2', '1.71e+6', '3417.5', '-1.63e+6',...
%             '--------------------','3386.2', '1.71e+6', '3417.5', '-1.63e+6'}';

Data = Table.Data;

% Curve Name :171D1F
hIndex = 2;
Data(hIndex) = strcat('<html><div style="width:35px" align="center"><span style="color: #171D1F;">', ...
   Data(hIndex), '</span></div></html>');

% G-faktor: 
hIndex = 9;
Data(hIndex) = strcat('<html><div style="width:35px" align="center"><span style="color: #700934; font-weight: bold;">', ...
   Data(hIndex), '</span></div></html>');

% Imax: 
hIndex = 10;
Data(hIndex) = strcat('<html><div style="width:35px" align="center"><span style="color: #4E0970; font-weight: bold;">', ...
   Data(hIndex), '</span></div></html>');

% Bo (Gs): 
hIndex = 11;
Data(hIndex) = strcat('<html><div style="width:35px" align="center"><span style="color: #2B7009; font-weight: bold;">', ...
   Data(hIndex), '</span></div></html>');

% dB (Gs): 
hIndex = 12;
Data(hIndex) = strcat('<html><div style="width:35px" align="center"><span style="color: #095F70; font-weight: bold;">', ...
   Data(hIndex), '</span></div></html>');

% Io: 
hIndex = 13;
Data(hIndex) = strcat('<html><div style="width:35px" align="center"><span style="color: #BA5706; font-weight: bold;">', ...
   Data(hIndex), '</span></div></html>');

% Automatic finded parameters:
hIndex = [15:19];
Data(hIndex) = strcat('<html><div style="width:35px" align="center"><span style="color: #3D5E52;">', ...
   Data(hIndex), '</span></div></html>');

% Manual seted parameters:
hIndex = [20:24];
Data(hIndex) = strcat('<html><div style="width:35px" align="center"><span style="color: #5E1424;">', ...
   Data(hIndex), '</span></div></html>');


set(Table.h, 'Data', Data);
end