function uTest_LimitSizeFig(doSpeed)  %#ok<INUSD>
% Automatic test: LimitSizeFig
% This is a routine for automatic testing. It is not needed for processing and
% can be deleted or moved to a folder, where it does not bother.
%
% uTest_LimitSizeFig(doSpeed)
% INPUT:
%   doSpeed: Ignored (this is needed for other unit tests only).
% OUTPUT:
%   On failure the test stops with an error.
%
% Tested: Matlab 6.5, 7.7, 7.8, 7.13, WinXP/32, Win7/64
% Author: Jan Simon, Heidelberg, (C) 2012 matlab.THISYEAR(a)nMINUSsimon.de

% $JRev: R-a V:001 Sum:ssbUX/ZbMTeH Date:08-Oct-2012 01:18:52 $
% $License: BSD (use/copy/change/redistribute on own risk, mention the author) $
% $File: Tools\UnitTests_\uTest_LimitSizeFig.m $
% History:
% 001: 08-Oct-2012 01:16, First version.

% Initialize: ==================================================================
FuncName = mfilename;
ErrID    = ['JSimon:', FuncName, ':Crash'];

% Do the work: =================================================================
% Hello:
fprintf('==== Test LimitSizeFig:  %s\n\n', datestr(now, 0));

if sscanf(version, '%d', 1) < 7
   fprintf('### LimitSizeFig needs Matlab >= 7.0\n');
   return;
end

% Defaults and create a figure implicitly:
LimitSizeFig;

FigH = gcf;
LimitSizeFig(FigH);
LimitSizeFig('min');       % Set to current size
LimitSizeFig([300, 200]);  % Set the minimum

LimitSizeFig('min', [300, 200]);
LimitSizeFig(FigH,  [300, 200]);
LimitSizeFig(FigH,  'min');

LimitSizeFig(FigH, 'min', [300, 200]);
LimitSizeFig(FigH, 'max', [400, 300]);

Limits = LimitSizeFig(FigH, 'get');
if ~isequal(Limits.MinSize, [300, 200]) || ~isequal(Limits.MaxSize, [400, 300])
   error(ErrID, 'Limits differ from set values.');
end

LimitSizeFig(FigH, 'clear');

delete(FigH);

% Goodbye:
fprintf('LimitSizeFig passed the tests.\n');

% return;
