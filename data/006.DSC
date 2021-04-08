#DESC	1.2 * DESCRIPTOR INFORMATION ***********************
*
*	Dataset Type and Format:
*
DSRC	EXP
BSEQ	BIG
IKKF	REAL
XTYP	IDX
YTYP	IGD
ZTYP	NODATA
*
*	Item Formats:
*
IRFMT	D
YFMT	D
*
*	Data Ranges and Resolutions:
*
XPTS	4096
XMIN	0.000000
XWID	6498.413086
YPTS	1
YMIN	0.000000
YWID	0.000000
*
*	Documentational Text:
*
TITL	'006'
IRNAM	'Intensity'
XNAM	'Field'
YNAM	'Sample Angle'
IRUNI	''
XUNI	'G'
YUNI	'deg'
*
************************************************************
*
#SPL	1.2 * STANDARD PARAMETER LAYER
*
OPER    xuser
DATE    03/29/21
TIME    16:20:04
CMNT    
SAMP    
SFOR    
STAG    C
EXPT    CW
OXS1    IADC
AXS1    B0VL
AXS2    SANX
AXS3    
A1CT    0.325
A1SW    0.65
MWFQ    9.398334e+09
MWPW    0.00015
A2RS    1
A2LL    0.000
A2SW    0.125
AVGS    1
SPTP    0.06
RCAG    60
RCHM    1
B0MA    0.0009
B0MF    100000
RCPH    0.0
RCOF    0.0
A1RS    4096
RCTC    0
*
************************************************************
*
#DSL	1.0 * DEVICE SPECIFIC LAYER
*

.DVC     acqStart, 1.0


.DVC     fieldCtrl, 1.0

AllegroMode        True
CenterField        3250.00 G
Delay              0.0 s
FieldFlyback       On
FieldWait          Wait stable
GFactor            2.000000
MeasuringHall      False
SetToSampleG       False
StaticFieldMon     3480.000 G
SweepDirection     Up
SweepWidth         6500.0 G
WidthTM            200.0 G

.DVC     fieldSweep, 1.0


.DVC     freqCounter, 1.0

FrequencyMon       9.398334 GHz
QMonitBridge       On

.DVC     goniometer, 1.0

Angle              0.000 deg
Increment          0.125 deg
InfoText           Connect to Hardware - Initialize Goniometer - Define Zero Angle
Type               EMB_Goniometer

.DVC     mwBridge, 1.0

AcqFineTuning      Each Slice Scan
AcqScanFTuning     Off
AcqSliceFTuning    Off
BridgeCalib        42.3
Power              0.1500 mW
PowerAtten         30.0 dB

.DVC     ramp2, 1.0

Flyback            False
NbCycles           1
NbPoints           1
StartValue         0.000 deg
SweepData           deg
SweepWidth         0.125 deg
sweepType          Ramp up

.DVC     recorder, 1.0

BaselineCorr       Off
NbScansAcc         1
NbScansDone        1
NbScansToDo        1
ReplaceMode        Off
SmoothMode         Manual
SmoothPoints       10

.DVC     scanEnd, 1.0


.DVC     signalChannel, 1.0

AFCTrap            True
AllegroMode        True
AllowShortCt       False
Calibrated         True
ConvFact           6.354e-09
ConvTime           60.00 ms
DModDetectSCT      First
DoubleModAcc       1
DoubleModFreq      5.000 kHz
DoubleMode         False
DualDetect         OFF
EliDelay           1.0 us
Enable1stHarm      True
Enable1stHarm90    False
Enable2ndHarm      False
Enable2ndHarm90    False
Enable3rdHarm      False
Enable3rdHarm90    False
Enable4thHarm      False
Enable4thHarm90    False
Enable5thHarm      False
Enable5thHarm90    False
EnableDisp         False
EnableImag         Disable
ExtLockIn          False
ExtTrigger         False
Gain               60 dB
GainB              60 dB
Harmonic           1
HighPass           True
InputPlugA         AC3
InputPlugB         AC3
Integrator         False
IsCalibExp         False
ModAmp             9.000 G
ModFreq            100.00 kHz
ModPhase           0.0
Offset             0.0 %
PolyCof            {2;3,9;0} 0,1.00521,0,0,0.0163798,0,0,-0.0416191,0,0,-0.00049228,0,0,0.000644256,0,0,4.93766e-06,0,0,-4.34087e-06,0,0,-1.60616e-08,0,0,1.06869e-08,0
QuadMode           False
ResCenter          61 mm
ResLength          23 mm
Resolution         4096
Resonator          1
SctNorm            False
SctRevision        Allegro
SetAllOrd          False
SetOrdDef          False
SpuExtension       True
SpuRevision        MultiHarmonic
SweepTime          245.76000 s
TimeConst          0
TimeExp            False
TuneCaps           50
dModSW             True

*
************************************************************
