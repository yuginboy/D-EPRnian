function Out = LimitSizeFig(FigH, Prop, Ext)
% LimitSizeFig - Set minimum and maximum figure size
% Out = LimitSizeFig(FigH, Prop, Ext)
% INPUT:
%   FigH: Handle of a Matlab figure.
%         Optional, default: current figure.
%   Prop: String, command:
%         'min': Set minimum extent.
%         'max': Set maximum extent.
%         'get': Reply a struct with fields MinSize and MaxSize. If not limited,
%                the empty matrix [] is replied.
%         'clear': Clear the min and max limits.
%   Ext:  Extent as [1 x 2] vector, minimal width and height in pixels.
%         The inner position is affected.
%
% OUTPUT:
%   Out:  Output for the 'get' command.
%
% EXAMPLES:
%   FigH = figure;
%   LimitSizeFig(FigH, 'min', [200, 200])
%   LimitSizeFig('max', [400, 400])       % Uses GCF
%   Limit = LimitSizeFig(FigH, 'get')
%
% Tested: Matlab 7.7, 7.8, 7.13, WinXP/32, Win7/64
%         Not compatible to Matlab 6.5.
% Author: Jan Simon, Heidelberg, (C) 2012 matlab.THISYEAR(a)nMINUSsimon.de

% $JRev: R-c V:002 Sum:yOpp5+kQXtGq Date:08-Oct-2012 01:18:52 $
% $License: BSD (use/copy/change/redistribute on own risk, mention the author) $
% $UnitTest: uTest_LimitSizeFig $
% $File: Tools\GLGui\LimitSizeFig.m $
% History:
% 001: 07-Oct-2012 15:02, First version.

% Initialize: ==================================================================
% Global Interface: ------------------------------------------------------------
if ~usejava('jvm')
   % Should this be an error, a warning or a message??
   warning(['JSimon:', mfilename, ':NeedJava'], ...
            '*** %s: Java is required.', mfilename);
   return;
end

% Initial values: --------------------------------------------------------------
% Program Interface: -----------------------------------------------------------
% Parse the inputs:
switch nargin
   case 0
      FigH = gcf;
      Prop = 'min';
      Ext  = [];
   case 1
      if numel(FigH) == 1 && ishandle(FigH)  % LimitSizeFig(FigH)
         Prop = 'min';
         Ext  = [];
      elseif ischar(FigH)                    % LimitSizeFig('string')
         Prop = FigH;
         Ext  = [];
         FigH = GetCurrentFigure;
      else                                   % LimitSizeFig([W, H])
         Prop = 'min';
         Ext  = FigH;
         FigH = GetCurrentFigure;
      end
   case 2
      if ischar(FigH)                        % LimitSizeFig('string', [W, H])
         Ext  = Prop;
         Prop = FigH;
         FigH = GetCurrentFigure;
      elseif numel(FigH) == 1 && ishandle(FigH)
         if ischar(Prop)                     % LimitSizeFig(FigH, 'string')
            Ext  = [];
         else                                % LimitSizeFig(FigH, [W, H])
            Ext  = Prop;
            Prop = 'min';
         end
      else
         error(['JSimon:', mfilename, ':BadHandle'], ...
            '*** %s: 1st input is not a figure handle or string.', mfilename);
      end
   case 3
      % Nothing to do
   otherwise
end

% Check if input is a figure handle:
if numel(FigH) ~= 1 || ~ishandle(FigH) || ...     % Short-circuit
      ~strcmpi(get(FigH, 'Type'), 'figure')
   error(['JSimon:', mfilename, ':BadHandle'], ...
          '*** %s: 1st input is not a figure handle.', mfilename);
end

% Disabling The Warning Message
%If the figure JavaFrame property will continue to be used, you can disable the warning as shown:
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
% User Interface: --------------------------------------------------------------
% Do the work: =================================================================
% Get the Java frame:
jFrame = get(handle(FigH), 'JavaFrame');  % Fails in Matlab < 7.0



if verLessThan('matlab', '8.4')
try    % R2008a and later
   jClient = jFrame.fHG1Client;
catch  % R2007b and earlier
   jClient = jFrame.fFigureClient;
end
else
    jClient = jFrame.fHG2Client;
end
% The com.mathworks.hg.peer.FigureFrameProxy is empty, if no DRAWNOW allowed to
% update the figure since its creation:
jWindow = jClient.getWindow;
if isempty(jWindow)
   drawnow;
   pause(0.02);
   jWindow = jClient.getWindow;
end

% Apply, clear or get the limits:
if strncmpi(Prop, 'min', 3)
   Ext = GetExtent(FigH, Ext);
   jWindow.setMinimumSize(java.awt.Dimension(Ext(1), Ext(2)));
elseif strncmpi(Prop, 'max', 3)
   Ext = GetExtent(FigH, Ext);
   jWindow.setMaximumSize(java.awt.Dimension(Ext(1), Ext(2)));
elseif strcmpi(Prop, 'clear')
   jWindow.setMinimumSize([]);
   jWindow.setMaximumSize([]);
elseif strcmpi(Prop, 'get')
   % Get difference to outer limits:
   bakUnits = get(FigH, 'Units');
   set(FigH, 'Units', 'pixels');
   DiffPos = get(FigH, 'OuterPosition') - get(FigH, 'Position');
   set(FigH, 'Units', bakUnits);

   jDim        = jWindow.getMinimumSize;
   Out.MinSize = [jDim.getWidth, jDim.getHeight] - DiffPos(3:4);
   jDim        = jWindow.getMaximumSize;
   Out.MaxSize = [jDim.getWidth, jDim.getHeight] - DiffPos(3:4);
end

% return;

% ******************************************************************************
function FigH = GetCurrentFigure()
% A DRAWNOW is required when the figure is created to update the Java handle.
% See GCF.

FigH = get(0, 'CurrentFigure');

if isempty(FigH)
   FigH = figure;
   drawnow;
end

% return;

% ******************************************************************************
function Ext = GetExtent(FigH, Ext)
% Get or convert extent to outer position.

bakUnits = get(FigH, 'Units');
set(FigH, 'Units', 'pixels');
OuterPos = get(FigH, 'OuterPosition');
if isempty(Ext)
   Ext = OuterPos(3:4);
elseif isnumeric(Ext) && numel(Ext) == 2 && all(Ext >= 0)
   InnerPos = get(FigH, 'Position');
   Ext      = [Ext(1) + OuterPos(3) - InnerPos(3), ...
               Ext(2) + OuterPos(4) - InnerPos(4)];
else
   error(['JSimon:', mfilename, ':BadSize'], ...
          '*** %s: Extent must be a positive [1 x 2] vector.', mfilename);
end
set(FigH, 'Units', bakUnits);

% return;
