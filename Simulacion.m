clear all;
Datos

% -----------------------------
% Inicio animacion

dz = 0.02;
z  = 0;
while z < Zmax
    %Calculo
    Y = SSF(X, dz ,alpha , beta , gamma,P0, Fs, NT);
    Yw = fftshift(fft(Y,NT));
    
    Yp = abs(Y);
    Ywp = abs(Yw);
    
    %Ploteo
    
    subplot(2,1,1);
    plot(T,Yp);
    %ylim([0 1]);
    %yticks(0:0.1:1);
    grid on;
    xlabel("T/T_0");
    ylabel("|U|^2");
    
    subplot(2,1,2);
    plot(w,Ywp);
    grid on;
    xlabel("w");
    ylabel("|U_w|^2");
    
    %Lazo
    
    X = Y;
    z = z + dz;
    pause(0.000001);
    
end