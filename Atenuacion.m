clear all;
Datos

% -----------------------------
% Atenuacion

Zmax =  1/alpha;         % [ km ] 
dz   =  0.007;           % [ km ]
Z    = (0:(Zmax/dz))*dz; % [ km ]

Ate = zeros(1,length(Z));
A   = X*X';              % Energía de X sin dt porque se va

% -----------------------------
% Inicio animacion
i = 1;
z  = 0;
while z < Zmax
    %Calculo
    
    Y = SSF(X, dz ,alpha , 0 , 0,1 ,Fs , NT);
    Ate(i) = Y*Y'/A;
    Yp = abs(Y);
    
    %Ploteo
    
    subplot(2,1,1);
    plot(T(-299+NT/2:end+300-NT/2),Yp(-299+NT/2:end+300-NT/2));
    ylim([0 1]);
    yticks(0:0.1:1);
    grid on;
    xlabel("T [ps]");
    ylabel("|U|^2");
    
    subplot(2,1,2);
    
    hold on;
    plot(Z,exp(-1*alpha*Z), "r");
    plot(Z,Ate,"b");
    hold off;
    
    grid on;
    ylim([0 1]);
    yticks(0:0.1:1);
    legend("Teórico exp(-alpha z)","Práctico");
    xlabel("z [km]");
    ylabel("Atenuación");
    
    %Lazo
    
    i = i + 1;
    X = Y;
    z = z + dz;
    pause(0.000001);
    
end
