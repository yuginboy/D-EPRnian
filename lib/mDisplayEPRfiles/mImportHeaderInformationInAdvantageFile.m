function B = mImportHeaderInformationInAdvantageFile(filename)
% Импортируем основные значения экспериментальных данных для файла
% программы Advantage
% [Eo, dE, nE]
fid = fopen(filename);
i = 1;
tline = fgetl(fid);

while i < 29
    switch i
        case 24
            % [Eo, dE, nE]
            %   0=    1377.000000,       0.300000,       44,  ENERGY,   LINEAR,  'E',   'eV',    'Energy'
            tline = regexprep(tline, '\''', '');% заменяем кавычку на пусто

            TmpVar = textscan(tline,'%d= %f %f %f %s %s %s %s %s', 'Delimiter' , ',');
            A.Eo = TmpVar{2}; 
            A.dE = TmpVar{3};
            A.nE = TmpVar{4};
            A.Ename = TmpVar{7};
            A.Eunits = TmpVar{8};
        case 25
            % [Xo, dX, nX]
            %   1=       0.000000,       0.781250,      128,  22,   LINEAR,  'Image X',   'µm',    'Image X'
            tline = regexprep(tline, '\''', '');% заменяем кавычку на пусто

            TmpVar = textscan(tline,'%d= %f %f %f %f %s %s %s %s', 'Delimiter' , ',');
            A.Xo = TmpVar{2}; 
            A.dX = TmpVar{3};
            A.nX = TmpVar{4};
            A.Xname = TmpVar{7};
            A.Xunits = TmpVar{8};
        case 26
            % [Yo, dY, nY]
            % 2=       0.000000,       0.781250,      128,  23,   LINEAR,  'Image Y',   'µm',    'Image Y'
            tline = regexprep(tline, '\''', '');% заменяем кавычку на пусто

            TmpVar = textscan(tline,'%d= %f %f %f %f %s %s %s %s', 'Delimiter' , ',');
            A.Yo = TmpVar{2}; 
            A.dY = TmpVar{3};
            A.nY = TmpVar{4};
            A.Yname = TmpVar{7};
            A.Yunits = TmpVar{8};
        case 27
            % [To, dT, nT]
            %    3=       0.000000,      94.405538,       14,  ETCHTIME,   NON-LINEAR,  'EtchTime',   's',    'Etch Time'
            tline = regexprep(tline, '\''', '');% заменяем кавычку на пусто

            TmpVar = textscan(tline,'%d= %f %f %f %s %s %s %s %s', 'Delimiter' , ',');
            A.To = TmpVar{2}; 
            A.dT = TmpVar{3};
            A.nT = TmpVar{4};
            A.Tname = TmpVar{7};
            A.Tunits = TmpVar{8};
         case 28
            % [To, dT, nT]
            %   4=       0.000000,       1.000000,       14,  ETCHLEVEL,   LINEAR,  'EtchLevel',   '',    'Etch Level'
            tline = regexprep(tline, '\''', '');% заменяем кавычку на пусто

            TmpVar = textscan(tline,'%d= %f %f %f %s %s %s %s %s', 'Delimiter' , ',');
            A.Lo = TmpVar{2}; 
            A.dL = TmpVar{3};
            A.nL = TmpVar{4};
            A.Lname = TmpVar{7};
            A.Lunits = TmpVar{8};
    end
    i = i + 1;
    tline = fgetl(fid);

end
fclose(fid);
B = A;
end