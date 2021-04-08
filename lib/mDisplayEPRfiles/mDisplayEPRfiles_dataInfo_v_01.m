function mDisplayEPRfiles_dataInfo_v_01 (B) 
% Показываем служебную информацию о файле
    B = getappdata(B.hFig,'B');
    B.indexDir = get(B.lb_dir, 'Value');
    B.indexFiles = get(B.lb_files, 'Value');
    B.indexStruct = get(B.lb_struct, 'Value');
    
    B.p = get(B.hFig, 'CurrentPoint');
    B.new_x = (B.p(1)-B.axShiftX + B.wgrReal(1)*B.scw)/B.scw;
    B.new_y = (B.p(2)-B.axShiftY + B.hgrReal(1)*B.sch)/B.sch;
    set(B.mcpLineY, 'XData',[B.new_x,B.new_x], 'YData', B.hgrReal);
    set(B.mcpLineX, 'XData',B.wgrReal, 'YData',[B.new_y,B.new_y]);
    set(B.Y0, 'XData',B.wgrReal);
    str_txt = sprintf('%0.5g, %0.5g',B.new_x, B.new_y);
    set(B.txtXY, 'String', str_txt );
    set(B.txtXY,'Position',[B.wgrReal(1)+0.01*(B.wgrReal(2) - B.wgrReal(1)), ...
    B.hgrReal(1)+ 0.01*(B.hgrReal(2) - B.hgrReal(1))]);
    
    set(B.dataXY, 'XData',B.x, 'YData', B.y);
    set(B.hAxes, 'XLim', B.wgrReal, 'YLim', B.hgrReal);
    setappdata(B.hFig,'B',B);
    
    B = getappdata(B.hFig,'B');
    scrsz = get(0,'ScreenSize'); % размеры экрана монитора

        wscrK = 1100; % ширина окна
        hscrK = 600; % высота окна
        pl = 0.5*(scrsz(3) - wscrK);% левый край фигуры
        pu = 0.5*(scrsz(4) - hscrK);% верхний край фигуры
        B.infoFig = figure('Position', [pl pu wscrK hscrK],'Resize', 'off', 'MenuBar', 'none', 'NumberTitle','off', 'Name','Info about loaded spectra', 'Color', B.figColorBG);
%         B.infoFig = figure('Position', [pl pu wscrK hscrK],'Resize', 'off', 'MenuBar', 'figure', 'Name','data for save');
        figure(B.infoFig);
            warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
            jframe=get(B.infoFig,'javaframe');
            jIcon=javax.swing.ImageIcon('./icons/main/default_icon.png');
            jframe.setFigureIcon(jIcon);
%         B.khAxes = axes('Position',[0.05 0.06 0.89 0.9]);
%         hold on;
%             hData = plot(B.x,B.y,'-k'); % Экспериментальные данные
%             hold off;
%         xlabel({'B, Oe'}, 'fontsize',14,'fontweight','b');
%         ylabel({'Intensity (a.u.) '}, 'fontsize',14,'fontweight','b');
yShift = 20;
xShift = 400;
axShiftX = 40;
axShiftY = 40;
tx_Operator = uicontrol('Style','text', 'Position',[axShiftX axShiftY+520+10 150 20], 'string', 'Operator:',...
    'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);
tx_Resonator = uicontrol('Style','text', 'Position',[axShiftX axShiftY+520+10-yShift 150 20], 'string', 'Resonator:',...
    'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);
% tx_Temperature = uicontrol('Style','text', 'Position',[axShiftX axShiftY+520+10-2*yShift 150 20], 'string', 'Temperature:',...
%     'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);
tx_Comment = uicontrol('Style','text', 'Position',[axShiftX axShiftY+520+10-2*yShift 150 20], 'string', 'Comment:',...
    'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);
    % Следующая колонка значений
tx_Date = uicontrol('Style','text', 'Position',[axShiftX+xShift axShiftY+520+10 150 20], 'string', 'Date:',...
    'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);
tx_NumOfScans = uicontrol('Style','text', 'Position',[axShiftX+xShift axShiftY+520+10-yShift 150 20], 'string', 'Number of Scans:',...
    'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);

% Следующая строка колонок ----- RECEIVER
tx_Receiver = uicontrol('Style','text', 'Position',[axShiftX axShiftY+520+10-5*yShift 2*150 20], 'string', 'Receiver',...
    'HorizontalAlignment', 'center','BackgroundColor', B.figColorBG, 'FontWeight','bold', 'FontSize', 14);

tx_ReceiverGain = uicontrol('Style','text', 'Position',[axShiftX axShiftY+520+10-7*yShift 150 20], 'string', 'Receiver Gain:',...
    'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);
% tx_Phase = uicontrol('Style','text', 'Position',[axShiftX axShiftY+520+10-8*yShift 150 20], 'string', 'Phase:',...
%     'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);
tx_Harmonic = uicontrol('Style','text', 'Position',[axShiftX axShiftY+520+10-8*yShift 150 20], 'string', 'Harmonic:',...
    'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);
tx_ModFreq = uicontrol('Style','text', 'Position',[axShiftX axShiftY+520+10-9*yShift 150 20], 'string', 'Mod. Frequency :',...
    'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);
    % Следующая колонка значений ----------- ENMR
tx_ENMR = uicontrol('Style','text', 'Position',[axShiftX+xShift axShiftY+520+10-5*yShift 2*150 20], 'string', 'ENMR',...
    'HorizontalAlignment', 'center','BackgroundColor', B.figColorBG, 'FontWeight','bold', 'FontSize', 14);

tx_Field = uicontrol('Style','text', 'Position',[axShiftX+xShift axShiftY+520+10-7*yShift 150 20], 'string', 'Field:',...
    'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);
% tx_StartFreq = uicontrol('Style','text', 'Position',[axShiftX+xShift axShiftY+520+10-8*yShift 150 20], 'string', 'Start Frequency :',...
%     'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);
tx_SweepWidth = uicontrol('Style','text', 'Position',[axShiftX+xShift axShiftY+520+10-8*yShift 150 20], 'string', 'Sweep Width:',...
    'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);
tx_ModDepth = uicontrol('Style','text', 'Position',[axShiftX+xShift axShiftY+520+10-9*yShift 150 20], 'string', 'Mod. Depth:',...
    'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);
% tx_PumpFreq = uicontrol('Style','text', 'Position',[axShiftX+xShift axShiftY+520+10-11*yShift 150 20], 'string', 'Pump Frequency :',...
%     'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);
tx_Attenuator1 = uicontrol('Style','text', 'Position',[axShiftX+xShift axShiftY+520+10-10*yShift 150 20], 'string', 'Attenuator 1:',...
    'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);
% tx_Attenuator2 = uicontrol('Style','text', 'Position',[axShiftX+xShift axShiftY+520+10-13*yShift 150 20], 'string', 'Attenuator 2:',...
%     'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);
% tx_Attenuator3 = uicontrol('Style','text', 'Position',[axShiftX+xShift axShiftY+520+10-14*yShift 150 20], 'string', 'Attenuator 3:',...
%     'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);
tx_Resolution = uicontrol('Style','text', 'Position',[axShiftX+xShift axShiftY+520+10-11*yShift 150 20], 'string', 'Resolution:',...
    'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);

% Следующая строка колонок ---------- Signal Channel
tx_SignalChannel = uicontrol('Style','text', 'Position',[axShiftX axShiftY+520+10-18*yShift 2*150 20], 'string', 'Signal Channel',...
    'HorizontalAlignment', 'center','BackgroundColor', B.figColorBG, 'FontWeight','bold', 'FontSize', 14);

tx_Conversion = uicontrol('Style','text', 'Position',[axShiftX axShiftY+520+10-20*yShift 150 20], 'string', 'Conversion:',...
    'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);
tx_TimeConst = uicontrol('Style','text', 'Position',[axShiftX axShiftY+520+10-21*yShift 150 20], 'string', 'Time Const:',...
    'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);
tx_SweepTime = uicontrol('Style','text', 'Position',[axShiftX axShiftY+520+10-22*yShift 150 20], 'string', 'Sweep Time:',...
    'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);
    % Следующая колонка значений ------------ Microwave
tx_Microwave = uicontrol('Style','text', 'Position',[axShiftX+xShift axShiftY+520+10-18*yShift 2*150 20], 'string', 'Microwave',...
    'HorizontalAlignment', 'center','BackgroundColor', B.figColorBG, 'FontWeight','bold', 'FontSize', 14);

tx_FrequencyMon = uicontrol('Style','text', 'Position',[axShiftX+xShift axShiftY+520+10-20*yShift 150 20], 'string', 'Frequency Mon:',...
    'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);
tx_SweepWidthFq = uicontrol('Style','text', 'Position',[axShiftX+xShift axShiftY+520+10-21*yShift 150 20], 'string', 'Sweep Width:',...
    'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);
tx_CenterField = uicontrol('Style','text', 'Position',[axShiftX+xShift axShiftY+520+10-22*yShift 150 20], 'string', 'Center Field:',...
    'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);
tx_SweepDirection = uicontrol('Style','text', 'Position',[axShiftX+xShift axShiftY+520+10-23*yShift 150 20], 'string', 'Sweep Direction:',...
    'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);
tx_Power = uicontrol('Style','text', 'Position',[axShiftX+xShift axShiftY+520+10-24*yShift 150 20], 'string', 'Power:',...
    'HorizontalAlignment', 'left','BackgroundColor', B.figColorBG);

lb_text = uicontrol('Style','text',...
               'Position',[2*xShift+20, axShiftY-20, wscrK-(2*xShift+20)-20, hscrK-40],...
               'String','info'); 

%% Выводим значение параметров:
yShift = 20;
xShift = 400;
axShiftX = 40+150;
axShiftY = 40;

checkBinfo = isfield(B.info,'OPER');

otx_Operator = uicontrol('Style','edit', 'Position',[axShiftX axShiftY+520+10 150 20], 'string', '--',...
    'HorizontalAlignment', 'left','BackgroundColor', B.ht_ColorTxtField);
if checkBinfo
    set(otx_Operator, 'string',B.info.OPER);
end
otx_Resonator = uicontrol('Style','edit', 'Position',[axShiftX axShiftY+520+10-yShift 150 20], 'string', '--',...
    'HorizontalAlignment', 'left','BackgroundColor', B.ht_ColorTxtField);
if isfield(B.info,'RESO')
    set(otx_Resonator, 'string',B.info.RESO);
end
% otx_Temperature = uicontrol('Style','edit', 'Position',[axShiftX axShiftY+520+10-2*yShift 150 20], 'string', '--',...
%     'HorizontalAlignment', 'left','BackgroundColor', [0.8,0.8,0.8]);
% if isfield(B.info,'RESO')
%     set(otx_Temperature, 'string',B.info.RESO);
% end
otx_Comment = uicontrol('Style','edit', 'Position',[axShiftX axShiftY+520+10-2*yShift 150 20], 'string', '--',...
    'HorizontalAlignment', 'left','BackgroundColor', B.ht_ColorTxtField);
if isfield(B.info,'TITL')
    set(otx_Comment, 'string',B.info.TITL);
end
    % Следующая колонка значений
otx_Date = uicontrol('Style','edit', 'Position',[axShiftX+xShift axShiftY+520+10 150 20], 'string', '--',...
    'HorizontalAlignment', 'left','BackgroundColor', B.ht_ColorTxtField);
if isfield(B.info,'DATE')
    set(otx_Date, 'string',B.info.DATE);
end
otx_NumOfScans = uicontrol('Style','edit', 'Position',[axShiftX+xShift axShiftY+520+10-yShift 150 20], 'string', '--',...
    'HorizontalAlignment', 'left','BackgroundColor', B.ht_ColorTxtField);
if isfield(B.info,'NbScansToDo')
    set(otx_NumOfScans, 'string',B.info.NbScansToDo);
end
% Следующая строка колонок

otx_ReceiverGain = uicontrol('Style','edit', 'Position',[axShiftX axShiftY+520+10-7*yShift 150 20], 'string', '--',...
    'HorizontalAlignment', 'left','BackgroundColor', B.ht_ColorTxtField);
if isfield(B.info,'Gain')
    set(otx_ReceiverGain, 'string',B.info.Gain);
end
% otx_Phase = uicontrol('Style','edit', 'Position',[axShiftX axShiftY+520+10-8*yShift 150 20], 'string', '--',...
%     'HorizontalAlignment', 'left','BackgroundColor', [0.8,0.8,0.8]);
% if isfield(B.info,'ModPhase')
%     set(otx_Phase, 'string',B.info.ModPhase);
% end
otx_Harmonic = uicontrol('Style','edit', 'Position',[axShiftX axShiftY+520+10-8*yShift 150 20], 'string', '--',...
    'HorizontalAlignment', 'left','BackgroundColor', B.ht_ColorTxtField);
if isfield(B.info,'Harmonic')
    set(otx_Harmonic, 'string',B.info.Harmonic);
end
otx_ModFreq = uicontrol('Style','edit', 'Position',[axShiftX axShiftY+520+10-9*yShift 150 20], 'string', '--',...
    'HorizontalAlignment', 'left','BackgroundColor', B.ht_ColorTxtField);
if isfield(B.info,'ModFreq')
    set(otx_ModFreq, 'string',B.info.ModFreq);
end
   
    % Следующая колонка значений

otx_Field = uicontrol('Style','edit', 'Position',[axShiftX+xShift axShiftY+520+10-7*yShift 150 20], 'string', '--',...
    'HorizontalAlignment', 'left','BackgroundColor', B.ht_ColorTxtField);
if isfield(B.info,'StaticFieldMon')
    set(otx_Field, 'string',B.info.StaticFieldMon);
end
% otx_StartFreq = uicontrol('Style','edit', 'Position',[axShiftX+xShift axShiftY+520+10-8*yShift 150 20], 'string', '--',...
%     'HorizontalAlignment', 'left','BackgroundColor', [0.8,0.8,0.8]);
% if isfield(B.info,'RESO')
%     set(otx_StartFreq, 'string',B.info.RESO);
% end
otx_SweepWidth = uicontrol('Style','edit', 'Position',[axShiftX+xShift axShiftY+520+10-8*yShift 150 20], 'string', '--',...
    'HorizontalAlignment', 'left','BackgroundColor', B.ht_ColorTxtField);
if isfield(B.info,'SweepWidth')
    set(otx_SweepWidth, 'string',B.info.SweepWidth);
end
otx_ModDepth = uicontrol('Style','edit', 'Position',[axShiftX+xShift axShiftY+520+10-9*yShift 150 20], 'string', '--',...
    'HorizontalAlignment', 'left','BackgroundColor', B.ht_ColorTxtField);
if isfield(B.info,'RESO')
    set(otx_ModDepth, 'string',B.info.RESO);
end
% otx_PumpFreq = uicontrol('Style','edit', 'Position',[axShiftX+xShift axShiftY+520+10-11*yShift 150 20], 'string', '--',...
%     'HorizontalAlignment', 'left','BackgroundColor', [0.8,0.8,0.8]);
% if isfield(B.info,'RESO')
%     set(otx_PumpFreq, 'string',B.info.RESO);
% end
otx_Attenuator1 = uicontrol('Style','edit', 'Position',[axShiftX+xShift axShiftY+520+10-10*yShift 150 20], 'string', '--',...
    'HorizontalAlignment', 'left','BackgroundColor',B.ht_ColorTxtField);
if isfield(B.info,'PowerAtten')
    set(otx_Attenuator1, 'string',B.info.PowerAtten);
end
% otx_Attenuator2 = uicontrol('Style','edit', 'Position',[axShiftX+xShift axShiftY+520+10-13*yShift 150 20], 'string', '--',...
%     'HorizontalAlignment', 'left','BackgroundColor', [0.8,0.8,0.8]);
% if isfield(B.info,'RESO')
%     set(otx_Attenuator2, 'string',B.info.RESO);
% end
% otx_Attenuator3 = uicontrol('Style','edit', 'Position',[axShiftX+xShift axShiftY+520+10-14*yShift 150 20], 'string', '--',...
%     'HorizontalAlignment', 'left','BackgroundColor', [0.8,0.8,0.8]);
% if isfield(B.info,'RESO')
%     set(otx_Attenuator3, 'string',B.info.RESO);
% end
otx_Resolution = uicontrol('Style','edit', 'Position',[axShiftX+xShift axShiftY+520+10-11*yShift 150 20], 'string', '--',...
    'HorizontalAlignment', 'left','BackgroundColor', B.ht_ColorTxtField);
if isfield(B.info,'Resolution')
    set(otx_Resolution, 'string',B.info.Resolution);
end

% Следующая строка колонок
otx_Conversion = uicontrol('Style','edit', 'Position',[axShiftX axShiftY+520+10-20*yShift 150 20], 'string', '--',...
    'HorizontalAlignment', 'left','BackgroundColor', B.ht_ColorTxtField);
if isfield(B.info,'ConvTime')
    set(otx_Conversion, 'string',B.info.ConvTime);
end
otx_TimeConst = uicontrol('Style','edit', 'Position',[axShiftX axShiftY+520+10-21*yShift 150 20], 'string', '--',...
    'HorizontalAlignment', 'left','BackgroundColor', B.ht_ColorTxtField);
if isfield(B.info,'TimeConst')
    set(otx_TimeConst, 'string',B.info.TimeConst);
end
otx_SweepTime = uicontrol('Style','edit', 'Position',[axShiftX axShiftY+520+10-22*yShift 150 20], 'string', '--',...
    'HorizontalAlignment', 'left','BackgroundColor', B.ht_ColorTxtField);
if isfield(B.info,'SweepTime')
    set(otx_SweepTime, 'string',B.info.SweepTime);
end

    % Следующая колонка значений Microwave ----------
tx_FrequencyMon = uicontrol('Style','edit', 'Position',[axShiftX+xShift axShiftY+520+10-20*yShift 150 20], 'string', '--',...
    'HorizontalAlignment', 'left','BackgroundColor', B.ht_ColorTxtField);
if isfield(B.info,'FrequencyMon')
    set(tx_FrequencyMon, 'string',B.info.FrequencyMon);
end
tx_SweepWidthFq = uicontrol('Style','edit', 'Position',[axShiftX+xShift axShiftY+520+10-21*yShift 150 20], 'string', '--',...
    'HorizontalAlignment', 'left','BackgroundColor', B.ht_ColorTxtField);
if isfield(B.info,'SweepWidth')
    set(tx_SweepWidthFq, 'string',B.info.SweepWidth);
end
tx_CenterField = uicontrol('Style','edit', 'Position',[axShiftX+xShift axShiftY+520+10-22*yShift 150 20], 'string', '--',...
    'HorizontalAlignment', 'left','BackgroundColor', B.ht_ColorTxtField);
if isfield(B.info,'CenterField')
    set(tx_CenterField, 'string',B.info.CenterField);
end
tx_SweepDirection = uicontrol('Style','edit', 'Position',[axShiftX+xShift axShiftY+520+10-23*yShift 150 20], 'string', '--',...
    'HorizontalAlignment', 'left','BackgroundColor', B.ht_ColorTxtField);
if isfield(B.info,'SweepDirection')
    set(tx_SweepDirection, 'string',B.info.SweepDirection);
end
tx_Power = uicontrol('Style','edit', 'Position',[axShiftX+xShift axShiftY+520+10-24*yShift 150 20], 'string', '--',...
    'HorizontalAlignment', 'left','BackgroundColor', B.ht_ColorTxtField);
if isfield(B.info,'Power')
    set(tx_Power, 'string',B.info.Power);
end        

set(lb_text, 'style', 'text');
B.infoTXT = evalc('disp(B.info)');
set(lb_text, 'string', B.infoTXT);
set(lb_text, 'style', 'listbox','HorizontalAlignment', 'left','BackgroundColor', B.ht_ColorTxtField);


setappdata(B.hFig,'B',B);
%     
%     B = getappdata(B.hFig,'B');
%         setappdata(B.hFig,'B',B);
%     return % возврат в вызывающую программу
end