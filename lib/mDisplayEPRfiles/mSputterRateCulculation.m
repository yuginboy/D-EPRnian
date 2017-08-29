function Zt = mSputterRateCulculation
% Фуекция расчета скорости спатерирования заданного материала
% z/t = M/(rho*Na*e)*Sy*Jp
% Where:
% M - molar weight of the target [kg/mol]
% rho - density of the material [kg/m^3]
% Na = 6.022e26 Avogadro number [1/kmol]
% e = 1.6e-19 elementary charge [C]
% Sy - sputter yield [atom/ion]
% Jp - primary ion current density [A/m^2]
% 1 monoloyer = 2 Atomic Radius


% % W example:
% Name = 'W';
% M = 184; % [g/mol]
% rho = 19.26; % [g/cm^3]
% Na = 6.022e26;% [1/kmol]
% e = 1.6e-19;
% Sy = 1; % for E(Ar+) = 1 keV
% Jp = 1; % [mA/cm^2]
% Jp = 1e-3/1e-4; % [A/m^2]

% Si example:
Name = 'Si';
M = 28.09; % [g/mol]
rho = 2.33; % [g/cm^3]
Na = 6.022e26;% [1/kmol]
e = 1.6e-19;
Sy = 1.64; % for E(Ar+) = 0.5 keV and alpha = 55 deg
I = 390e-9; % ion current [A]
A = 4e-6; % area [m^2]
Jp = I/A; % [A/m^2]

% % Nb example:
% Name = 'Nb';
% M = 93; % [g/mol]
% rho = 2.33; % [g/cm^3]
% Na = 6.022e26;% [1/kmol]
% e = 1.6e-19;
% Sy = 2; % for E(Ar+) = 0.5 keV and alpha = 55 deg
% I = 390e-9; % ion current [A]
% A = 4e-6; % area [m^2]
% Jp = I/A; % [A/m^2]

M = M * 1e-3; % [kg/mol]

Zt = M/(rho*Na*e)*Sy*Jp;
txt = sprintf('Sputter rate for %s is: %g A/s or %g A/min', Name, Zt*1e10, Zt*1e10*60);
disp(txt);
end