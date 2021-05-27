function output = FWHM(X, T)
Y = X.*T;
Aux = (Y*Y')/(X*X');
output = sqrt(Aux);

end