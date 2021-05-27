clear all;
Datos

% -----------------------------
% Dispersion
Zmax = 5;

dz = 0.04;                  % [ km ] Paso
A = FWHM(X,T);              % [ ps ] Ancho Inicial
ZD =  T0^2/abs(beta);       % [ km ] Long de dispersion
Z = (0:(Zmax/dz))*dz;       % [ km ]
Disp = zeros(1,length(Z));
DispT = (1+(Z/ZD).^2).^0.5;

T0 = 10;
X1 = exp(-0.5*T.^2/(T0^2));
T0 = 20;
X2 = exp(-0.5*T.^2/(T0^2));

% -----------------------------
% Inicio animacion
i = 1;
z  = 0;

while z < Zmax
    %Calculo
    
    Y = SSF(X, dz ,0 , beta , 0,P0, Fs, NT);
    Disp(i) = FWHM(Y,T)/A;
    Yw = fftshift(fft(Y,NT))/((pi*Fs)^2);   % Factor de escala que sirve por alguna razón
    
    Y1 = SSF(X1, dz ,0 , beta , 0,P0, Fs, NT);
    Y2 = SSF(X2, dz ,0 , beta , 0,P0, Fs, NT);
    
    Yp = abs(Y);
    Yp1 = abs(Y1);
    Yp2 = abs(Y2);
    Ywp = abs(Yw);
    
    %Ploteo
    
    subplot(2,3,1);
    plot(T(1+NT/8:end-NT/8),Yp(1+NT/8:end-NT/8));
    grid on;
    xlabel("T [ps]");
    ylabel("|U|^2")
    title("T_0 = 5 ps y | = 22.94");
    
    subplot(2,3,2);
    plot(w(-299+NT/2:end+300-NT/2),Ywp(-299+NT/2:end+300-NT/2));
    grid on;
    xlabel("w [THz]");
    ylabel("|U_w|^2");
    title("T_0 = 5 ps y |\beta| = 22.94");
    
    subplot(2,3,3);
    hold on;
    plot(Z,Disp,"b");
    plot(Z,DispT,"r");
    legend("Práctico","Teórico");
    hold off;
    grid on;
    xlabel("z [km]");
    ylabel("T_1/T_0");
    title("T_0 = 5 ps y |\beta| = 22.94");
    
    subplot(2,3,4);
    plot(T(1+NT/8:end-NT/8),Yp(1+NT/8:end-NT/8));
    grid on;
    xlabel("T [ps]");
    ylabel("|U|^2")
    title("T_0 = 5 ps y |\beta| = 22.94");
    
    subplot(2,3,5);
    plot(T(1+NT/8:end-NT/8),Yp1(1+NT/8:end-NT/8));
    grid on;
    xlabel("T [ps]");
    ylabel("|U|^2")
    title("T_0 = 10 ps y |\beta| = 22.94");
    
    subplot(2,3,6);
    plot(T(1+NT/8:end-NT/8),Yp2(1+NT/8:end-NT/8));
    grid on;
    xlabel("T [ps]");
    ylabel("|U|^2")
    title("T_0 = 20 ps y |\beta| = 22.94");
    
    %Lazo
    i = i + 1;
    X = Y;
    X1 = Y1;
    X2 = Y2;
    z = z + dz;
    pause(0.000001);
    
end
