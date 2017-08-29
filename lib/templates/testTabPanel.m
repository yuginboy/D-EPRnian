function testTabPanel
    clear all; close all
    fig = figure('units','pixels','MenuBar','None');
 
    hpanel = addtabpanel(fig,{'Tab 1','Tab 2','Tab 3'},'activetabnum',2,....
        'tabcolor',{get(fig,'color'), [.678 .922 1], [1 .6 .784]});
    
    hpanel11 = addtabpanel(hpanel(1),{'h11 tab 1','h11 tab 2','h11 tab 3','tab 4'},'activetabnum',3,....
        'units','pixels','position',[0 0 400 300],'tabwidth',{.10 .15 .40 .20});
    
    % описание параметров на примере этой панели
    hpanel21 = addtabpanel(... % возвращает массив панелей сколько передано заголовков закладок
        hpanel(2),... % родитель - figure или uipanel
        {'tab 1','tab 2','tab 3','tab 4'},.... % заголовки закладок
        'activetabnum', 3,.... % активная закладка при первом открытии
        'units', 'Normalized',.... % Normalized по умолчанию
        'position', [0 0 .5 .5],.... % позиция
        'borderwidht', 15,.... % ширина рамки вокруг панелей панелей
        'tabheight', 20,.... % высота закладок в пикселях
        'tabwidth', {.20 .15 .40 .20},.... % ширина закладок в процентах (одно значение или cell)
        'tabcolor', {[1 .6 .784], [.678 .922 1], [1 1 .5], 'w'},.... % цвет закладок (одно значение или cell)
        'FontName', 'MS Sans Serif',.... % шрифт закладок (одно значение или cell)
        'FontAngle', 'italic',.... % наклон шрифта закладок (одно значение или cell)
        'FontSize', 7,.... % размер шрифта закладок (одно значение или cell)
        'FontColor', 'k'.... % цвет шрифта закладок (одно значение или cell)
        );
    
    hpanel22 = addtabpanel(hpanel(2),{'tab 1','tab 2','tab 3','tab 4','tab 5'},....
        'position',[.5 0 .5 .5],'tabheight',20,'FontSize',7,'FontAngle','italic');
    
    hpanel23 = addtabpanel(hpanel(2),{'tab 1','tab 2','tab 3','tab 4'},....
        'position',[0 .5 .5 .5],'tabheight',20,'FontSize',7,'FontAngle','italic',....
        'tabcolor', {[1 .6 .784], [.678 .922 1], [1 1 .5], 'w'});
    
    hpanel24 = addtabpanel(hpanel(2),{'tab 1','tab 2','tab 3'},....
        'position',[.5 .5 .5 .5],'tabheight',20,'FontSize',7,'FontAngle','italic');
    
    hpanel31 = addtabpanel(hpanel(3),{'tab 1','tab 2','tab 3'});
    
    hsubpanels = [hpanel11, hpanel21, hpanel22, hpanel23, hpanel24, hpanel31];
    for ii = 1:numel(hsubpanels)
        uitable('parent',hsubpanels(ii),'units','Normalized','position',[0 0 1 1],....
                'ColumnEditable',true,'RowName',[],'data',rand(4,3));
    end
    
    function hpanel = addtabpanel(varargin)
        hpanel = [];
        p = inputParser;
        addOptional(p,'parent',gcf);
        addOptional(p,'tabnames',{});
        addParamValue(p,'activetabnum',1,@(x)validateattributes(x,{'numeric'},{'nonempty'}));
        addParamValue(p,'tabheight',25,@(x)validateattributes(x,{'numeric'},{'nonempty'}));
        addParamValue(p,'tabwidth',{});
        addParamValue(p,'tabcolor',{});
        addParamValue(p,'FontAngle',{});
        addParamValue(p,'FontName',{});
        addParamValue(p,'FontSize',{});
        addParamValue(p,'FontUnits',{});
        addParamValue(p,'FontColor',{});
        addParamValue(p,'units','Normalized',@(x)validateattributes(x,{'char'},{'nonempty'}));
        addParamValue(p,'position',[0 0 1 1],@(x)validateattributes(x,{'numeric'},{'nonempty'}));
        addParamValue(p,'borderwidht',5,@(x)validateattributes(x,{'numeric'},{'nonempty'}));
        parse(p,varargin{:});
        pr = p.Results;
        
        if ~iscell(pr.tabnames) return; end
        numtabs = numel(pr.tabnames);
        if numtabs <= 0 return; end
        
%         ih = ishghandle(pr.parent)
        parenttype = get(pr.parent,'type');
        if strcmp(parenttype,'figure')
            parentColor = get(pr.parent,'Color');
        elseif strcmp(parenttype,'uipanel')
            parentColor = get(pr.parent,'backgroundColor');
        end
        
        function c = any2cell(argin, default)
            c = cell(1, numtabs);
            if iscell(argin)
                numget = min(numtabs, numel(argin));
                for ii = 1:numget c{ii} = argin{ii}; end
                for ii = numget+1:numtabs c{ii} = default; end
            else
                for ii = 1:numtabs c{ii} = argin; end
            end
        end
        tabwidth = any2cell(pr.tabwidth, .15);
        tabcolor = any2cell(pr.tabcolor, parentColor);
        FontAngle = any2cell(pr.FontAngle, 'normal');
        FontName = any2cell(pr.FontName, 'MS Sans Serif');
        FontSize = any2cell(pr.FontSize, 8);
        FontUnits = any2cell(pr.FontUnits, 'points');
        FontColor = any2cell(pr.FontColor, 'k');
        
        hpg = uipanel('Tag','ui_IvanaTabGroup','Parent',pr.parent,'units','pixels',....
                    'position',[0 0 1 pr.tabheight],'bordertype','none','backgroundColor',parentColor);
        hpanel = zeros(1, numtabs);
        htab = zeros(1, numtabs);
        bordpanel = uipanel('Parent',pr.parent,'units','pixels','bordertype','beveledout','borderwidth',2);
        tableftpos = 0;
        for ii = 1:numtabs
            hpanel(ii) = uipanel('Parent',bordpanel,'units','pixels','backgroundColor',tabcolor{ii},....
                'bordertype','none','visible','off');
            hp = uipanel('Parent',hpg,'units','Normalized','position',[tableftpos, 0, tabwidth{ii}, .85],....
                'backgroundColor',get(hpanel(ii),'backgroundColor'),'bordertype','etchedout');
            htab(ii) = uicontrol('style','text','Parent',hp,'units','Normalized','position',[0 0 1 1],....
                'backgroundColor',.85.*get(hp,'backgroundColor'),'string',pr.tabnames{ii},....
                'userdata',hpanel(ii),'enable','inactive','ButtonDownFcn',@tabpanelPushTabFcn,....
                'FontAngle', FontAngle{ii},....
                'FontName', FontName{ii},....
                'FontSize', FontSize{ii},....
                'FontUnits', FontUnits{ii},....
                'ForegroundColor', FontColor{ii});
            tableftpos = tableftpos + tabwidth{ii};
        end
        ud.units = pr.units;
        ud.position = pr.position;
        ud.activetab = htab(pr.activetabnum);
        ud.bordpanel = bordpanel;
        ud.borderwidht = pr.borderwidht;
        ud.panels = hpanel;
        set(hpg,'userdata',ud);%,'resizefcn',@panelResizeFcn)
        
        tabpanelPushTabFcn(htab(pr.activetabnum));
        set(pr.parent,'resizefcn',@tabpanelParentResizeFcn)
    end
 
    function tabpanelPushTabFcn(h,~)
        tc = h;
        pc = get(tc,'parent');
        pg = get(pc,'parent');
        pgud = get(pg,'userdata');
        tp = pgud.activetab;
        pp = get(tp,'parent');
        
        set(tp,'backgroundColor',.85.*get(pp,'backgroundColor'),'position',[0 0 1 1],'fontweight','normal','enable','inactive');
        pos = get(pp,'position');
        set(pp,'position',[pos(1:3), .85],'bordertype','etchedout','borderwidth',1);%,'HighlightColor','w');
        
        set(tc,'backgroundColor',get(pc,'backgroundColor'),'position',[0 -.1 1 1.1],'fontweight','bold','enable','on');
        pos = get(pc,'position');
        set(pc,'position',[pos(1:3), 1],'bordertype','beveledout','borderwidth',2);%,'HighlightColor','r');
        
        set(pgud.bordpanel,'backgroundColor',get(pc,'backgroundColor'));
        set(get(tp,'userdata'),'visible','off');
        set(get(tc,'userdata'),'visible','on');
        pgud.activetab = tc;
        set(pg,'userdata',pgud);
    end
 
    function tabpanelParentResizeFcn(h,~)
        posp = get(h,'position');
        obj = findobj(h,'Tag','ui_IvanaTabGroup');
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
        
        if h == fig
            % тут надо прописать вызов функции resizefcn основного окна,
            % если она нужна
            disp('(^_^)')
        end
    end
end