function varCount = mProgressBarString(x, len, varCount , hWaitbar)
% Выводит в виде линии строку состояния в процентах


if (x - varCount) > 0.1*len
        v = (x / len);
        s = (varCount / len);
        varCount = x;
        if v < 0.20
            fprintf('=');
        elseif s > 0.1 && v < 0.3
            fprintf('20%%');
        elseif s > 0.2 && v < 0.4
            fprintf('=');
        elseif s > 0.3 && v < 0.5
            fprintf('40%%');
        elseif s > 0.4 && v < 0.6
            fprintf('=');
        elseif s > 0.5 && v < 0.7
            fprintf('60%%');
        elseif s > 0.6 && v < 0.8
            fprintf('=');
        elseif s > 0.7 && v < 0.9
            fprintf('80%%');
        elseif s > 0.8 && v < 1
            fprintf('=');
        elseif  v > 0.95 
            fprintf('100%% \n');    
        end
        txt = sprintf('Achieved %g %%', x/len*100);
        waitbar( x / len, hWaitbar, txt);
       
end
end