function [x,y,alpha,info,src_y] = mload_EPR_data (filename,B)
% Загружаем данные X Y и угловую Alpha
% Преобразуем данные вычитая фон, используя метод наименьших квадратов для
% поиска наилучшей прямой, значения которой потом вычитаем из исходных
% данных
tStart = tic; 
B = getappdata(B.hFig,'B');
chkAutoSmooth = B.valeAutoSmoothForLoadSpectra;
valSmooth = B.valeAutoSmoothForLoadSpectra_number;
[Ax,Ay,info]=eprload(filename);
if isfield(info,'FrequencyMon')
    [n,m] = size (Ax);
    [nb,mb] = size (Ay);

    if m > 1
        % данные по полю
        x = Ax{1};
        x = x';
        % данные по углу
        alpha = num2str (Ax{2});
        y = Ay;

        for i = 1:mb
            ii = find(isnan(y(:,i)));
            y(ii,i) = 0;
            y_max = max(max(y(:,i)));
            y(ii,i) = y_max;
            if log(abs(y_max)) > 30
                y(:,i) = y(:,i)./y_max;
            end
            p = polyfit(x,y(:,i),1);
            y(:,i) = y(:,i) - polyval(p,x);
            if chkAutoSmooth
%                 y(:,i) = mDisplayEPRfiles_matlabSmooth_original(x, y(:,i), valSmooth);
                y(:,i) =smoothn( y(:,i), valSmooth);
            end
        end
    else
        % данные по полю
        x = Ax; 
        % данные по углу
        alpha = ['--'];
        y = Ay;
        ii = find(isnan(y(:)));
        y(ii) = 0;
        y_max = max(max(y(:)));
        y(ii) = y_max;
        if log(abs(y_max)) > 30
            y = y./y_max;
        end

        p = polyfit(x,y,1);
        y = y - polyval(p,x);
        if chkAutoSmooth
%                 y = mDisplayEPRfiles_matlabSmooth_original(x, y, valSmooth);
                y = smoothn(y, valSmooth);
        end
    end
else
    % Если данные получены на спектрометре в IF-PAN у Пашы Алешкевича
    [n,m] = size (Ax);
    if n<m
        Ax = Ax';
    end
    [nb,mb] = size (Ay);
    % данные по полю
        x = Ax; 
        % данные по углу
        alpha = ['--'];
        y = Ay;
        ii = find(isnan(y(:)));
        y(ii) = 0;
        y_max = max(max(y(:)));
        y(ii) = y_max;
        if log(abs(y_max)) > 30
            y = y./y_max;
        end

        p = polyfit(x,y,1);
        y = y - polyval(p,x);
%         if isfield(B,'lb_dir')
%             set(B.lb_dir, 'Enable', 'off');
%         end
%         if isfield(B,'lb_files')
%             set(B.lb_files, 'Enable', 'off');
%         end
%         if isfield(B,'lb_struct')
%             set(B.lb_struct, 'Enable', 'off');
%         end
        
        if chkAutoSmooth
%                 y = mDisplayEPRfiles_matlabSmooth_original(x, y, valSmooth);
% %                 y = fastsmooth(y, valSmooth);
            y = smoothn(y, valSmooth);
        end
        
%         if isfield(B,'lb_dir')
%             set(B.lb_dir, 'Enable', 'on');
%         end
%         if isfield(B,'lb_files')
%             set(B.lb_files, 'Enable', 'on');
%         end
%         if isfield(B,'lb_struct')
%             set(B.lb_struct, 'Enable', 'on');
%         end
        
        
        info.FrequencyMon = num2str(info.MF);
end
src_y = Ay;
tElapsed = toc(tStart);
txt = sprintf('load EPR data time: %g s', tElapsed);
% disp(txt);
% setappdata(B.hFig,'B',B);
end