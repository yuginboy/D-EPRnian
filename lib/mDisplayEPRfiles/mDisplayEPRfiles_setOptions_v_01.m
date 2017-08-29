function mDisplayEPRfiles_setOptions_v_01 (B) 
% Вызов дополнительного окна с настройками программы
B = getappdata(B.hFig,'B');
% figure(B.hFig);
hFpos = get(B.hFig,'Position');
pl = hFpos(1);
pu = hFpos(2);
wscr = hFpos(3);
hscr = hFpos(4);
B.hFigOptions_Width = 1.5*B.lb_width;
% B.hFigOptions_High = 2*B.lb_High;
B.hFigOptions_High = 300;
dpu = round((hscr - (20+20)-B.hFigOptions_High)/2);
checkBopt = isfield(B,'hFigOptions');
if ~checkBopt
    B.hFigOptions = figure('Position', [pl+wscr-B.hFigOptions_Width - B.axShiftX,...
                                    pu+dpu ...
                                    B.hFigOptions_Width ...
                                    B.hFigOptions_High], 'MenuBar', 'none', 'Name','EPR data options','NumberTitle','off', 'Resize', 'off', 'Color', B.figColorBG);
    LimitSizeFig(B.hFigOptions, 'min', [B.hFigOptions_Width, B.hFigOptions_High]);
else
    if ~ishandle(B.hFigOptions) 
        B.hFigOptions = figure('Position', [pl+wscr-B.hFigOptions_Width - B.axShiftX,...
                                            pu+dpu ...
                                            B.hFigOptions_Width ...
                                            B.hFigOptions_High], 'MenuBar', 'none', 'Name','EPR data options', 'NumberTitle','off', 'Resize', 'off', 'Color', B.figColorBG);
        LimitSizeFig(B.hFigOptions, 'min', [B.hFigOptions_Width, B.hFigOptions_High]);                                 
    else
        figure(B.hFigOptions);
        set(B.hFigOptions, 'HandleVisibility', 'on');
%         hFpos = get(B.hFigOptions,'Position');
        uistack(B.hFigOptions, 'top' );
%         jFrame = get(gcf,'JavaFrame');
%         jFrame.setMaximized(true);
%         set(B.hFigOptions,'Position',hFpos);
    end

end
            warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
            jframe=get(B.hFigOptions,'javaframe');
            jIcon=javax.swing.ImageIcon('./icons/main/default_icon.png');
            jframe.setFigureIcon(jIcon);

% Checkbutton по включению/выключению отображения спектров на определенное
% количество шагов вперед или назад от текущего спектра/файла
B.cb_EnableShadowView = uicontrol('Style','checkbox','Value',B.valEnableShadowView,...
               'Units','Pixels',...
               'Position',[10 B.hFigOptions_High - 30, B.hFigOptions_Width - 20, B.buttonHigh],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'String','  enable or disable Shadow View spectra');
           set(B.cb_EnableShadowView, 'Callback', {@sl_cb_EnableShadowView_CallbackFcn});
% -----------------           
B.txt_EnableShadowView_Before = uicontrol('Style','text','Value',1,...
                'Units','Pixels','Position',[10 B.hFigOptions_High - 55, B.hFigOptions_Width - 20, B.buttonHigh],...
                'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
                'String','number of steps before current file to view:');
B.sl_EnableShadowView_Before = uicontrol('Style','slider','Value',B.valBefore,...
               'Units','Pixels', 'Min',0,'Max',3,'SliderStep', [1 1]./3,...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'Position',[10 B.hFigOptions_High - 70, B.hFigOptions_Width - 20, B.buttonHigh]);
B.txt_EnableShadowView_Before_lbl = uicontrol('Style','text','Value',0,...
                'Units','Pixels','Position',[10 B.hFigOptions_High - 90, B.hFigOptions_Width - 20, B.buttonHigh],...
                'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
                'String',' 0             1                  2              3');
            set(B.sl_EnableShadowView_Before, 'Callback', {@sl_EnableShadowView_Before_ButtonDownFcn});
% -----------------           
B.txt_EnableShadowView_After = uicontrol('Style','text','Value',0,...
                'Units','Pixels','Position',[10 B.hFigOptions_High - 115, B.hFigOptions_Width - 20, B.buttonHigh],...
                'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
                'String','number of steps after current file to view:');
B.sl_EnableShadowView_After = uicontrol('Style','slider','Value',B.valAfter,...
               'Units','Pixels', 'Min',0,'Max',3,'SliderStep', [1 1]./3,...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'Position',[10 B.hFigOptions_High - 130, B.hFigOptions_Width - 20, B.buttonHigh]);
B.txt_EnableShadowView_After_lbl = uicontrol('Style','text','Value',1,...
                'Units','Pixels','Position',[10 B.hFigOptions_High - 150, B.hFigOptions_Width - 20, B.buttonHigh],...
                'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
                'String',' 0             1                  2              3');
            set(B.sl_EnableShadowView_After, 'Callback', {@sl_EnableShadowView_After_ButtonDownFcn});
            
            
% Опция включения или выключения автоматического сглаживания для загруженных ЭПР спектров            
B.cb_EnableAutoSmoothForLoadSpectra = uicontrol('Style','checkbox','Value',B.valeAutoSmoothForLoadSpectra,...
               'Units','Pixels',...
               'Position',[10 B.hFigOptions_High - 170, B.hFigOptions_Width - 20, B.buttonHigh],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'String','  enable or disable Auto Smooth for load spectra');
           set(B.cb_EnableAutoSmoothForLoadSpectra, 'Callback', {@cb_EnableAutoSmoothForLoadSpectra_CallbackFcn});

 B.eb_NumberAutoSmoothForLoadSpectra  = uicontrol('Style','edit',...
               'Units','Pixels',...
               'Position',[10 B.hFigOptions_High - 190, B.buttonWidth, B.buttonHigh],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'String',num2str(B.valeAutoSmoothForLoadSpectra_number));
           set(B.eb_NumberAutoSmoothForLoadSpectra, 'String', get(B.eb_Smooth,'String'));
           set(B.eb_NumberAutoSmoothForLoadSpectra, 'Callback', {@eb_NumberAutoSmoothForLoadSpectra_CallbackFcn});
B.txt_NumberAutoSmoothForLoadSpectra  = uicontrol('Style','text',...
               'Units','Pixels', 'HorizontalAlignment', 'left',...
               'Position',[10 + B.buttonWidth+10 B.hFigOptions_High - 190, B.hFigOptions_Width - (B.buttonWidth+10)-20, B.buttonHigh],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'String','Number of points for Smooth');           
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
          
% -----------------           
            
    setappdata(B.hFig,'B',B);
    mDisplayEPRfiles_pltData_v_02(B);
    B = getappdata(B.hFig,'B');
    
% Ждем пока перересуются графические объекты
drawnow;

setappdata(B.hFig,'B',B);

function sl_cb_EnableShadowView_CallbackFcn(src,eventdata)
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_sl_cb_EnableShadowView_CallbackFcn_v_01(B);
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
    end
% Описываем функции, работающие при нажатии мышкой на слайдере:
function sl_EnableShadowView_Before_ButtonDownFcn(src,eventdata)
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_EnableShadowView_Before_ButtonDownFcn_v_01(B);
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
    end
function sl_EnableShadowView_After_ButtonDownFcn(src,eventdata)
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_sl_EnableShadowView_After_ButtonDownFcn_v_01(B);
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
    end
function cb_EnableAutoSmoothForLoadSpectra_CallbackFcn(src,eventdata)
    % По выставлению или снятию галочки
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
        cb_EnableAutoSmoothForLoadSpectra_ButtonDownFcn_v_01(B);
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
    end
function eb_NumberAutoSmoothForLoadSpectra_CallbackFcn(src,eventdata)
    % По нажатию клавиши Enter
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
        eb_NumberAutoSmoothForLoadSpectra_ButtonDownFcn_v_01(B);
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
    end
end