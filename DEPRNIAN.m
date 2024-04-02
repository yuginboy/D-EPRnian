function DEPRNIAN (A)
% The program helps you to work with EPR (or ESR) spectra
% Scientific knowledge must be open and freely available.
%-----------------------------------------------------------------------

verVar = 'GNU D''EPRnian v.05.4.7 (2023.02.17)';
txt = sprintf('-->> Start the %s program', verVar);
disp(txt);
% path(path,'./mDisplayEPRfiles/');
% path(path,'./easyspin-4.5.5/easyspin');
fs = filesep;% System depend file separator

% path(path,'./lib/');
addPathVar = ['.',fs,'lib',fs];
path(path,addPathVar);

% path(path,'./icons/24x23');
% path(path,'./icons/78x23');

% path(path,'./lib/easyspin');
addPathVar = ['.',fs,'lib',fs,'easyspin'];
path(path,addPathVar);

% path(path,'./lib/mDisplayEPRfiles/');
addPathVar = ['.',fs,'lib',fs,'mDisplayEPRfiles'];
path(path,addPathVar);

% path(path,'./lib/contextmenu/');
addPathVar = ['.',fs,'lib',fs,'contextmenu'];
path(path,addPathVar);

% path(path,'./lib/mCreateTable/');
addPathVar = ['.',fs,'lib',fs,'mCreateTable'];
path(path,addPathVar);
addPathVar = [addPathVar,fs,'TableSorter.jar'];
javaaddpath(addPathVar);
% disp(javaclasspath('-dynamic'));

% Show splash screen logo:
m_createSplashLogo(verVar);

if ~exist('A', 'var') 
    % for testing procedure ------
    txt = sprintf('-- The %s program will works in a MAIN WINDOW MODE --', verVar);
    disp(txt);
    A = 1;
    A = mDisplayEPRfiles_loadFiles_v_02; 

end
B = A;
if B.defPath == 0
    return
end

B.verVar = verVar;
% Определяем значения переменных по умолчанию:
B.mip = 0; % Значения следящего параметра за нажатиями кнопок мышки
B.key = 0; % Значения следящего параметра за нажатиями кнопок клавиатуры

% Значения следящих параметров за нажатием кнопки мышки при включенном
% режиме редактирования регионов. Если зажать левой кнопкой мышки над
% регионом и его правой и левой управляющими областями-ручками, то тем
% самым мышкой можно менять размеры региона
B.mouseGripRegionHandle = 0;
B.mouseGripRegionHandleLeft = 0;
B.mouseGripRegionHandleRight = 0;

% Переменные, отвечающие выделенным в данный момент номеру кривой и пику на
% ней, если есть такая возможность
B.currentCurveNumber = 0;
B.currentPeakNumber = 0;

B.freq = 8.392909;% GHz
B.magnetic_field_shift = 0; % Oe
% B.magnetic_field_shift = -3.81; % Oe

% Значения переменных для идентификации кривой, для которой создаем регионы
% и ищем пики:
B.currentCurveDirName = 'tmp';
B.currentCurveFileName = 'tmp.dat';

% Текущий параметр, который по умолчанию отображается для значения пиков в
% таблице редактируемых кривых. Его можно изменить совершив двойное нажатие
% мышкой на интересуемой строке значений таблицы отображения всех
% характерных значений данного региона:
B.currentViewParameterRegion = 'G-faktor';

% Текущий параметр, который отображается во втором столбце таблицы
% редактируемых кривых. Если хотим его изменить, то аналогично предыдущему
% параметру просто двойным кликом мышки выбираем интересующий нас параметр
% в таблице параметров для Пика|Региона
% Замечу, что данный параметр будет принимать значения только из данного
% пространства событий: 
%                       'Curve Name' = B.Curve(cn).FileName
%                       'Angle' = B.Curve(cn).AngleValue
B.currentViewParameterCurve = 'Curve Name';

scrsz = get(0,'ScreenSize'); % размеры экрана монитора

wWin = 1100; % ширина окна
hWin = 700; % высота окна
B.wscr = wWin;
B.hscr = hWin;

B.subAxesWidth = 315;
B.subAxesHeight = 140;
B.waxe = wWin-B.subAxesWidth; % ширина осей
B.haxe = hWin-B.subAxesHeight; % высота осей

pl = 0.5*(scrsz(3) - wWin);
pu = 0.5*(scrsz(4) - hWin);
% B.figColorBG = get(0,'DefaultUicontrolBackgroundColor');
B.figColorBG = [156, 154, 152]/255;
B.figFontName = 'Arial';
B.pl = pl;
B.pu = pu;

% hFig = figure('Position', [pl pu wscr hscr], 'CloseRequestFcn',@CloseAndGo, 'Name',nameFigTxt);
% B.hFig = figure('Position', [pl pu B.wscr B.hscr],'Resize', 'off', 'MenuBar', 'none', 'Name','display EPR data');
B.hFig = figure('Position', [pl pu B.wscr B.hscr], 'MenuBar', 'none', 'Name',[' The program ', B.verVar, ' allows you to work easily with the EPR spectra'],...
    'NumberTitle','off', 'Color', B.figColorBG);
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
jframe=get(B.hFig,'javaframe');
jIcon=javax.swing.ImageIcon('./icons/main/default_icon.png');
jframe.setFigureIcon(jIcon);
% B.hFig = figure('Position', [pl pu B.wscr B.hscr],  'Name','display EPR data');


% set(B.hFig,'renderer','painters');
set(B.hFig,'renderer','OpenGL');

    B.hTabGroup = addtabpanel(... % возвращает массив панелей сколько передано заголовков закладок
        B.hFig,... % родитель - figure или uipanel
        {'main','Table','3-D'},.... % заголовки закладок
        'activetabnum', 1,.... % активная закладка при первом открытии
        'units', 'Normalized',.... % Normalized по умолчанию
        'position', [0 0 1 1],.... % позиция
        'borderwidht', 0,.... % ширина рамки вокруг панелей панелей
        'tabheight', 20,.... % высота закладок в пикселях
        'tabwidth', {0.1,0.1},.... % ширина закладок в процентах (одно значение или cell)
        'tabcolor', {B.figColorBG,B.figColorBG},.... % цвет закладок (одно значение или cell)
        'FontName',B.figFontName ,.... % шрифт закладок (одно значение или cell)
        'FontAngle', 'normal',.... % наклон шрифта закладок (одно значение или cell)
        'FontSize', 11,.... % размер шрифта закладок (одно значение или cell)
        'FontColor', 'k'.... % цвет шрифта закладок (одно значение или cell)
        );

B.tab_main = B.hTabGroup(1);
pause (0.1);
drawnow;
% B.axShiftXdelta = get(B.tab_main,'borderwidht');
% disp(B.axShiftXdelta(:));
B.axShiftX = 60;
B.axShiftY = 60;
B.hAxes = axes ('parent', B.tab_main,'Units', 'pixels','Position',[B.axShiftX B.axShiftY B.waxe B.haxe]);% В процентах
axis manual;
if verLessThan('matlab', '8.4') % R2014b
            try    % R2008a and later
            catch % R2007b and earlier
            end
else
     set(B.hAxes, 'Clipping','on', 'ClippingStyle', 'rectangle');
end

B.buttonHigh = 20;
B.buttonWidth = 50;
B.axPoligonX = [B.axShiftX, B.waxe+B.axShiftX, B.waxe+B.axShiftX, B.axShiftX];
B.axPoligonY = [B.axShiftY, B.axShiftY, B.haxe+B.axShiftY, B.haxe+B.axShiftY];


B.btFirstLineShft = 30;
B.btFirstLineShftX = 35;
B.btLongTypeSize = [80, 25];
B.btSmallTypeSize = [25, 25];
B.btLastLineShft = 5;
B.btLastLineShftX = 5;
B.btDstBtw = 5;% Расстояние между кнопками
B.ht_filenameSize = [350 B.btSmallTypeSize(2)];
B.ht_ColorTxtField = [139, 153, 162]./255;
B.hAxesColor = [173,173,165]/255;
B.lb_width = 220;
B.lb_borderSize = 20;% отступы между объектами ListBox
B.lb_High = round((B.haxe - (B.lb_borderSize*2))/3);
B.tableWinSizeK = 1/2;% Какая часть от высоты hAxes будет занимать окно таблицы
B.tableWinSize = [B.wscr - B.axShiftX - B.lb_borderSize, ...
    round(B.haxe*B.tableWinSizeK) - B.axShiftY ]; % размер таблицы с информацией о пиках
B.dh_forAxes = 0;% Смещение по Y для осей, которое будет высчитываться на основании размера B.tableWinSize
% Размер самой таблицы с информацией о пиках:
B.peakInfoTableSize = [B.tableWinSize(1), B.tableWinSize(2) - B.btSmallTypeSize(2) - B.btDstBtw];
% B.lb_borderSize - B.btLastLineShft - B.btDstBtw - B.btSmallTypeSize(2)
% Кнопка прятания таблицы для информации о пиках [центр (X,Y) i-го пика для
% характеристической линии и его полуширина]
B.tb_hideTable = uicontrol('parent', B.tab_main,'Style','togglebutton','Value',0,...
               'Units','Pixels',...
               'Position',[B.btLastLineShftX B.axShiftY+B.btLastLineShft - B.btSmallTypeSize(2), B.btSmallTypeSize],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'CData', imread('./icons/24x23/hide_table_n.jpg'),...
               'TooltipString','Unhide Peaks Data table');
B.tb_hideTable_ok = 1;% контроллер моды, когда необходимо показывать таблицу значений, 
% чтобы во время изменения размера главного окна программы мы не прибавляли или 
% отнимали бесконечное число раз к размерам hAxes высоту таблицы (+1/-1)
           
% B.hTable = round(0.2*B.hscr);% Высота места для таблицы с данными для ЭПР пиков
           
B.ht_filename = uicontrol('parent', B.tab_main,'Style','edit',...
               'Position',[B.btLastLineShftX + B.btSmallTypeSize(1)+ B.btDstBtw B.btLastLineShft B.ht_filenameSize],...
               'BackgroundColor', B.ht_ColorTxtField, 'SelectionHighlight', 'off',...
               'string', 'filename',...
               'TooltipString','The opened file full-name');
           
% Кнопка вызова окошка информации о программе About           
B.hb_about = uicontrol('parent', B.tab_main,'Style','pushbutton','Value',1,...
               'Units','Pixels',...
               'Position',[B.btLastLineShftX, B.axShiftY+B.haxe+B.btFirstLineShft, B.btSmallTypeSize],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'String','?',...
               'TooltipString','Information about this program');
% Кнопка информации о загруженном файле
B.hb_info = uicontrol('parent', B.tab_main,'Style','pushbutton','Value',0,...
               'Units','Pixels',...
               'Position',[B.btFirstLineShftX B.axShiftY+B.haxe+B.btFirstLineShft, B.btLongTypeSize ],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'CData', imread('./icons/78x23/info_n.jpg'),...
               'TooltipString','Information about opened file');            
B.hb_autoScale = uicontrol('parent', B.tab_main,'Style','pushbutton','Value',1,...
               'Units','Pixels',...
               'Position',[B.btFirstLineShftX + B.btLongTypeSize(1) + B.btDstBtw, B.axShiftY+B.haxe+B.btFirstLineShft, B.btSmallTypeSize ],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'CData', imread('./icons/24x23/view_all_n.jpg'),...
               'TooltipString','View all spectra on the axes');
                prBtPos = get(B.hb_autoScale,'position');
B.hb_fixScale = uicontrol('parent', B.tab_main,'Style','togglebutton','Value',1,...
               'Units','Pixels',...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'CData', imread('./icons/24x23/autoscale_pr.jpg'),...
               'TooltipString','Autoscale mode is Off');
           
               prBtPos = get(B.hb_fixScale,'position');
B.tb_RecZoom = uicontrol('parent', B.tab_main,'Style','togglebutton','Value',1,...
               'Units','Pixels',...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'CData', imread('./icons/24x23/rec_zoom_pr.jpg'),...
               'TooltipString','Rectangular zooming mode is On');
           
                prBtPos = get(B.tb_RecZoom,'position');
B.hb_Smooth = uicontrol('parent', B.tab_main,'Style','pushbutton','Value',1,...
               'Units','Pixels',...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'CData', imread('./icons/24x23/smooth_n.jpg'),...
               'TooltipString','Smooth the spectra');
                
                prBtPos = get(B.hb_Smooth,'position');
B.eb_Smooth = uicontrol('parent', B.tab_main,'Style','edit','Value',1,...
               'Units','Pixels',...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,B.btLongTypeSize(1)-prBtPos(3),0],...
               'BackgroundColor', B.ht_ColorTxtField, 'SelectionHighlight', 'off',...
               'String','5',...
               'TooltipString','Value for the smooth procedure');

B.eb_MagneticFieldCalibration = uicontrol('parent', B.tab_main,'Style','edit','Value',1,...
               'Units','Pixels',...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),-(B.buttonHigh+B.btLastLineShft/2),B.btLongTypeSize(1)-prBtPos(3),0],...
               'BackgroundColor', B.ht_ColorTxtField, 'SelectionHighlight', 'off',...
               'String',num2str(B.magnetic_field_shift),...
               'TooltipString','Magnetic field shift value [Oe/Gs]');
           
B.txt_MagneticFieldCalibration = uicontrol('parent', B.tab_main,'Style','text','Value',1,...
               'Units','Pixels',...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3)-80,-(B.buttonHigh+B.btLastLineShft+2),B.btLongTypeSize(1)-prBtPos(3),0],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'String','Field calib.');           
                prBtPos = get(B.eb_Smooth,'position');
B.hb_ViewSrcData = uicontrol('parent', B.tab_main,'Style','pushbutton','Value',1,...
               'Units','Pixels',...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,B.btSmallTypeSize(1)-B.btLongTypeSize(1),0],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'CData', imread('./icons/24x23/raw_data_n.jpg'),...
               'TooltipString','Load to RAW spectras DATA');
           
                prBtPos = get(B.hb_ViewSrcData,'position');
B.hb_BaseLine = uicontrol('parent', B.tab_main,'Style','pushbutton','Value',1,...
               'Units','Pixels',...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'CData', imread('./icons/24x23/base_line_n.jpg'),...
               'TooltipString','Fit spectra by Base Line');
                      
                prBtPos = get(B.hb_BaseLine,'position');
B.tb_peakSearch = uicontrol('parent', B.tab_main,'Style','togglebutton','Value',0,...
               'Units','Pixels',...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'CData', imread('./icons/24x23/peak_search_n.jpg'),...
               'TooltipString','Automatic peak search in the area view');
           
               prBtPos = get(B.tb_peakSearch,'position');
B.tb_peakEdit = uicontrol('parent', B.tab_main,'Style','togglebutton','Value',0,...
               'Units','Pixels',...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'CData', imread('./icons/24x23/peak_edit_n.jpg'),...
               'TooltipString','Edit peak mode is off');
           
                prBtPos = get(B.tb_peakEdit,'position');
B.hb_peakDel = uicontrol('parent', B.tab_main,'Style','pushbutton','Value',0,...
               'Units','Pixels',...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'CData', imread('./icons/24x23/peak_del_n.jpg'),...
               'TooltipString','Delete peak');
           
                prBtPos = get(B.hb_peakDel,'position');
B.hb_peakPrev = uicontrol('parent', B.tab_main,'Style','pushbutton','Value',0,...
               'Units','Pixels',...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'CData', imread('./icons/24x23/peak_prev_n.jpg'),...
               'TooltipString','Previous peak');
           
                prBtPos = get(B.hb_peakPrev,'position');
B.hb_peakNext = uicontrol('parent', B.tab_main,'Style','pushbutton','Value',0,...
               'Units','Pixels',...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'CData', imread('./icons/24x23/peak_next_n.jpg'),...
               'TooltipString','Next peak');
                
                prBtPos = get(B.hb_peakNext,'position');
B.hb_curveAdd = uicontrol('parent', B.tab_main,'Style','pushbutton','Value',0,...
               'Units','Pixels',...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'CData', imread('./icons/24x23/curve_add_n.jpg'),...
               'TooltipString','Add curve');
           
                prBtPos = get(B.hb_curveAdd,'position');
B.hb_curveDel = uicontrol('parent', B.tab_main,'Style','pushbutton','Value',0,...
               'Units','Pixels',...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'CData', imread('./icons/24x23/curve_delete_n.jpg'),...
               'TooltipString','Delete curve');
           
                prBtPos = get(B.hb_curveDel,'position');
B.hb_curvePrev = uicontrol('parent', B.tab_main,'Style','pushbutton','Value',0,...
               'Units','Pixels',...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'CData', imread('./icons/24x23/curve_prev_n.jpg'),...
               'TooltipString','Previous curve');
               
               prBtPos = get(B.hb_curvePrev,'position');
B.hb_curveNext = uicontrol('parent', B.tab_main,'Style','pushbutton','Value',0,...
               'Units','Pixels',...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'CData', imread('./icons/24x23/curve_next_n.jpg'),...
               'TooltipString','Next curve');
           
                prBtPos = get(B.hb_curveNext,'position');
B.hb_curvesPurge = uicontrol('parent', B.tab_main,'Style','pushbutton','Value',0,...
               'Units','Pixels',...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'CData', imread('./icons/24x23/curves_purge_n.jpg'),...
               'TooltipString','Purge the all curves');
           
                prBtPos = get(B.hb_curvesPurge,'position');
B.tb_storeData = uicontrol('parent', B.tab_main,'Style','togglebutton','Value',1,...
               'Units','Pixels',...
               'Position',prBtPos + [B.btDstBtw+prBtPos(3),0,0,0],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'CData', imread('./icons/24x23/store_data_pr.jpg'),...
               'TooltipString','Store data mode is On');
%-----------------               
                prBtPosAx = get(B.hAxes,'position');
                prBtPos = get(B.hb_BaseLine,'position');
% Кнопка вызова дополнительного окна настроек и опций программы:
B.hb_options = uicontrol('parent', B.tab_main,'Style','pushbutton','Value',1,...
               'Units','Pixels',...
               'Position',[B.waxe+B.axShiftX-B.btSmallTypeSize(1), prBtPos(2:end)],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'CData', imread('./icons/24x23/properties_n.jpg'),...
               'TooltipString','Open properties window');
%-----------------    

                prBtPos = get(B.hb_options,'position');
% Кнопка загрузки данных из файла
B.hb_load = uicontrol('parent', B.tab_main,'Style','pushbutton','Value',1,...
               'Units','Pixels',...
               'Position',[prBtPos(1)+prBtPos(3)+round(B.btDstBtw/2), prBtPos(2), B.btLongTypeSize],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'CData', imread('./icons/78x23/load_n.jpg'),...
               'TooltipString','Select new folder for load DATA');
           
                prBtPos = get(B.hb_load,'position');
% Кнопка сохранения в файл *.png           
B.hb_save = uicontrol('parent', B.tab_main,'Style','pushbutton','Value',0,...
               'Units','Pixels',...
               'Position',[prBtPos(1)+prBtPos(3)+round(B.btDstBtw/2), prBtPos(2), B.btLongTypeSize],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'CData', imread('./icons/78x23/export_n.jpg'),...
               'TooltipString','Export loaded DATA to ASCII file');
           
               prBtPos = get(B.hb_save,'position'); 
% Кнопка закрытия и передача данных на вывод  
B.hb_exit = uicontrol('parent', B.tab_main,'Style','togglebutton','Value',0,...
               'Units','Pixels',...
               'Position',[prBtPos(1)+prBtPos(3)+round(B.btDstBtw/2), prBtPos(2), B.btLongTypeSize],...
               'BackgroundColor', B.figColorBG, 'SelectionHighlight', 'off',...
               'CData', imread('./icons/78x23/exit_n.jpg'),...
               'TooltipString','Exit from DERNIAN program');
% --------------------- ListBox



B.lb_dir = uicontrol('parent', B.tab_main,'Style','listbox',...
               'Position',[B.waxe+B.axShiftX+B.lb_borderSize, B.haxe+B.axShiftY - B.lb_High, B.lb_width, B.lb_High],...
               'BackgroundColor', B.ht_ColorTxtField,'String','Dir'); 
B.lb_files = uicontrol('parent', B.tab_main,'Style','listbox',...
               'Position',[B.waxe+B.axShiftX+B.lb_borderSize, B.haxe+B.axShiftY-2*B.lb_High-B.lb_borderSize, B.lb_width, B.lb_High],...
               'BackgroundColor', B.ht_ColorTxtField,'String','files');

B.lb_struct = uicontrol('parent', B.tab_main,'Style','listbox',...
               'Position',[B.waxe+B.axShiftX+B.lb_borderSize, B.axShiftY, B.lb_width, B.lb_High],...
               'BackgroundColor', B.ht_ColorTxtField,'String','struct');

% B.lb_text = uicontrol('Style','text',...
%                'Position',[B.waxe+B.axShiftX+20+B.lb_width+20, B.axShiftY, B.lb_width-40, B.haxe],...
%                'String','info'); 
           
% Задаем начальное значение для включения оции по автоматическому сглаживанию загружаемых спектров ЭПР
B.valeAutoSmoothForLoadSpectra = 1;
B.valeAutoSmoothForLoadSpectra_number = 5;

% B.onlyDirs = dir(B.defPath);
[B.dirFullList, B.dirNameList] = getDirs(B.defPath);
[B.fileFullList, B.fileNameList] = get_EPRspectra_Files(B.defPath);
set(B.lb_dir, 'string', B.dirNameList);   
set(B.lb_files, 'string', B.fileNameList, 'min', 0, 'max', length(B.fileNameList));

if ~isempty(B.fileFullList)
    setappdata(B.hFig,'B',B);
    [B.X,B.Y,B.alpha, B.info, B.src_Y]=mload_EPR_data(B.fileFullList{1}, B);
    freq = regexp(B.info.FrequencyMon, '[-+]?[0-9]*\.?[0-9]+', 'match');
    B.freq = str2num(freq{1});
    B.y = B.Y(:,1);
    B.x = B.X;
    B.src_y = B.src_Y(:,1);
    set(B.ht_filename, 'string', B.fileNameList{1});
else
    B.x = [0, 1];
    B.y = [0, 1];
    B.src_y = [0, 1];
    B.alpha = '--';
    B.info = '--';
    set(B.ht_filename, 'string', 'filename');
    B.fileFullList = {'filename'};
end
set(B.lb_struct, 'string', B.alpha,'min', 0, 'max', length(B.alpha));
% set(B.lb_text, 'style', 'text');
% B.infoTXT = evalc('disp(B.info)');
% set(B.lb_text, 'string', B.infoTXT);
% set(B.lb_text, 'style', 'listbox');

% Записываем данные в переменные, которые являются показателем единственности или
% уникальности той или иной просматриваемой кривой из уже просмотренных
% ранее кривых
% Эти две сторки дублируются в конце файла mDisplayEPRfiles_loadData_v_01(B)
B.currentCurveDirName = B.defPath;
B.currentCurveFileName =  get (B.ht_filename, 'string');
B.indexFiles = get(B.lb_files, 'Value');
B.indexStruct = get(B.lb_struct, 'Value');
[m,n] = size(B.alpha);
    if m>1
        B.currentCurveAngleValue = B.alpha(B.indexStruct,:);
        B.currentCurveFullFileName =  B.fileFullList{B.indexFiles};
    else
        B.currentCurveAngleValue = B.alpha;
        B.currentCurveFullFileName =  B.fileFullList{B.indexFiles};
    end

% Задаем начальное значение по количеству отображения спектров ЭПР
B.valEnableShadowView = 0;
B.valAfter = 1;
B.valBefore = 1;

% Строим побочные графики из режима ShadowView:
B.dataXY_before(1) = plot(B.x,B.y, 'color', [1,0.3,0.3]);


hold on;
grid on;

B.dataXY_before(2) = plot(B.x,B.y, 'color', [1,0.5,0.5]);
B.dataXY_before(3) = plot(B.x,B.y, 'color', [1,0.7,0.7]);

B.dataXY_after(1) = plot(B.x,B.y, 'color', [0.3, 0.3, 1.0]);
B.dataXY_after(2) = plot(B.x,B.y, 'color', [0.5, 0.5, 1.0]);
B.dataXY_after(3) = plot(B.x,B.y, 'color', [1, 0.2, 1]);

for i = 1:3
    B.x_before{i} = B.x;
    B.y_before{i} = B.y;
    B.x_after{i} = B.x;
    B.y_after{i} = B.y;
    set (B.dataXY_before(i), 'Visible', 'off');
    set (B.dataXY_after(i), 'Visible', 'off');
end


% Строим основной график
B.dataXY = plot(B.x,B.y, 'color', 'k', 'LineWidth', 1);

B.indexDirOld = get(B.lb_dir, 'Value');
B.indexFilesOld = get(B.lb_files, 'Value');
B.indexStructOld = get(B.lb_struct, 'Value');

% =========================
B.wgrReal = get(B.hAxes,'XLim');
B.wgr = B.wgrReal(2) - B.wgrReal(1);
B.Xc = (B.wgrReal(2) + B.wgrReal(1))*0.5;
B.hgrReal = get(B.hAxes,'YLim');
B.hgr = B.hgrReal(2) - B.hgrReal(1);
B.Yc = (B.hgrReal(2) + B.hgrReal(1))*0.5;

B.scw = B.waxe/B.wgr; % масштаб по x
B.waxe0 = B.waxe;
B.sch = B.haxe/B.hgr; % масштаб по y

B.p = get(B.hFig, 'CurrentPoint');
% Рисуем линии курсора:
B.mcpLineY = plot ([B.p(1),B.p(1)], B.hgrReal, 'r');
B.mcpLineX = plot (B.wgrReal, [B.p(2),B.p(2)], 'r');

% Рисуем прямоугольник зоны зумирования по зажатой левой кнопке мышки:
setappdata(B.hFig,'B',B);
mDisplayEPRfiles_plotRectangle_v_01 (B,[B.p(1),B.p(2),B.wgr,B.hgr]);
B = getappdata(B.hFig,'B');
set(B.mcpRecZoom, 'Visible', 'off');

% Рисуем линии и прямоугольник для измерения высоты по зажатой правой
% кнопке мышки
setappdata(B.hFig,'B',B);
mDisplayEPRfiles_plotRectangleForMeasureY_v_01 (B,[B.p(1),B.p(2),B.wgr,B.hgr]);
B = getappdata(B.hFig,'B');


B.Y0 = plot (B.wgrReal,[0, 0], 'b');


hold off;
B.mip = 0;
B.savePng = 0; % Не записываем в png файл

B.wgrReal_start = B.wgrReal;
B.hgrReal_start = B.hgrReal;
B.new_x = 0;
B.new_y = 0;
B.start_x = B.new_x;
B.start_y = B.new_y;
B.new_x = (B.p(1)-B.axShiftX + B.wgrReal(1)*B.scw)/B.scw;
B.new_y = (B.p(2)-B.axShiftY + B.hgrReal(1)*B.sch)/B.sch;
set(B.mcpLineY, 'XData',[B.new_x,B.new_x], 'YData', B.hgrReal);
set(B.mcpLineX, 'XData',B.wgrReal, 'YData',[B.new_y,B.new_y]);
B.leftMouseFirstClick = 0;
B.startRecPosition = [B.new_x,B.new_y];
B.endRecPosition = [B.new_x,B.new_y];
B.recW = 0;
B.recH = 0;

% Переменная проверки нахождения курсора мышки в пределах hAxes
B.chkMouseInAxesPolygon = 1;
% Переменная проверки нахождения точки первого клика startRecPosition курсора мышки в пределах hAxes
B.chkMouseStartClickPointInAxesPolygon = 1;
% Пишем текст в левом нижнем углу, который будет отображать текущие
% координаты указателя мышки:
str_txt = sprintf('%0.7g, %0.7g',B.new_x, B.new_y);
B.txtXY = text('Position',[B.wgrReal(1)+0.01*(B.wgrReal(2) - B.wgrReal(1)), ...
    B.hgrReal(1)+ 0.01*(B.hgrReal(2) - B.hgrReal(1))], 'String', str_txt ,'FontSize',14);
set(B.txtXY, 'BackgroundColor', B.hAxesColor+ 0.8*(1-B.hAxesColor),'FontName',B.figFontName);

% Пишем текст рядом с указателем мышки, который появится по нажатию левой
% кнопки мышки:
B.ht_coordinates = text ('Position',[0.5,0.5],'string','0,0','FontSize',14,'FontName',B.figFontName);
% set(B.ht_coordinates, 'BackgroundColor', [0.87,0.87,0.87]);

set(B.hAxes, 'Color', B.hAxesColor);
setappdata(B.hFig,'B',B);

%-------------------------- uicontextmenu
% B.cmenu = uicontextmenu;
% % Create the parent menu
% B.uimenuCm1 = uimenu(B.cmenu, 'label','paint bg');
% % Create the submenu
% B.hcm_item1 = uimenu(B.uimenuCm1, 'Label', 'paint', 'Callback', {@f_hcb1,B});
% B.hcm_item2 = uimenu(B.uimenuCm1, 'Label', 'return', 'Callback', {@f_hcb2,B});
% 
% % Create the parent menu
% B.uimenuCm2 = uimenu(B.cmenu, 'label','paint bg');
% % Create the submenu
% B.hcm_item3 = uimenu(B.uimenuCm2, 'Label', 'paint2', 'Callback', {@f_hcb1,B});
% B.hcm_item4 = uimenu(B.uimenuCm2, 'Label', 'return2', 'Callback', {@f_hcb2,B});

% set(B.hAxes,'uicontextmenu',B.cmenu);
B.cmenu.lb_files.main = uicontextmenu;

B.cmenu.lb_files.pmCopyProperties = uimenu(B.cmenu.lb_files.main, 'label','Copy Properties', 'Callback', {@f_CopyProperties,B});
B.cmenu.lb_files.pmPastProperties = uimenu(B.cmenu.lb_files.main, 'label','Past Properties', 'Callback', {@f_PastPropertiesInFiles,B});

B.cmenu.lb_struct.main = uicontextmenu;

B.cmenu.lb_struct.pmCopyProperties = uimenu(B.cmenu.lb_struct.main, 'label','Copy Properties', 'Callback', {@f_CopyProperties,B});
B.cmenu.lb_struct.pmPastProperties = uimenu(B.cmenu.lb_struct.main, 'label','Past Properties', 'Callback', {@f_PastPropertiesInStructures,B});
% B.cmenu.lb_struct.main.Visible = 'on';
% 
% B.cmenu.lb_struct.pmPastProperties.Visible = 'on';
% B.cmenu.lb_struct.pmPastProperties.Enable = 'on';
% 
% B.cmenu.lb_struct.pmCopyProperties.Visible = 'on';
% B.cmenu.lb_struct.pmCopyProperties.Enable = 'on';
% B.cmenu.lb_struct.main.Visible = 'off';
set(B.lb_struct,'uicontextmenu',B.cmenu.lb_struct.main);
set(B.lb_files,'uicontextmenu',B.cmenu.lb_files.main);



set(B.hFig ,'WindowButtonMotionFcn', {@mouseMotionFcn},...
            'WindowButtonDownFcn', {@mouseButtonDownFcn},...
            'WindowButtonUpFcn', {@mouseButtonUpFcn},...
            'renderer', 'OpenGL',...
            'KeyPressFcn',@KeyPressFcn_callback,...
            'KeyReleaseFcn',@KeyReleaseFcn_callback,...
            'WindowScrollWheelFcn',@figScroll,...
            'ResizeFcn', @figResizeFcn);

drawnow;
pause(0.01);
LimitSizeFig(B.hFig, 'min', [B.wscr, B.hscr]);

set(B.lb_dir, 'Callback', {@lb_dir_listbox_ButtonDownFcn});
set(B.lb_files, 'Callback', {@lb_listbox_ButtonDownFcn});
set(B.lb_struct, 'Callback', {@lb_listbox_ButtonDownFcn});



set(B.hb_autoScale,'callback',@setAutoScale);

set(B.hb_about,'callback',@f_aboutProgram);
set(B.hb_options,'callback',@f_setOptions);
set(B.hb_save,'callback',@saveData);
set(B.hb_exit,'callback',@f_exit);
set(B.hb_load,'callback',@loadFiles);
set(B.hb_fixScale,'callback',@hb_chgBgClrAndName_ButtonDownFcn);
set(B.tb_RecZoom,'callback',@tb_chgBgClrAndName_ButtonDownFcn);
set(B.hb_info, 'callback',@viewInfo);

set(B.eb_Smooth, 'callback',@f_Smooth);
set(B.hb_Smooth, 'callback',@f_Smooth);
set(B.eb_MagneticFieldCalibration, 'callback',@f_fieldCalibration);
set(B.hb_ViewSrcData, 'callback',@f_ViewSrcData);
set(B.hb_BaseLine, 'callback',@f_BaseLine);
set(B.tb_hideTable, 'callback',@f_hideTable);
set(B.tb_peakSearch, 'callback',@f_peakSearch);
set(B.tb_peakEdit, 'callback',@f_peakEdit);
set(B.hb_peakDel, 'callback',@f_peakDel);
set(B.hb_curveDel, 'callback',@f_curveDel);
set(B.hb_curvesPurge, 'callback',@f_curvesPurge);
set(B.tb_storeData, 'callback',@f_storeData);

% set(B.hFig,'renderer','painters');
% Контроль нажатия левой или правой кнопки мышки первый раз
            B.lmbdCheckFirstTimeClick = 0;
            B.rmbdCheckFirstTimeClick = 0;
            
B.p = get(B.hFig, 'CurrentPoint');
% set(B.hFig,'renderer','OpenGL');
setappdata(B.hFig,'B',B);
mDisplayEPRfiles_pltData_v_02 (B);
B = getappdata(B.hFig,'B');

% Еще раз вызываем функцию перерисовки области окна после изменения размера
% т.к. не все элементы отображаются без вызова этой функции
figResizeFcn(B.hFig);

    function mouseMotionFcn(src,eventdata)
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_moveMouseFcn_v_01(B);
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
        
    end
    function mouseButtonDownFcn(src,eventdata)
        B = getappdata(B.hFig,'B');
        B.startRecPosition = [B.new_x,B.new_y];
        B.chkMouseStartClickPointInAxesPolygon = inpolygon(B.startRecPosition(1),B.startRecPosition(2),...
            [B.wgrReal(1), B.wgrReal(2), B.wgrReal(2), B.wgrReal(1)],[B.hgrReal(1),B.hgrReal(1),B.hgrReal(2),B.hgrReal(2)]);

%         disp(B.startRecPosition);
        B.leftMouseFirstClick = 0;
        % Обработака событий нажатия мышкой одинарного или двойного:
        m_type = get(B.hFig, 'SelectionType');
        if strcmp(m_type, 'normal')
            % Контроль нажатия левой кнопки мышки первый раз
            B.lmbdCheckFirstTimeClick = 1;
%             fprintf('left mouse click\n');
        elseif strcmp(m_type, 'alt')
            % Контроль нажатия правой кнопки мышки первый раз
            B.rmbdCheckFirstTimeClick = 1;
%             fprintf('right mouse click\n'); 
                setappdata(B.hFig,'B',B);
                f_ActivateRightClicMenu(B);
                B = getappdata(B.hFig,'B');
        elseif strcmp(m_type, 'open')
%             fprintf('double-click\n');
        % По двойному нажатию мышки автомасштабируем кривую на графике
            setappdata(B.hFig,'B',B);
            mDoubleClickActions(B)
            B = getappdata(B.hFig,'B');
        end
        
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_mousePushDownFcn_v_01(B);
        B = getappdata(B.hFig,'B');
        
        
        
        setappdata(B.hFig,'B',B);
    end % mouseButtonDownFcn

    function mouseButtonUpFcn(src,eventdata)
        B = getappdata(B.hFig,'B');
        set(B.mcpRecZoom, 'Visible', 'off');
        B.endRecPosition = [B.new_x,B.new_y];
        B.leftMouseFirstClick = 0;
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_mousePushUpFcn_v_01 (B);
        B = getappdata(B.hFig,'B');
        B.mip = 0;
        setappdata(B.hFig,'B',B);
%         disp('Up');
%         disp(B.mip);
    end % mouseButtonUpFcn

    function KeyReleaseFcn_callback(src,eventdata)
        % Событие по отжатию клавиши на клавиатуре
        B = getappdata(B.hFig,'B');
        B.key = 0;
        setappdata(B.hFig,'B',B);
    end

    function KeyPressFcn_callback(src,eventdata)
        % Событие по нажиманию клавиши на клавиатуре
        B = getappdata(B.hFig,'B');
        switch eventdata.Key 
            case  'control'
                B.key = 1;
            otherwise 
                B.key = 0;
        end
%         disp(src);
%         disp(eventdata);
        txt = sprintf('mip = %d, key = %d', B.mip, B.key);
        disp(txt);
        setappdata(B.hFig,'B',B);
        B = getappdata(B.hFig,'B');
        setappdata(B.hFig,'B',B);
    end
    function figScroll(src,evnt)
        % Масштабируем оси по движению колесика мышки
        B = getappdata(B.hFig,'B');
        mcp = get(B.hFig, 'CurrentPoint');
        if inpolygon(mcp(1), mcp(2), B.axPoligonX, B.axPoligonY) 
            setappdata(B.hFig,'B',B);
            B.wgrReal = get(B.hAxes,'XLim');
            B.wgr = B.wgrReal(2) - B.wgrReal(1);
            B.hgrReal = get(B.hAxes,'YLim');
            B.hgr = B.hgrReal(2) - B.hgrReal(1);
            u = (B.wgrReal(2) - B.new_x )/(B.new_x - B.wgrReal(1));
            w = (B.hgrReal(2) - B.new_y )/(B.new_y - B.hgrReal(1));
            if evnt.VerticalScrollCount > 0 
                % приближение
                alfa = 0.25;
            elseif evnt.VerticalScrollCount < 0 
                % отдаление
                alfa = -0.25;
            end
            x1 = B.wgrReal(1);
            x2 = B.wgrReal(2);
            y1 = B.hgrReal(1);
            y2 = B.hgrReal(2);
            x = B.new_x ;
            y = B.new_y ;

                % new X coordinates
                B.wgrReal(1) = x1-alfa*(x-x1);
                B.wgrReal(2) = x2+alfa*(x2-x);
                B.wgrReal = sort(B.wgrReal);
                % new Y coordinates
                B.hgrReal(1) = y1-alfa*(y-y1);
                B.hgrReal(2) = y2+alfa*(y2-y);
                B.hgrReal = sort(B.hgrReal);

            set(B.hAxes, 'XLim', B.wgrReal, 'YLim', B.hgrReal, 'XLimMode', 'manual', 'YLimMode', 'manual');
%             B.wgrReal = get(B.hAxes,'XLim');
%             B.hgrReal = get(B.hAxes,'YLim');
%             B.wgr = B.wgrReal(2) - B.wgrReal(1);
%             B.hgr = B.hgrReal(2) - B.hgrReal(1);
%             B.scw = B.waxe/B.wgr; % масштаб по x
%             B.sch = B.haxe/B.hgr; % масштаб по y
            setappdata(B.hFig,'B',B);
            mUpdateScaleVars (B);
            B = getappdata(B.hFig,'B');
            
            setappdata(B.hFig,'B',B);
            mDisplayEPRfiles_pltData_v_02(B);
            B = getappdata(B.hFig,'B');
        end
        setappdata(B.hFig,'B',B);
    end %figScroll

    function setAutoScale(src,eventdata)
        B = getappdata(B.hFig,'B');
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_autoScale_v_01(B);
        B = getappdata(B.hFig,'B');
        
        
        
        setappdata(B.hFig,'B',B);
    end
    function figResizeFcn(h,~)
        % Функция отслеживания изменения размера главного окна программы
        B = getappdata(B.hFig,'B');
        % Добавили функцию отслеживания изменения размера у tabPanel
        posp = get(h,'position');
        obj = findobj(h,'Tag','ui_EPR_TabGroup');
        for ii = 1:numel(obj)
            pos = get(obj(ii),'position');
            pgheight = pos(4);
            ud = get(obj(ii),'userdata');
            pos = ud.position;
            if strcmp(ud.units,'Normalized')
                pos = round([posp(3)*pos(1), posp(4)*pos(2), posp(3)*pos(3), posp(4)*pos(4)]);
            end
            d = 1;
            pos = pos+[d+1, d+1, -2*d, -2*d];
            panelsheight = pos(4)-pgheight+2;
            if panelsheight > 0
                set(obj(ii),'position',[5+pos(1),pos(2)+pos(4)-pgheight,pos(3)-2*5,pgheight])
                pos(4) = panelsheight;
                set(ud.bordpanel,'position',pos)
                d = ud.borderwidht;
                set(ud.panels,'position',[d, d, pos(3)-2*d-2, pos(4)-2*d-2])
            end
        end
        
        
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_resizeFcn_v_01 (B) 
        B = getappdata(B.hFig,'B');
        setappdata(B.hFig,'B',B);
    end
    function saveData(src,eventdata)
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_saveData_v_01 (B) 
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
    end
    function viewInfo(src,eventdata)
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_dataInfo_v_01 (B) 
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
    end

    function f_Smooth(src,eventdata)
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_dataSmooth_v_01 (B) 
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
    end

    function f_fieldCalibration(src,eventdata)
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_fieldCalibration (B) 
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
    end

    function f_ViewSrcData(src,eventdata)
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_ViewSrcData_v_01 (B) 
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
    end
    function f_BaseLine(src,eventdata)
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_BaseLine_v_01 (B) 
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
    end
    function f_hideTable(src,eventdata)
        % Прячем или показываем таблицу с данными о ЭПР пиках
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
        m_hideTable (B) 
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
    end
    function f_peakSearch(src,eventdata)
        % Прячем или показываем таблицу с данными о ЭПР пиках
        B = getappdata(B.hFig,'B');
       set(B.tb_peakSearch, 'CData', imread('./icons/24x23/peak_search_pr.jpg'));
       % Включаем режим редактирования пиков и, соответственно их
       % отображения, если они были скрыты для данной кривой:
       set(B.tb_peakEdit, 'Value', 1); f_peakEdit(B);
       
        setappdata(B.hFig,'B',B);
        mSearchPeakInViewingRegion (B); 
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_pltData_v_02 (B);
        B = getappdata(B.hFig,'B');
        set(B.tb_peakSearch, 'CData', imread('./icons/24x23/peak_search_n.jpg'), 'Value',0);
        setappdata(B.hFig,'B',B);
    end
    function f_peakEdit(src,eventdata)
        % Прячем или показываем таблицу с данными о ЭПР пиках
        B = getappdata(B.hFig,'B');
        val = get(B.tb_peakEdit, 'Value');
        switch val
            case 1
                set(B.tb_peakEdit, 'CData', imread('./icons/24x23/peak_edit_pr.jpg'),...
                    'TooltipString','Edit peak mode is On');
                mVisibleGraphElementsForAllCurves (B,'off');
                mVisibleGraphElementsForCurrentCurve (B, 'on');
            case 0
                set(B.tb_peakEdit, 'CData', imread('./icons/24x23/peak_edit_n.jpg'),...
                    'TooltipString','Edit peak mode is Off');
                mVisibleGraphElementsForAllCurves (B,'off');
        end
        setappdata(B.hFig,'B',B);
        mUpdateScaleVars (B);
        B = getappdata(B.hFig,'B');
        setappdata(B.hFig,'B',B);
    end
    function f_peakDel(src,eventdata)
        % Удаляем выделенный пик
        B = getappdata(B.hFig,'B');
        setappdata(B.hFig,'B',B);
        f_DeletePeak(B);
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
        f_RearrangePeaks(B);
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
        mWriteDataToMainBottomTableCurves (B);
        B = getappdata(B.hFig,'B');
        setappdata(B.hFig,'B',B);
        mWriteDataToMainBottomTableRegion (B);
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_pltData_v_02 (B);
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
    end
    function f_curveDel(src,eventdata)
        % Очищаем кривую от всех пиков или инными словами удаляем кривую из
        % списка редактируемых кривых
        B = getappdata(B.hFig,'B');
        setappdata(B.hFig,'B',B);
        f_CleanCurve(B);
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
        f_RearrangeCurves(B);
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
        mWriteDataToMainBottomTableCurves (B);
        B = getappdata(B.hFig,'B');
        setappdata(B.hFig,'B',B);
        mWriteDataToMainBottomTableRegion (B);
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_pltData_v_02 (B);
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
    end
    function f_curvesPurge(src,eventdata)
        % Очищаем все кривые от созданных регионов
        B = getappdata(B.hFig,'B');
        setappdata(B.hFig,'B',B);
        f_PutgeCurves(B);
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
        mWriteDataToMainBottomTableCurves (B);
        B = getappdata(B.hFig,'B');
        setappdata(B.hFig,'B',B);
        mWriteDataToMainBottomTableRegion (B);
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_pltData_v_02 (B);
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
    end
    function f_storeData(src,eventdata)
        % Прячем или показываем таблицу с данными о ЭПР пиках
        B = getappdata(B.hFig,'B');
        val = get(B.tb_storeData, 'Value');
        switch val
            case 1
                set(B.tb_storeData, 'CData', imread('./icons/24x23/store_data_pr.jpg'),...
                    'TooltipString','Store Data mode is On');
%                 mVisibleGraphElementsForAllCurves (B,'off');
%                 mVisibleGraphElementsForCurrentCurve (B, 'on');
            case 0
                set(B.tb_storeData, 'CData', imread('./icons/24x23/store_data_n.jpg'),...
                    'TooltipString','Store Data mode is Off');
%                 mVisibleGraphElementsForAllCurves (B,'off');
        end
        setappdata(B.hFig,'B',B);
        f_StoreDataInTheDisk (B);
        B = getappdata(B.hFig,'B');
        setappdata(B.hFig,'B',B);
        mUpdateScaleVars (B);
        B = getappdata(B.hFig,'B');
        setappdata(B.hFig,'B',B);
    end




    function f_setOptions(src,eventdata)
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_setOptions_v_01 (B) 
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
    end
    function f_aboutProgram(src,eventdata)
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_aboutProgram_v_01 (B) 
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
    end
    function f_exit(src,eventdata)
        B = getappdata(B.hFig,'B');
        checkBopt = isfield(B,'hFigOptions');
        if checkBopt
            if ~isempty(B.hFigOptions)
                if ishandle(B.hFigOptions)
                    close(B.hFigOptions);
                    B.hFigOptions = [];
                end
            end
        end
        checkBopt = isfield(B,'hFigAbout');
        if checkBopt
            if ~isempty(B.hFigAbout)
                if ishandle(B.hFigAbout)
                    close(B.hFigAbout);
                    B.hFigAbout = [];
                end
            end
        end
        dataX = B.x;
        dataY = B.y;
        alpha = B.alpha;
          close(B.hFig);
          B.hFig = [];
    end
    function loadFiles(src,eventdata)
        B = getappdata(B.hFig,'B');
        prevPath = B.defPath;
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_loadDir_v_01 (B);
        B = getappdata(B.hFig,'B');
        if B.defPath == 0
            B.defPath = prevPath;
            return
        end
        % меняем статус, название и фон у кнопки hb_fixScale делаем
        % автомасштаб
        set(B.hb_fixScale, 'Value',0);
        set(B.hb_fixScale, 'BackgroundColor', [0.701961 0.701961 0.701961]);
        set(B.hb_fixScale, 'String', 'Auto scale');
        
                
        [B.dirFullList, B.dirNameList] = getDirs(B.defPath);
        [B.fileFullList, B.fileNameList] = get_EPRspectra_Files(B.defPath);
        B.indexDir = 1;
        set(B.lb_dir, 'Value',1);
        set(B.lb_files, 'Value', 1);
        set(B.lb_struct, 'Value', 1);
        
        B.indexFiles = get(B.lb_files, 'Value');
        B.indexStruct = get(B.lb_struct, 'Value');

        set(B.lb_dir, 'string', B.dirNameList);   
        set(B.lb_files, 'string', B.fileNameList, 'min', 0, 'max', length(B.fileNameList));
        if ~isempty(B.fileFullList)
            setappdata(B.hFig,'B',B);
            [B.X,B.Y,B.alpha,B.info,B.src_Y]=mload_EPR_data(B.fileFullList{1}, B);
            freq = regexp(B.info.FrequencyMon, '[-+]?[0-9]*\.?[0-9]+', 'match');
            B.freq = str2num(freq{1});
            B.y = B.Y(:,1);
            B.x = B.X;
            B.src_y = B.src_Y(:,1);
            set(B.ht_filename, 'string', B.fileNameList{1});
        else
            B.x = [0, 1];
            B.y = [0, 1];
            B.X = [0, 1]';
            B.Y = [0, 1]';
            B.src_y = [0, 1];
            B.alpha = '--';
            B.info = '--';
            set(B.ht_filename, 'string', 'filename');
            B.fileFullList = {'filename'};
        end
        
        set(B.lb_struct, 'string', B.alpha,'min', 0, 'max', length(B.alpha));
        % Записываем данные в переменные, которые являются показателем единственности или
        % уникальности той или иной просматриваемой кривой из уже просмотренных
        % ранее кривых
        B.currentCurveDirName = B.defPath;
        B.currentCurveFileName =  get (B.ht_filename, 'string');
        [m,n] = size(B.alpha);
            if m>1
                B.currentCurveAngleValue = B.alpha(B.indexStruct,:);
                B.currentCurveFullFileName =  B.fileFullList{B.indexFiles};
            else
                B.currentCurveAngleValue = B.alpha;
                B.currentCurveFullFileName =  B.fileFullList{B.indexFiles};
            end
        val = get(B.tb_peakEdit, 'Value');
        switch val
            case 1
                mVisibleGraphElementsForAllCurves (B,'off');
                setappdata(B.hFig,'B',B);
                mVisibleGraphElementsForCurrentCurve (B, 'on');
                B = getappdata(B.hFig,'B');

            case 0
                mVisibleGraphElementsForAllCurves (B,'off');
                setappdata(B.hFig,'B',B);
                mVisibleGraphElementsForCurrentCurve (B, 'off');
                B = getappdata(B.hFig,'B');
        end
        B.currentCurveNumber = mGetCurrentCurveNumber(B);
        % Перерисовываем график функции (спектра ЭПР) с новыми значениями XY:
        set(B.dataXY, 'XData',B.x, 'YData', B.y);

        B.indexDirOld = B.indexDir;
        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_autoScale_v_01(B);
        B = getappdata(B.hFig,'B');

        setappdata(B.hFig,'B',B);
        mDisplayEPRfiles_pltData_v_02 (B);
        B = getappdata(B.hFig,'B');
    % меняем статус, название и фон у кнопки hb_fixScale делаем
    % автомасштаб
    set(B.hb_fixScale, 'Value',0);
        setappdata(B.hFig,'B',B);
        mCheckButtonStatusFunction(B);
        B = getappdata(B.hFig,'B');
        
        setappdata(B.hFig,'B',B);
    end
    function lb_listbox_ButtonDownFcn(src,eventdata)
        B = getappdata(B.hFig,'B');
        
%         m_type = get(get(src,'parent'), 'SelectionType');
        m_type = get(B.hFig, 'SelectionType');
        if strcmp(m_type, 'normal')
%             fprintf('left mouse click\n');
            setappdata(B.hFig,'B',B);
            mDisplayEPRfiles_loadData_v_01(B);
            B = getappdata(B.hFig,'B');
        elseif strcmp(m_type, 'alt')
%             fprintf('right mouse click\n'); 
            setappdata(B.hFig,'B',B);
            mDisplayEPRfiles_loadData_v_01(B);
            B = getappdata(B.hFig,'B');
        elseif strcmp(m_type, 'open')
%             fprintf('double-click\n');
            setappdata(B.hFig,'B',B);
            mDisplayEPRfiles_loadData_v_01(B);
            B = getappdata(B.hFig,'B');
        end
        
        setappdata(B.hFig,'B',B);
    end
    function lb_dir_listbox_ButtonDownFcn(src,eventdata)
        B = getappdata(B.hFig,'B');
        % У самого listbox нет свойства 'SelectionType', но зато это
        % событие есть у фигуры-родителя, на которой расположен listbox,
        % потому спрашиваем двойное нажатие у этого родителя:
        % m_type = get(get(src,'parent'), 'SelectionType');
        m_type = get(B.hFig, 'SelectionType');
        if strcmp(m_type, 'open')
            setappdata(B.hFig,'B',B);
            mDisplayEPRfiles_loadData_v_01(B);
            B = getappdata(B.hFig,'B');
        end
%         if strcmp(m_type, 'normal')
%             fprintf('left mouse click\n');
%         elseif strcmp(m_type, 'alt')
%             fprintf('right mouse click\n'); 
%         elseif strcmp(m_type, 'open')
%             fprintf('double-click\n');
%         end
        
        
        setappdata(B.hFig,'B',B);
    end
    function hb_chgBgClrAndName_ButtonDownFcn(src,eventdata)
        % меняем статус, название и фон у кнопки fixScale
        B = getappdata(B.hFig,'B');
        B.freezeScale = get(B.hb_fixScale, 'Value');
        if B.freezeScale == 1
            set(B.hb_fixScale, 'CData', imread('./icons/24x23/autoscale_pr.jpg'),...
               'TooltipString','Autoscale mode is Off');
        else
            set(B.hb_fixScale, 'CData', imread('./icons/24x23/autoscale_n.jpg'),...
               'TooltipString','Autoscale mode is On');
        end
        
        setappdata(B.hFig,'B',B);
    end
    function tb_chgBgClrAndName_ButtonDownFcn(src,eventdata)
        % меняем статус, название и фон у кнопки RecZoom
        B = getappdata(B.hFig,'B');
        B.recZoom = get(B.tb_RecZoom, 'Value');
        if B.recZoom == 1
            set(B.tb_RecZoom, 'CData', imread('./icons/24x23/rec_zoom_pr.jpg'),...
               'TooltipString','Rectangular zooming mode is On');
        else
            set(B.tb_RecZoom, 'CData', imread('./icons/24x23/rec_zoom_n.jpg'),...
               'TooltipString','Rectangular zooming mode is Off');
        end
        
        setappdata(B.hFig,'B',B);
    end
    
waitfor(B.hFig);
% B = getappdata(B.hFig,'B');
% Закрываем возможно открытое окошко с настройками программы
checkBopt = isfield(B,'hFigOptions');
if checkBopt
    if ~isempty(B.hFigOptions) & ishandle(B.hFigOptions)
        close(B.hFigOptions);
        B.hFigOptions = [];
    end
end
%  Закрываем возможно открытое окошко с информацией о программе
checkBopt = isfield(B,'hFigAbout');
if checkBopt
    if ~isempty(B.hFigAbout) & ishandle(B.hFigAbout)
        close(B.hFigAbout);
        B.hFigAbout = [];
    end
end

%  Закрываем возможно открытое окошко с информацией о загруженных данных
checkBopt = isfield(B,'infoFig');
if checkBopt
    if ~isempty(B.infoFig) & ishandle(B.infoFig)
        close(B.infoFig);
        B.infoFig = [];
    end
end
txt = sprintf('-->> exit from  %s program', B.verVar);
disp(txt);    
           
end