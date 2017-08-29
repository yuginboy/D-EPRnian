function chk = mCompareDataWithCurrentCurve (B, i)
% Сравниваем уникальные поля текущей кривой с кривой из массива под индексом i
chk = 0;
if strcmp(B.Curve(i).DirName, B.currentCurveDirName) && strcmp ( B.Curve(i).FileName, B.currentCurveFileName)...
        && strcmp (B.Curve(i).AngleValue, B.currentCurveAngleValue) && B.Curve(i).FreqValue == B.freq
    chk = 1;
end
        
end