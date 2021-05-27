clear all;
Datos


% -----------------------------
% Pulso
T0 = 25;    % T0

NT   = 2^18;    % Muestras en la ventana temporal
AT   = 6000;    % [ ps ] Amplitud de la ventana temporal
T = (-NT/2:NT/2-1)*AT/NT;       % [ ps ]
Fs = NT/AT;                     % [ THz ] Frecuencia de sampleo
w  = 2*pi*Fs*(-NT/2:NT/2-1)/NT; % [ THz ]


m = 2;      % Orden del pulso
X = exp(-0.5*(T.^(2*m)/(T0^2)));

X1 = X;
X2 = X;
X3 = X;

% -----------------------------
% Inicio animacion
j = 1;
Zmax = 80;
dz = 0.1;
z  = 0;
Paso = 0.5/dz;
while z < Zmax
    %Calculo
    Y  = SSF(X, dz ,0 , beta, 0, 0.01, Fs, NT);
    Y1 = SSF(X1, dz ,0 , 0, gamma, 0.001, Fs, NT);
    Y2 = SSF(X2, dz ,0 , 0, gamma, 0.01, Fs, NT);
    Y3 = SSF(X3, dz ,0 , 0, gamma, 0.1, Fs, NT);
    
    if mod(j,Paso) == 0
        Yw  = fftshift(fft(Y,NT));
        Yw1 = fftshift(fft(Y1,NT));
        Yw2 = fftshift(fft(Y2,NT));
        Yw3 = fftshift(fft(Y3,NT));

        Yp  = abs(Y);
        Ywp = abs(Yw);

        Yp1  = abs(Y1);
        Ywp1 = abs(Yw1);

        Yp2  = abs(Y2);
        Ywp2 = abs(Yw2);

        Yp3  = abs(Y3);
        Ywp3 = abs(Yw3);

        %Ploteo

        subplot(2,4,1);
        plot(T,Yp);
        %ylim([0 1]);
        %yticks(0:0.1:1);
        grid on;
        xlabel("t [ps]");
        ylabel("|U|^2");
        title("Con dispersion y P0 = 10 mW");

        subplot(2,4,5);
        plot(w(1+NT/4:end-NT/4),Ywp(1+NT/4:end-NT/4));
        grid on;
        xlabel("w");
        ylabel("|U_w|^2");
        title(strcat("Z = ",num2str(dz*j), " km"));

        subplot(2,4,2);
        plot(T(1+3*NT/8:end-3*NT/8),Yp1(1+3*NT/8:end-3*NT/8));
        %ylim([0 1]);
        %yticks(0:0.1:1);
        grid on;
        xlabel("t [ps]");
        ylabel("|U|^2");
        title("P0 = 1 mW");

        subplot(2,4,6);
        plot(w(1+3*NT/8:end-3*NT/8),Ywp1(1+3*NT/8:end-3*NT/8));
        grid on;
        xlabel("w");
        ylabel("|U_w|^2");
        title(strcat("Z = ",num2str(dz*j), " km"));

        subplot(2,4,3);
        plot(T(1+3*NT/8:end-3*NT/8),Yp2(1+3*NT/8:end-3*NT/8));
        %ylim([0 1]);
        %yticks(0:0.1:1);
        grid on;
        xlabel("t [ps]");
        ylabel("|U|^2");
        title("P0 = 10 mW");

        subplot(2,4,7);
        plot(w(1+3*NT/8:end-3*NT/8),Ywp2(1+3*NT/8:end-3*NT/8));
        grid on;
        xlabel("w");
        ylabel("|U_w|^2");
        title(strcat("Z = ",num2str(dz*j), " km"));

        subplot(2,4,4);
        plot(T(1+3*NT/8:end-3*NT/8),Yp3(1+3*NT/8:end-3*NT/8));
        %ylim([0 1]);
        %yticks(0:0.1:1);
        grid on;
        xlabel("t [ps]");
        ylabel("|U|^2");
        title("P0 = 100 mW");

        subplot(2,4,8);
        plot(w(1+3*NT/8:end-3*NT/8),Ywp3(1+3*NT/8:end-3*NT/8));
        grid on;
        xlabel("w");
        ylabel("|U_w|^2");
        title(strcat("Z = ",num2str(dz*j), " km"));
        pause(0.000001);
    end
    %Lazo
    
    X = Y;
    X1 = Y1;
    X2 = Y2;
    X3 = Y3;
    
    j = j + 1;
    z = z + dz;
    
    
end