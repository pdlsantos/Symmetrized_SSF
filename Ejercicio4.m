% Ejercicio 4
clear all;

Datos

D = 7.2;
MFD = 8.6;
beta = B([lambda D]);   %9.17
Seff = MFD^2*pi/4; % 58.09 [ um^2 ]
gamma = 1.2*80/Seff; % 0.16

NT   = 2^19;    % Muestras en la ventana temporal
AT   = 1500;    % [ ps ] Amplitud de la ventana temporal
T = (-NT/2:NT/2-1)*AT/NT;       % [ ps ]
Fs = NT/AT;                     % [ THz ] Frecuencia de sampleo
w  = 2*pi*Fs*(-NT/2:NT/2-1)/NT; % [ THz ]

% -----------------------------
% Preparo gráfico los datos

T0 = 50;   % 10 Gb/s
X = exp(-0.5*T.^2/(T0^2)) + exp(-0.5*(T).^2/(T0^2)).*exp(i*-0.1*pi*(T));      % Forma de pulso inicial
%X = X / (X*X');

% -----------------------------
% Inicio animacion
j = 1;
Zmax = 100;
dz = 0.01;
z  = 0;
Paso = 0.5/dz;

while z < Zmax
    %Calculo
    Y = SSF(X, dz ,0 , beta , gamma,0.001, Fs, NT);
    
    if mod(j,Paso) == 0
        Yw = fftshift(fft(Y, NT));
        
        Yp  = abs(Y);
        Ywp = abs(Yw);
        
        %Ploteo

        subplot(2,1,1);
        plot(T,Yp);
        %ylim([0 1]);
        %yticks(0:0.1:1);
        grid on;
        xlabel("T");
        ylabel("|U|^2");
        title("Rb = 10 GB/s(este si), Fibra TW RS y P0 = 1 mW");
        subplot(2,1,2);
        semilogy(w(1+63*NT/128:end-63*NT/128)/(2*pi),Ywp(1+63*NT/128:end-63*NT/128));
        grid on;
        xlabel("f [THz]");
        ylabel("dBm|U_w|");
        title(strcat("Z = ",num2str(dz*j), " km"));
        
        pause(0.000001);
    end
    %Lazo
    
    j = j+1;
    X = Y;
    z = z + dz;
end
X = Y;
