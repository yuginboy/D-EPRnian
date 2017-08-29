function f_PastPropertiesInFiles(src,eventdata,B)
% Функции по работе с контекстным меню для lb_files поля.
% Вставляем или распространяем (пропагируем) свойства выделенной кривой на
% другие выделенные кривые
% (propagate: regions,components,processing,annotation,autoFit comp-regions,Regions Errors,Components Errors).
B = getappdata(B.hFig,'B');
if isfield(B, 'masterCurve')
    if ~isempty(B.masterCurve)
        selectValues = get(B.lb_files, 'Value');
        len = length(selectValues);
        if len > 2
                B.hWaitBar = waitbar(0,'1','Name','Propagate properties',...
                    'Color', B.figColorBG, ...
            'CreateCancelBtn',...
            'setappdata(gcbf,''canceling'',1)');
            setappdata(B.hWaitBar,'canceling',0)
            warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
            jframe=get(B.hWaitBar,'javaframe');
            jIcon=javax.swing.ImageIcon('./icons/main/default_icon.png');
            jframe.setFigureIcon(jIcon);

        end
        
        % Main loop:
        for ind = 1 : len
            set(B.lb_files, 'Value',selectValues(ind));
            setappdata(B.hFig,'B',B);
                mDisplayEPRfiles_loadData_v_01(B);
            B = getappdata(B.hFig,'B');
            
            %Wait bar:
            if len > 2
                txt = sprintf('Achieved %3.0d curves form %3.0d', ind, len);
                figure(B.hWaitBar);
                waitbar( ind / len, B.hWaitBar, txt);
                % Check for Cancel button press
                if getappdata(B.hWaitBar,'canceling')
                    disp('Paste/propagate properties procedure was canceled')
                    break
                end
            end
            % Смотрим, является ли текущая кривая в списке редактированных
            % ранее, если cn = 0 то нет.
            cn = B.currentCurveNumber;
            if cn > 0
                % Если уже существуют регионы то удаляем их с данной кривой
                setappdata(B.hFig,'B',B);
                f_CleanCurve(B);
                B = getappdata(B.hFig,'B');

                setappdata(B.hFig,'B',B);
                f_RearrangeCurves(B);
                B = getappdata(B.hFig,'B');
            end   
                % После удаления всех регионов с выбранной кривой переходим к
                % созданию регионов с мастер-кривой
                for i = 1 : length(B.masterCurve.Peak)
                    setappdata(B.hFig,'B',B);
                    f_CreatePeakInTheRegion (B, B.masterCurve.Peak(i));
                    B = getappdata(B.hFig,'B');
                end

                setappdata(B.hFig,'B',B);
                f_RearrangeCurves(B);
                B = getappdata(B.hFig,'B');
                

%             disp(selectValues(ind));
        end
        if len > 2
            delete( B.hWaitBar);
               
        end
    end
end
setappdata(B.hFig,'B',B);
end