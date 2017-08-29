function mDisplayEPRfiles_saveData_v_01 (B) 
% Сохраняем картинку и экспортируем данные в таблицу ASCII
    B = getappdata(B.hFig,'B');
    B.indexDir = get(B.lb_dir, 'Value');
    B.indexFiles = get(B.lb_files, 'Value');
    B.indexStruct = get(B.lb_struct, 'Value');
    
    % Проверяем, если кривая из серии "две точки", которая рисуется в случае
% захода в папку, в которой нет рабочих файлов с EPR спектрами, то выходим
% без выполнениякаких либо действий
if strcmp(B.currentCurveFullFileName, 'filename')
    return
end
    
%     B.p = get(B.hFig, 'CurrentPoint');
%     B.new_x = (B.p(1)-B.axShiftX + B.wgrReal(1)*B.scw)/B.scw;
%     B.new_y = (B.p(2)-B.axShiftY + B.hgrReal(1)*B.sch)/B.sch;
%     set(B.mcpLineY, 'XData',[B.new_x,B.new_x], 'YData', B.hgrReal);
%     set(B.mcpLineX, 'XData',B.wgrReal, 'YData',[B.new_y,B.new_y]);
%     set(B.Y0, 'XData',B.wgrReal);
%     str_txt = sprintf('%0.5g, %0.5g',B.new_x, B.new_y);
%     set(B.txtXY, 'String', str_txt );
%     set(B.txtXY,'Position',[B.wgrReal(1)+0.01*(B.wgrReal(2) - B.wgrReal(1)), ...
%     B.hgrReal(1)+ 0.01*(B.hgrReal(2) - B.hgrReal(1))]);
%     
%     set(B.dataXY, 'XData',B.x, 'YData', B.y);
%     set(B.hAxes, 'XLim', B.wgrReal, 'YLim', B.hgrReal);
%     setappdata(B.hFig,'B',B);
    
    B = getappdata(B.hFig,'B');
        wscrK = B.wscr; % ширина окна
        hscrK = B.hscr; % высота окна
        pl = B.pl+B.wscr+10; % левый край фигуры
        pu = B.pu+B.hscr-hscrK; % верхний край фигуры
        B.khFig = figure('Position', [B.pl B.pu wscrK hscrK],'Resize', 'off', 'MenuBar', 'none', 'Name','data for save');
        B.khAxes = axes('Position',[0.05 0.06 0.89 0.9], 'Box', 'on', 'LineWidth', 1.5, 'XGrid', 'on', 'YGrid', 'on');
        hold on;
            hData = plot(B.x,B.y,'-k', 'LineWidth', 1); % Экспериментальные данные
            
            hYo = plot(get(B.khAxes, 'XLim'),[0,0],'-r', 'LineWidth', 1.5); % Экспериментальные данные
            uistack(hData, 'top');
            hold off;
        xlabel({'B, Oe'}, 'fontsize',14,'fontweight','b');
        ylabel({'Intensity (a.u.) '}, 'fontsize',14,'fontweight','b');
        [m,n] = size(B.alpha);
        if m>1
            alpha = B.alpha(B.indexStruct,:);
            txt = ['EPR data for ', B.fileNameList{B.indexFiles},', angle = ', alpha ,' deg' ];
        else
            alpha = B.alpha;
            txt = ['EPR data for ', B.fileNameList{B.indexFiles}];
        end
        figure(B.khFig);
        title(txt, 'fontsize',14,'fontweight','b', 'interpreter', 'none' );
        
        % Записываем график на диск в виде картинки .png

            disp ('-- save the fit-graphs to *PNG file --');
                dir_png = [B.defPath '/' 'outData' ];

                if exist (dir_png ,'dir') ==0
                    mkdir(dir_png);
                end;
                
            set(0,'CurrentFigure', B.khFig);
            set(gcf,'PaperPositionMode','auto');
            checkFile = 1;
            i = 1;
            addTxt = B.fileNameList{B.indexFiles};
            addTxt = regexprep(addTxt, '.DSC', '');
            while checkFile > 0
                myFile = [dir_png  '/' addTxt, '_', alpha, '_',num2str(i, '%4.4d'),  '.dat'];
                myPict = [dir_png  '/' addTxt, '_', alpha, '_',num2str(i, '%4.4d'),  '.png'];
                if exist (myPict ,'file') ==0
                    checkFile = 0;
                end;
                i = i + 1;
            end
            disp(['save graph to the file ' myPict]);
            
            if verLessThan('matlab', '8.4') % R2014b
            try    % R2008a and later
               printTxt = ['print(' '''' '-f', num2str(gcf), '''' ', ' '''' '-dpng' '''' ', ' ...
                '''' '-r100' '''' ', ' 'myPict' ');' ]; 
            catch % R2007b and earlier
               printTxt = ['print(' '''' '-f', num2str(gcf), '''' ', ' '''' '-dpng' '''' ', ' ...
                '''' '-r100' '''' ', ' 'myPict' ');' ];
            end
            else
                printTxt = ['print(' '''' '-f', num2str(get(gcf, 'Number')), '''' ', ' '''' '-dpng' '''' ', ' ...
                '''' '-r100' '''' ', ' 'myPict' ');' ];
            end
            
            
            eval(printTxt);

        delete(B.khFig);
        
        % Делаем активным главную фигуру
        figure(B.hFig);
        axes(B.hAxes);
        B.savePng = 0; % Не записываем в png файл
        disp(['Save Data in text file ', myFile]);
        outData = B.x;
        outData (:,2) = B.y;
        outData (:,3) = B.src_y;
            
%                                 myFile=[A.dirName  '/' num2str(i,'%04d') '_' A.myTime '.dat'];
                               outDataFile=fopen(myFile, 'wt');
                               firstLineTxt = sprintf('The data has been exported by using %s program.', B.verVar);
                               fprintf(outDataFile, '%s\n', firstLineTxt);
                               firstLineTxt = ['Thank you for using our free software.'];
                               fprintf(outDataFile, '%s\n', firstLineTxt);
                               firstLineTxt = ['=============================================================='];
                               fprintf(outDataFile, '%s\n', firstLineTxt);
                               firstLineTxt = ['EPR data for the file: ', B.fileFullList{B.indexFiles} ];
                               fprintf(outDataFile, '%s\n', firstLineTxt);
                               firstLineTxt = ['=============================================================='];
                               fprintf(outDataFile, '%s\n', firstLineTxt);
                               firstLineTxt = ['alpha = ', alpha, ' deg'];
                               fprintf(outDataFile, '%s\n', firstLineTxt);
                               firstLineTxt = sprintf('Frequency = %8.7e GHz ', B.freq);
                               fprintf(outDataFile, '%s\n', firstLineTxt);
                               firstLineTxt = ['=============================================================='];
                               fprintf(outDataFile, '%s\n', firstLineTxt);
                               fprintf(outDataFile, '%s\t', 'Field (Oe)');
                               fprintf(outDataFile, '%s\t', 'Intencity (a.u.)');
                               fprintf(outDataFile, '%s\n', 'Intencity_RAW (a.u.)');
                                dlmwrite (myFile, outData , 'delimiter', '\t', ...
                                            'precision','%10.8e' , '-append');
                                fclose(outDataFile);
        
        
        setappdata(B.hFig,'B',B);
%     
%     B = getappdata(B.hFig,'B');
%         setappdata(B.hFig,'B',B);
%     return % возврат в вызывающую программу
end