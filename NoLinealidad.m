clear all;
Datos

% -----------------------------
% No Linealidad

LNL = 1/(gamma); % L_{NL} La potencia fue ajustada de forma deliberada.

%ss = max(X);    % El maximo es 1 jeje
%X = X/ss;  

% -----------------------------
% Inicio animacion

j = 1;
z  = 0;
dz = 0.05;

YTeo = NonlinearPhaseShift(X, 0.0001, 0 , LNL);

while z < Zmax
    %Calculo
    
    Y = SSF(X, dz, 0.0001, 0 , gamma,P0, Fs, NT);
    Yw = fftshift(fft(Y,NT)); % Factor de escala que sirve por alguna razón;
    Yt = YTeo(j*dz);
    Ytw = fftshift(fft(Yt,NT));
    
    Yp = abs(Yw);
    Ytp = abs(Ytw);
    YT = abs(Y);
    
    %Ploteo
    
    subplot(2,2,1);
    plot(w(1+7*NT/16:end-7*NT/16),Yp(1+7*NT/16:end-7*NT/16));
    %ylim([0 1]);
    %yticks(0:0.1:1);
    grid on;
    xlabel("w [ THz ] ");
    ylabel("|U_w|^2");
    title("Método SSF");
    
    subplot(2,2,3);
    plot(w(1+7*NT/16:end-7*NT/16),Ytp(1+7*NT/16:end-7*NT/16),"r");
    grid on;
    xlabel("w [ THz ]");
    ylabel("|U_T|^2");
    title("Teórico");
    
    subplot(2,2,2);
    plot(T(1+NT/4:end-NT/4),YT(1+NT/4:end-NT/4));
    grid on;
    xlabel("T [ps]");
    ylabel("|U|^2");
    title(" Evolución temporal ")
    
    %Lazo
    j = j + 1;
    X = Y;
    z = z + dz;
    pause(0.000001);
    
end
