function c =  mConvertCellToDouble (C)
% "cellfun(@str2double, C)" is faster than "str2double(C)". Surprising! 
% But the indirection "cellfun(@(x)str2double(x), C)" wastes time.
c = cellfun(@str2double, C);
end