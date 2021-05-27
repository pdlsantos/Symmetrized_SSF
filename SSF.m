function output = SSF(X, dz ,alpha , beta , gamma,P0, Fs, NT)
    
    Y  = X.*exp(i*0.5*dz*gamma*P0*(abs(X).^2)); % aplico el primer operador
    Yw = fft(Y,NT);    % Aplico la fft y Shifteo
    w  = fftshift(2*pi*(-NT/2:NT/2-1)*(Fs/NT));  % Obtengo el rango de frecuencias
    Xw = ifft(exp(-0.5*alpha*dz)*exp(i*dz*0.5*beta*(w.^2)).*Yw, NT);
    output = Xw.*exp(i*0.5*dz*gamma*P0*(abs(X).^2));
    
end

% function output = SSF(X, dz ,alpha , beta , gamma, Fs, NT)
%     
%     Y  = X.*exp(i*dz*gamma*abs(X).^2); % aplico el primer operador
%     Yw = fft(Y,NT);    % Aplico la fft y Shifteo
%     w  = fftshift(2*pi*(-NT/2:NT/2-1)*(Fs/NT));  % Obtengo el rango de frecuencias
%     Xw = ifft(exp(-0.5*alpha*dz)*exp(i*dz*0.5*beta*(w.^2)).*Yw,NT);
%     output = Xw;
%     
% end

