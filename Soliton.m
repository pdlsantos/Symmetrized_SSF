clear all;
Datos

% -----------------------------
% Preparo gráfico de intensidad
D = 7.2;
MFD = 8.6;
beta = B([lambda D]);
Seff = MFD^2*pi/4; % 58.09 [ um^2 ]
gamma = 1.2*80/Seff; % 0.16

Zmax =  100;            % [ km ]
dz = 0.01;               % [ km ]
NT   = 2^16;    % Muestras en la ventana temporal
AT   = 2000;    % [ ps ] Amplitud de la ventana temporal
Fs = NT/AT; 
w  = 2*pi*Fs*(-NT/2:NT/2-1)/NT; % [ THz ]
T = (-NT/2:NT/2-1)*AT/NT;       % [ ps ]
% -----------------------------
% Soliton

N = 1;      % Orden del soliton
T0 = 25;    %  [ ps ]

P0 = N^2 * abs(beta) / (gamma * T0^2);  
P1 = 1.1*P0;  
P2 = 0.9*P0;  
Xsol = 1./(cosh(T/T0)); % Soliton  5.2.15
X1 = Xsol;
X2 = Xsol;

% -----------------------------
% Inicio animacion

Paso = 0.5/dz;
j = 1;
z  = 0;
while z < Zmax
    %Calculo
    Y = SSF(Xsol, dz ,0 , beta , gamma, P0, Fs, NT);
    Y1 = SSF(X1, dz ,0 , beta , gamma, P1, Fs, NT);
    Y2 = SSF(X2, dz ,0 , beta , gamma, P2, Fs, NT);
    if mod(j, Paso) == 0
        
        Yw = fftshift(fft(Y,NT));
        Yw1 = fftshift(fft(Y1,NT));
        Yw2 = fftshift(fft(Y2,NT));

        Yp = abs(Y);
        Ywp = abs(Yw)*1000;

        Yp1 = abs(Y1);
        Ywp1 = abs(Yw1)*1000;

        Yp2 = abs(Y2);
        Ywp2 = abs(Yw2)*1000;

        subplot(2, 3, 1);
        plot(T(1+3*NT/8:end-3*NT/8), Yp(1+3*NT/8:end-3*NT/8));
        xlabel("t [ ps ]");
        title("Solitón Fundamental");

        subplot(2, 3, 4);
        semilogy(w(1+7*NT/16:end-7*NT/16)/(2*pi), Ywp(1+7*NT/16:end-7*NT/16));
        xlabel("w [ THz ]");
        ylabel("dBm(|U_w|^2)");
        title(strcat("Z = ",num2str(dz*j), " km"));

        subplot(2, 3, 2);
        plot(T(1+3*NT/8:end-3*NT/8), Yp1(1+3*NT/8:end-3*NT/8));
        xlabel("t [ ps ]");
        title("10% mas potencia");

        subplot(2, 3, 5);
        semilogy(w(1+7*NT/16:end-7*NT/16)/(2*pi), Ywp1(1+7*NT/16:end-7*NT/16));
        xlabel("w [ THz ]");
        ylabel("dBm(|U_w|^2)");
        title(strcat("Z = ",num2str(dz*j), " km"));

        subplot(2, 3, 3);
        plot(T(1+3*NT/8:end-3*NT/8), Yp2(1+3*NT/8:end-3*NT/8));
        xlabel("t [ ps ]");
        title("10% menos potencia");
        
        subplot(2, 3, 6);
        semilogy(w(1+7*NT/16:end-7*NT/16)/(2*pi), Ywp2(1+7*NT/16:end-7*NT/16));
        xlabel("w [ THz ]");
        ylabel("dBm(|U_w|^2)");
        title(strcat("Z = ",num2str(dz*j), " km"));
    
    pause(0.000001);
    end
    
    %Lazo
    X1 = Y1;
    X2 = Y2;
    j = j+1;
    Xsol = Y;
    
    z = z + dz;
    
    
end
    