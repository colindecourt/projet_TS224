function [ a0,a1 ] = moindres_carres( y_int, N, L)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here



a0 =[];
a1 =[];

% Calcul de a0 et a1 pour chaque segment
for l=1:L
    
    x_sum  = 0;
    x2 = 0;
    y  = 0;
    y_sum = 0;
    
    for n=1:N
        
        x=(l-1)*N+n;
        x_sum  = x_sum  + x;
        x2 = x2 +x^2;
        y  = y  + y_int(x);
        y_sum = y_sum + x*y_int(x);
        
    end
    
    % Résolution matricielle pour trouver A, contenant a0 et a1
    M1 = [N, x_sum; x_sum, x2];
    M2 = [y; y_sum];
    A = inv(M1)*M2;
    
    % Stockage des aO et a1
    a0 = [a0; A(1)];
    a1 = [a1; A(2)];
end


end

