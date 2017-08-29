function test
% Thilina S. Ambagahawaththa
% 2012/05/30
clc;
clear all;
close all;
%% Frame
frame = javax.swing.JFrame;
frame.setSize(1200,800);
frame.setTitle( 'Movie Maker');
frame.setLayout(java.awt.GridBagLayout);
frame.setVisible(true);
%% Video Player Panel
playerPanel = javax.swing.JPanel;
  playerPanel.setBorder( ...
    javax.swing.BorderFactory.createTitledBorder( ...
    javax.swing.BorderFactory.createEtchedBorder(), 'Video' ...
  ) ...
);
 
playerPanel.setLayout(java.awt.GridBagLayout);
playerPanel.setMinimumSize(java.awt.Dimension(800,600));
playerPanel.setMaximumSize(java.awt.Dimension(800,600));
playerPanel.setPreferredSize(java.awt.Dimension(800,600));
 
viewPan = javax.swing.JScrollPane;
viewPan.setMinimumSize(java.awt.Dimension(800,600));
viewPan.setMaximumSize(java.awt.Dimension(800,600));
viewPan.setPreferredSize(java.awt.Dimension(800,600));
 
%% Player Button Panel
playerButtonPanel = javax.swing.JPanel;
  playerButtonPanel.setBorder( ...
    javax.swing.BorderFactory.createTitledBorder( ...
    javax.swing.BorderFactory.createEtchedBorder(), 'Control' ...
  ) ...
);
playerPanel.setLayout(java.awt.GridBagLayout);
 
%% Player Window
playerWindowLabel = javax.swing.JLabel;
 
%% Buttons
stateButton = javax.swing.JButton;
stateButton.setMinimumSize(java.awt.Dimension(60,25));
stateButton.setMaximumSize(java.awt.Dimension(60,25));
stateButton.setPreferredSize(java.awt.Dimension(60,25));
 
captureButton = javax.swing.JButton;
captureButton.setMinimumSize(java.awt.Dimension(120,25));
captureButton.setMaximumSize(java.awt.Dimension(120,25));
captureButton.setPreferredSize(java.awt.Dimension(120,25));
captureButton.setText( 'SaveFrame');
captureButton.setToolTipText( 'SF');
set(captureButton, 'ActionPerformedCallback',@playControlListener);
 
playButton = javax.swing.JButton(javax.swing.ImageIcon('D:\Projects\Self\MovieMaker\project\icons\1_play.jpg' ));
playButton.setMinimumSize(java.awt.Dimension(25,25));
playButton.setMaximumSize(java.awt.Dimension(25,25));
playButton.setPreferredSize(java.awt.Dimension(25,25));
playButton.setToolTipText( 'Play');
set(playButton, 'ActionPerformedCallback',@playControlListener);
 
pauseButton = javax.swing.JButton(javax.swing.ImageIcon('D:\Projects\Self\MovieMaker\project\icons\1_pause.jpg' ));
pauseButton.setMinimumSize(java.awt.Dimension(25,25));
pauseButton.setMaximumSize(java.awt.Dimension(25,25));
pauseButton.setPreferredSize(java.awt.Dimension(25,25));
pauseButton.setToolTipText( 'Pause');
set(pauseButton, 'ActionPerformedCallback',@playControlListener);
 
stopButton = javax.swing.JButton(javax.swing.ImageIcon('D:\Projects\Self\MovieMaker\project\icons\1_stop.jpg' ));
stopButton.setMinimumSize(java.awt.Dimension(25,25));
stopButton.setMaximumSize(java.awt.Dimension(25,25));
stopButton.setPreferredSize(java.awt.Dimension(25,25));
stopButton.setToolTipText( 'Stop');
set(stopButton, 'ActionPerformedCallback',@playControlListener);
 
revButton = javax.swing.JButton(javax.swing.ImageIcon('D:\Projects\Self\MovieMaker\project\icons\1_rev.jpg' ));
revButton.setMinimumSize(java.awt.Dimension(25,25));
revButton.setMaximumSize(java.awt.Dimension(25,25));
revButton.setPreferredSize(java.awt.Dimension(25,25));
revButton.setToolTipText( 'Rev');
set(revButton, 'ActionPerformedCallback',@playControlListener);
 
fwdButton = javax.swing.JButton(javax.swing.ImageIcon('D:\Projects\Self\MovieMaker\project\icons\1_fwd.jpg' ));
fwdButton.setMinimumSize(java.awt.Dimension(25,25));
fwdButton.setMaximumSize(java.awt.Dimension(25,25));
fwdButton.setPreferredSize(java.awt.Dimension(25,25));
fwdButton.setToolTipText( 'Fwd');
set(fwdButton, 'ActionPerformedCallback',@playControlListener);
 
sbkButton = javax.swing.JButton(javax.swing.ImageIcon('D:\Projects\Self\MovieMaker\project\icons\1_skipBck.jpg' ));
sbkButton.setMinimumSize(java.awt.Dimension(25,25));
sbkButton.setMaximumSize(java.awt.Dimension(25,25));
sbkButton.setPreferredSize(java.awt.Dimension(25,25));
sbkButton.setToolTipText( 'SBK');
set(sbkButton, 'ActionPerformedCallback',@playControlListener);
 
sfdButton = javax.swing.JButton(javax.swing.ImageIcon('D:\Projects\Self\MovieMaker\project\icons\1_skipFwd.jpg' ));
sfdButton.setMinimumSize(java.awt.Dimension(25,25));
sfdButton.setMaximumSize(java.awt.Dimension(25,25));
sfdButton.setPreferredSize(java.awt.Dimension(25,25));
sfdButton.setToolTipText( 'SFD');
set(sfdButton, 'ActionPerformedCallback',@playControlListener);
 
ejtButton = javax.swing.JButton(javax.swing.ImageIcon('D:\Projects\Self\MovieMaker\project\icons\1_ejt.jpg' ));
ejtButton.setMinimumSize(java.awt.Dimension(25,25));
ejtButton.setMaximumSize(java.awt.Dimension(25,25));
ejtButton.setPreferredSize(java.awt.Dimension(25,25));
ejtButton.setToolTipText( 'EJT');
set(ejtButton, 'ActionPerformedCallback',@playControlListener);
 
scrButton = javax.swing.JButton(javax.swing.ImageIcon('D:\Projects\Self\MovieMaker\project\icons\1_scr.jpg' ));
scrButton.setMinimumSize(java.awt.Dimension(25,25));
scrButton.setMaximumSize(java.awt.Dimension(25,25));
scrButton.setPreferredSize(java.awt.Dimension(25,25));
scrButton.setToolTipText( 'Start Crop');
set(scrButton, 'ActionPerformedCallback',@playControlListener);
 
ecrButton = javax.swing.JButton(javax.swing.ImageIcon('D:\Projects\Self\MovieMaker\project\icons\1_ecr.jpg' ));
ecrButton.setMinimumSize(java.awt.Dimension(25,25));
ecrButton.setMaximumSize(java.awt.Dimension(25,25));
ecrButton.setPreferredSize(java.awt.Dimension(25,25));
ecrButton.setToolTipText( 'End Crop');
set(ecrButton, 'ActionPerformedCallback',@playControlListener);
 
sveButton = javax.swing.JButton(javax.swing.ImageIcon('D:\Projects\Self\MovieMaker\project\icons\1_sve.jpg' ));
sveButton.setMinimumSize(java.awt.Dimension(25,25));
sveButton.setMaximumSize(java.awt.Dimension(25,25));
sveButton.setPreferredSize(java.awt.Dimension(25,25));
sveButton.setToolTipText( 'Save');
set(sveButton, 'ActionPerformedCallback',@playControlListener);
 
%% Sliders
playPointSlider = javax.swing.JSlider;
playPointSlider.setMinimum(1);
playPointSlider.setMaximum(10);
playPointSlider.setValue(1);
set(playPointSlider, 'MouseReleasedCallback',@playControlListener);
 
%% player Panel setup
viewPan.getViewport().add(playerWindowLabel);
playerPanel.add( ...
  viewPan, ...
  java.awt.GridBagConstraints( ...
  0, 0, 1, 1, 1.0, 1.0, java.awt.GridBagConstraints.NORTHWEST, java.awt.GridBagConstraints.BOTH,...
  java.awt.Insets(6, 12, 6, 6), 1, 1));
 
%% Button Panel Setup
% SB Rv Ps Pl St FF SF EJ
playerButtonPanel.add( ...
  stateButton, ...
  java.awt.GridBagConstraints( ...
  0, 0, 1, 1, 1.0, 1.0, java.awt.GridBagConstraints.NORTHWEST, java.awt.GridBagConstraints.NONE,...
  java.awt.Insets(6, 12, 6, 6), 1, 1));
playerButtonPanel.add( ...
  captureButton, ...
  java.awt.GridBagConstraints( ...
  0, 0, 1, 1, 1.0, 1.0, java.awt.GridBagConstraints.NORTHWEST, java.awt.GridBagConstraints.NONE,...
  java.awt.Insets(6, 12, 6, 6), 1, 1));
playerButtonPanel.add( ...
  sbkButton, ...
  java.awt.GridBagConstraints( ...
  1, 0, 1, 1, 1.0, 1.0, java.awt.GridBagConstraints.NORTHWEST, java.awt.GridBagConstraints.NONE,...
  java.awt.Insets(6, 12, 6, 6), 1, 1));
playerButtonPanel.add( ...
  revButton, ...
  java.awt.GridBagConstraints( ...
  2, 0, 1, 1, 1.0, 1.0, java.awt.GridBagConstraints.NORTHWEST, java.awt.GridBagConstraints.NONE,...
  java.awt.Insets(6, 12, 6, 6), 1, 1));
playerButtonPanel.add( ...
  pauseButton, ...
  java.awt.GridBagConstraints( ...
  3, 0, 1, 1, 1.0, 1.0, java.awt.GridBagConstraints.NORTHWEST, java.awt.GridBagConstraints.NONE,...
  java.awt.Insets(6, 12, 6, 6), 1, 1));
playerButtonPanel.add( ...
  playButton, ...
  java.awt.GridBagConstraints( ...
  4, 0, 1, 1, 1.0, 1.0, java.awt.GridBagConstraints.NORTHWEST, java.awt.GridBagConstraints.NONE,...
  java.awt.Insets(6, 12, 6, 6), 1, 1));
playerButtonPanel.add( ...
  stopButton, ...
  java.awt.GridBagConstraints( ...
  5, 0, 1, 1, 1.0, 1.0, java.awt.GridBagConstraints.NORTHWEST, java.awt.GridBagConstraints.NONE,...
  java.awt.Insets(6, 12, 6, 6), 1, 1));
playerButtonPanel.add( ...
  fwdButton, ...
  java.awt.GridBagConstraints( ...
  6, 0, 1, 1, 1.0, 1.0, java.awt.GridBagConstraints.NORTHWEST, java.awt.GridBagConstraints.NONE,...
  java.awt.Insets(6, 12, 6, 6), 1, 1));
playerButtonPanel.add( ...
  sfdButton, ...
  java.awt.GridBagConstraints( ...
  7, 0, 1, 1, 1.0, 1.0, java.awt.GridBagConstraints.NORTHWEST, java.awt.GridBagConstraints.NONE,...
  java.awt.Insets(6, 12, 6, 6), 1, 1));
playerButtonPanel.add( ...
  ejtButton, ...
  java.awt.GridBagConstraints( ...
  8, 0, 1, 1, 1.0, 1.0, java.awt.GridBagConstraints.NORTHWEST, java.awt.GridBagConstraints.NONE,...
  java.awt.Insets(6, 12, 6, 6), 1, 1));
playerButtonPanel.add( ...
  scrButton, ...
  java.awt.GridBagConstraints( ...
  8, 0, 1, 1, 1.0, 1.0, java.awt.GridBagConstraints.NORTHWEST, java.awt.GridBagConstraints.NONE,...
  java.awt.Insets(6, 12, 6, 6), 1, 1));
playerButtonPanel.add( ...
  ecrButton, ...
  java.awt.GridBagConstraints( ...
  8, 0, 1, 1, 1.0, 1.0, java.awt.GridBagConstraints.NORTHWEST, java.awt.GridBagConstraints.NONE,...
  java.awt.Insets(6, 12, 6, 6), 1, 1));
playerButtonPanel.add( ...
  sveButton, ...
  java.awt.GridBagConstraints( ...
  8, 0, 1, 1, 1.0, 1.0, java.awt.GridBagConstraints.NORTHWEST, java.awt.GridBagConstraints.NONE,...
  java.awt.Insets(6, 12, 6, 6), 1, 1));
 
frame.add( ...
  playerPanel, ...
  java.awt.GridBagConstraints( ...
  0, 0, 1, 1, 1.0, 1.0, java.awt.GridBagConstraints.NORTHWEST, java.awt.GridBagConstraints.BOTH,...
  java.awt.Insets(6, 12, 6, 6), 1, 1));
frame.add( ...
  playPointSlider, ...
  java.awt.GridBagConstraints( ...
  0, 1, 1, 1, 1.0, 1.0, java.awt.GridBagConstraints.NORTHWEST, java.awt.GridBagConstraints.BOTH,...
  java.awt.Insets(6, 12, 6, 6), 1, 1));
frame.add( ...
  playerButtonPanel, ...
  java.awt.GridBagConstraints( ...
  0, 2, 1, 1, 1.0, 1.0, java.awt.GridBagConstraints.NORTHWEST, java.awt.GridBagConstraints.BOTH,...
  java.awt.Insets(6, 12, 6, 6), 1, 1));
  
  hax = axes('parent', viewPan);
  plot(hax,[1:10],[1:10].^2)
% % scrsz = get(0,'ScreenSize'); % размеры экрана монитора
% % wWin = 1100; % ширина окна
% % hWin = 620; % высота окна
% % B.wscr = wWin;
% % B.hscr = hWin;
% % 
% % 
% % waxe = wWin-300; % ширина осей
% % haxe = hWin-100; % высота осей
% % 
% % pl = 0.5*(scrsz(3) - wWin);
% % pu = 0.5*(scrsz(4) - hWin);
% % B.figColorBG = get(0,'DefaultUicontrolBackgroundColor');
% % B.pl = pl;
% % B.pu = pu;
% % 
% % % hFig = figure('Position', [pl pu wscr hscr], 'CloseRequestFcn',@CloseAndGo, 'Name',nameFigTxt);
% % % B.hFig = figure('Position', [pl pu B.wscr B.hscr],'Resize', 'off', 'MenuBar', 'none', 'Name','display EPR data');
% % B.hFig = figure('Position', [pl pu B.wscr B.hscr], 'MenuBar', 'none', 'Name','Display EPR data', 'Color', B.figColorBG);
% % % B.hFig = figure('Position', [pl pu B.wscr B.hscr],  'Name','display EPR data');
% % 
% % 
% % % set(B.hFig,'renderer','painters');
% % set(B.hFig,'renderer','OpenGL');
% % 
% % B.hTabGroup = uitabgroup; drawnow;
% % B.tab_main = uitab(B.hTabGroup, 'title','main');
% % % a = axes(); surf(peaks);
% % B.tab_3D = uitab(B.hTabGroup, 'title','3-D');
% % % uicontrol(tab2, 'String','Close', 'Callback','close(gcbf)');
% % 
% % B.axShiftX = 40;
% % B.axShiftY = 40;
% % B.hAxes = axes ('parent', B.tab_main,'Units', 'pixels','Position',[B.axShiftX B.axShiftY waxe haxe]);% В процентах
% % axis manual
% % B.cmenu = uicontextmenu;
% % % Create the parent menu
% % B.uimenuCm1 = uimenu(B.cmenu, 'label','paint bg');
% % % Create the submenu
% % B.hcm_item1 = uimenu(B.uimenuCm1, 'Label', 'paint', 'Callback', @f_hcb1);
% % B.hcm_item2 = uimenu(B.uimenuCm1, 'Label', 'return', 'Callback', @f_hcb2);
% % 
% % % Create the parent menu
% % B.uimenuCm2 = uimenu(B.cmenu, 'label','paint bg');
% % % Create the submenu
% % B.hcm_item3 = uimenu(B.uimenuCm2, 'Label', 'paint2', 'Callback', @f_hcb1);
% % B.hcm_item4 = uimenu(B.uimenuCm2, 'Label', 'return2', 'Callback', @f_hcb2);
% % 
% % set(B.hAxes,'uicontextmenu',B.cmenu);
% % 
% % set(B.hFig ,'WindowButtonMotionFcn', {@mouseMotionFcn},...
% % 'WindowButtonDownFcn', {@mouseButtonDownFcn},...
% % 'WindowButtonUpFcn', {@mouseButtonUpFcn},...
% %     'renderer', 'OpenGL',...
% % 'KeyPressFcn',@KeyPressFcn_callback,...
% % 'WindowScrollWheelFcn',@figScroll,...
% % 'ResizeFcn', @figResizeFcn);
% % 
% % setappdata(B.hFig,'B',B);
% %     % -----------Context Menu Function
% %     function f_hcb1(src,eventdata)
% %         B = getappdata(B.hFig,'B');
% %         set(B.hAxes, 'Color', [0.87,0.5,0.87]);        
% %         setappdata(B.hFig,'B',B);
% %         
% %     end
% %     function f_hcb2(src,eventdata)
% %         B = getappdata(B.hFig,'B');
% %         set(B.hAxes, 'Color', [0.87,0.87,0.87]);        
% %         setappdata(B.hFig,'B',B);
% %         
% %     end
% %     %--+--+--+--+--+--+--+--+--+--+--+
% %     function mouseMotionFcn(src,eventdata)
% %         B = getappdata(B.hFig,'B');
% %         
% %         setappdata(B.hFig,'B',B);
% % %         mDisplayEPRfiles_moveMouseFcn_v_01(B);
% %         B = getappdata(B.hFig,'B');
% %         
% %         setappdata(B.hFig,'B',B);
% %         
% %     end
% %     function mouseButtonDownFcn(src,eventdata)
% %         B = getappdata(B.hFig,'B');
% %         B.leftMouseFirstClick = 1;
% % %         B.startRecPosition = [B.new_x,B.new_y];
% % %         disp(B.startRecPosition);
% %         B.leftMouseFirstClick = 0;
% % %         setappdata(B.hFig,'B',B);
% % %         mDisplayEPRfiles_mousePushDownFcn_v_01(B);
% % %         B = getappdata(B.hFig,'B');
% %         setappdata(B.hFig,'B',B);
% %     end % mouseButtonDownFcn
% % Prevent an annoying warning msg
% warning off MATLAB:uitabgroup:OldVersion
%  
% % Prepare a tab-group consisting of two tabs
% hTabGroup = uitabgroup; drawnow;
% tab1 = uitab(hTabGroup, 'title','Panel 1');
% a = axes('parent', tab1); surf(peaks);
% tab2 = uitab(hTabGroup, 'title','Panel 2');
% uicontrol(tab2, 'String','Close', 'Callback','close(gcbf)');
%  
% % Get the underlying Java reference (use hidden property)
% jTabGroup = getappdata(handle(hTabGroup),'JTabbedPane');
% % jTabGroupObj = findjobj('class', 'tabgroup');
% % jTabGroup.JPanel(1,java.awt.Color(1.0,0,1.0));
% % Equivalent manners to set a red tab foreground:
% % jTabGroup.setForegroundAt(1,java.awt.Color(1.0,0,0)); % tab #1
% jTabGroup.setTitleAt(1,'<html><font color="red"><i>Panel 2');
% jTabGroup.setForeground(java.awt.Color.red);
% 
% % Equivalent manners to set a yellow tab background:
% jTabGroup.setTitleAt(0,'<html><div style="background:#ffff00;">Panel 1');
% jTabGroup.setTitleAt(0,'<html><div style="background:yellow;">Panel 1');
% 
% [jPanel,hPanel] = javacomponent(javax.swing.JPanel);
% set(hPanel, 'units','normalized','position',[0.2,0.2,1,1]);
% hControl = uicontrol('style','pushbutton', 'parent',hPanel,'string','click me', 'position',[0.1,0.1,0.1,0.1]);
% hAx = axes('parent',hPanel)
% plot([2,2],[3,4]);

end
