clear all;
Datos

% -----------------------------
% Parseval

Zmax =  1/alpha;
dz   =  0.001;
Z    = (0:(Zmax/dz))*dz;

EnergiaT = zeros(1,length(Z));
EnergiaW = zeros(1,length(Z));

% -----------------------------
% Inicio animacion
j = 1;
z  = 0;

while z < Zmax
    %Calculo
    Y = SSF(X, dz ,alpha , beta , gamma, Fs, NT);
    Yw = fftshift(fft(Y,NT));
    
    Yp = abs(Y);
    Ywp = abs(Yw);
    
    EnergiaT(j) = Y*Y'; 
    EnergiaW(j) = Yw*Yw'/NT;
    
    %Ploteo
    
    subplot(2, 2, 1);
    plot(T,Yp);
    %ylim([0 1]);
    %yticks(0:0.1:1);
    grid on;
    xlabel("T [ps]");
    ylabel("|U|^2");
    
    subplot(2, 2, 2);
    plot(w,Ywp);
    grid on;
    xlabel("w [THz]");
    ylabel("|U_w|^2");
    
    subplot(2, 2, 3);
    plot(Z, EnergiaT, "r");
    grid on;
    xlabel("z [km]");
    ylabel("Energía");
    subplot(2, 2, 4);
    
    plot(Z, EnergiaW, "b");
    grid on;
    xlabel("z [km]");
    ylabel("Energía");
    
    %Lazo
    
    j = j+1;
    X = Y;
    z = z + dz;
    pause(0.000001);
    
end



