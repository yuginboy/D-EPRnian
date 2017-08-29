function B = mImportAdvantageData()
% Function for import 5D data which was exported from Advantage program
filename = '/home/yugin/VirtualboxShare/Prohorov/data/Avantage/Imec3d_example.txt';
% filename = '/home/yugin/VirtualboxShare/Prohorov/data/Avantage/Imec3d.txt';
% Import basis values for determine main array for variables:
B = mImportHeaderInformationInAdvantageFile(filename);

% Search linenumbers of blocks with main values:
literal = ';Values';
B.arrNumLines = [32; 49; 66];
[B.arrNumLines,k] = litcount(filename, literal);
B = mScanTextBetweenLinesInAdvantageFile (filename, B);

end