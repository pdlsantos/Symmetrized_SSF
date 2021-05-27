function output = Energia(X, dt)

output = sum(abs(X).^2)*dt;

end