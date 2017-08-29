function [y,k] = litcount(filename, literal)
% Search for number of string matches per line.  
%
% Подсчет номера строк в большом файле:
% I found a nice trick here:
% 
% if (isunix) %# Linux, mac
%     [status, result] = system( ['wc -l ', 'your_file'] );
%     numlines = str2num(result);
% 
% elseif (ispc) %# Windows
%     numlines = str2num( perl('countlines.pl', 'your_file') );
% 
% else
%     error('...');
% 
% end
% 
% where 'countlines.pl' is a perl script, containing
% 
% while (<>) {};
% print $.,"\n";




fid = fopen(filename);
y = [0];
i = 1;
k = 1;
tline = fgetl(fid);
disp('- >> Please wait when the lines will be counted...');
while ischar(tline)
   matches = strfind(tline, literal);
   num = length(matches);
   if num > 0
      y(k,1) = i;
      k = k + 1;
      %fprintf(1,'%d:%d:%s\n',i,num,tline);
   end
   tline = fgetl(fid);
   i = i + 1;
end
disp('- >> Lines was counted...');
fclose(fid);
end