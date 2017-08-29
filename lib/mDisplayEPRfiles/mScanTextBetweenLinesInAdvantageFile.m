function B = mScanTextBetweenLinesInAdvantageFile (filename, A)
% Функция импорта основных данных между строками, номера которых были
% определены заранее с помощью функции [y,k] = litcount(fid, literal)
% Также заранее были определены размеры соответствующих массивов
% переменных, использованных для записи данных с XPS спектрометра
i = 1;
k = 1;
e = 1; % Индекс вектора энергии
fid = fopen(filename);

tline = fgetl(fid);
len = length (A.arrNumLines);

E = zeros(A.nE, 1);
Data = zeros(A.nX,A.nY,A.nT,A.nE);
% Number of lines between 2 data bloks:
dNumLinesBetweenBlocks = A.arrNumLines(k + 1) - A.arrNumLines(k);
h = waitbar(0,'Please wait when the file will be imported...');
valBefore = k;

while ischar(tline)
    if k <= len
        if i >= A.arrNumLines(k) && i < A.arrNumLines(k) + dNumLinesBetweenBlocks
            % Цикл на импорт данных спектра энергии
            if i > A.arrNumLines(k) + 4
                % LIST@  16=        1.000000,        0.000000,        0.000000,        0.000000
                % LIST@  20=        1.000000,        1.000000,        0.000000
                    matches = strfind(tline, 'LIST@');
                    num = length(matches);
                   if num > 0
                        TmpVar = mConvertCellToDouble(regexp(tline,'-?\d+\.?\d*|-?\d*\.?\d+','match'));
                        
                        E( e : e+length(TmpVar)-2 ) = TmpVar(2:end);
                        e = e + length(TmpVar)-1;
                   end
            end

            switch i
                case A.arrNumLines(k) + 1
                    % [Eo, dE, nE]
                    % $AXISVALUE= DATAXIS=1 SPACEAXIS=1 LABEL='Image X' POINT=1 VALUE=0.781250;
                     tline = regexprep(tline, '\''', '');% заменяем кавычку на пусто
                    TmpVar = mConvertCellToDouble(regexp(tline,'-?\d+\.?\d*|-?\d*\.?\d+','match'));
                    %X = TmpVar(end);
                    Xn = TmpVar(end - 1);

                case A.arrNumLines(k) + 2
                    % $AXISVALUE= DATAXIS=2 SPACEAXIS=2 LABEL='Image Y' POINT=53 VALUE=41.406250;
                     tline = regexprep(tline, '\''', '');% заменяем кавычку на пусто
                    TmpVar = mConvertCellToDouble(regexp(tline,'-?\d+\.?\d*|-?\d*\.?\d+','match'));
                    %Y = TmpVar(end);
                    Yn = TmpVar(end - 1);

                case A.arrNumLines(k) + 3
                    % $AXISVALUE= DATAXIS=3 SPACEAXIS=3 LABEL='Etch Time' POINT=11 VALUE=1077.217000;
                     tline = regexprep(tline, '\''', '');% заменяем кавычку на пусто
                    TmpVar = mConvertCellToDouble(regexp(tline,'-?\d+\.?\d*|-?\d*\.?\d+','match'));
                    %T = TmpVar(end);
                    Tn = TmpVar(end - 1);

                case A.arrNumLines(k) + dNumLinesBetweenBlocks - 1
                    k = k + 1;
                    Data(Xn+1,Yn+1,Tn+1,:) = E(:);
                    % plot(squeeze(Data(91,1,1,:)))
                    E(:) = 0;
                    e = 1;
            end
        
            
        end
        
    end
    i = i + 1;
%     valBefore = mProgressBarString(k, len, valBefore, h);
    if (k - valBefore) > 0.01*len
        valBefore = k;
        txt = sprintf('Achieved %3.0d %%', round(k/len*100));
        waitbar( k / len, h, txt);
    end
    
    tline = fgetl(fid);
end
close(h);
fclose(fid);
A.data = Data;
B = A;
end