% DATOS FIBRA / FABRICANTE

D = 18;             % [ ps / (nm km) ]
MFD = 10.4;         % [ um ]
lambda = 1550;      % [ nm ]
alpha = 1.0423;     % [ 1/ km ] 0.18 dB/km

% DATOS SIMULACION

P0 = 1;         % P0    
dz   = 0.0001;  % [ km ] Paso
NT   = 2^16;    % Muestras en la ventana temporal
AT   = 2000;    % [ ps ] Amplitud de la ventana temporal
Zmax = 40;      % [ km ] Distancia máxima simulada
dt   = AT/NT;   % [ ps ]
T0   = 5;       % [ ps ]
% -------------------------------------------------
% Preparo variables

c = 3*10^5; % [ nm / ps ]
Seff = MFD^2*pi/4; % 84.948 [ um^2 ]

gamma = 1.2*80/Seff;            % 1.13
B = @(x) -(x(1)^2/(2*pi*c))*x(2); 
beta = B([lambda D]);  % 22.94 [ps^2 / nm^2 km ]

T = (-NT/2:NT/2-1)*AT/NT;       % [ ps ]
X = exp(-0.5*T.^2/(T0^2));      % Forma de pulso inicial

Fs = NT/AT;                     % [ THz ] Frecuencia de sampleo
w  = 2*pi*Fs*(-NT/2:NT/2-1)/NT; % [ THz ]
