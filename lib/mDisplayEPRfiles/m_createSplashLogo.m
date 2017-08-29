function m_createSplashLogo(verVar)
if ~exist('verVar', 'var') 
    % for testing procedure ------
    verVar = 'GNU D''EPRnian v.05.4.3 (2015.12.17)';
    txt = sprintf('-- The %s program will work in a MAIN WINDOW MODE --', verVar);
    disp(txt);

end
scrsz = get(0,'ScreenSize'); % размеры экрана монитора

wWin = 600; % ширина окна
hWin = 338; % высота окна
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

% This creates the 'background' axes
% fig = figure('Position', [pl pu B.wscr B.hscr],  'Name','',...
%     'NumberTitle','off', 'Color', B.figColorBG);
fig = figure('Position', [pl pu B.wscr B.hscr], 'MenuBar', 'none', 'Name','',...
    'NumberTitle','off', 'Color', B.figColorBG);
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
jframe=get(fig,'javaframe');
jIcon=javax.swing.ImageIcon('./icons/main/default_icon.png');
jframe.setFigureIcon(jIcon);

ha = axes('parent',fig,'units','normalized', 'position',[0 0 1 1]);

% Move the background axes to the bottom

uistack(ha,'bottom');
I=imread('./icons/main/depernian_logo.png');
hi = imagesc(I);
txt = sprintf('GNU D''EPRnian %s\nLicense GNU GPL\nAuthors: Yevgen Syryanyy, Andrey Prokhorov\nScientific knowledge must be open and freely available.', verVar);
annotation('textbox',[0.4 0.15 0.7 0.07], 'String', txt, 'Color', [0.302 0.745 0.933], 'FontSize', 9, 'FontName', 'DejaVu Sans', 'LineStyle', 'none');

pause (4);
% delete Splash Screen figure
close(fig);
fig=[];
pause (1);
end