function output = NonlinearPhaseShift(X, alpha, beta, LNL)
    Leff = @(z) (1-exp(-1*alpha*z))/alpha;
    phiNL = @(z) abs(X).^2*(Leff(z)/LNL);
    coef = @(z) 1/sqrt(1-i*beta*z);
    output = @(z) exp(-alpha*z*0.5)*coef(z)*(X.^coef(z)).*exp(i*phiNL(z));
end