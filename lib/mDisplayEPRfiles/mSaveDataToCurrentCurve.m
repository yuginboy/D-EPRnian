function A = mSaveDataToCurrentCurve (B, i)
% Заполняем поля для выбранной кривой чтобы впоследствии иметь возможность
% отличать одну кривую от другой
% B - структура
% i - индекс данной кривой
B.Curve(i).FullFileName = B.currentCurveFullFileName;
B.Curve(i).DirName = B.currentCurveDirName; % Полный путь до каталога
B.Curve(i).FileName = B.currentCurveFileName; % Только имя файла
B.Curve(i).AngleValue = B.currentCurveAngleValue;
if strcmp(B.currentCurveAngleValue,'--')
    B.Curve(i).AngleValueNumber = 0;
else
    B.Curve(i).AngleValueNumber = str2double(B.currentCurveAngleValue);
end
B.Curve(i).FreqValue = B.freq;
B.Curve(i).DataX = B.x;
B.Curve(i).DataY = B.y;
B.Curve(i).CurveInfo = B.info;
B.Curve(i).TagName = num2str(i);
A = B;
end