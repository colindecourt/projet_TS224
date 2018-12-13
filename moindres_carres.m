function [ a0,a1 ] = moindres_carres( y_int, N, L)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


a0=[];
a1=[];
X=[];
Y=[];

% Calcul de a0 et a1 pour chaque segment
for l=1:L
    
    x_mean=0;
    y_mean=0;
    x2_mean=0;
    xy_mean=0;
    
    for n=1:N
        
        % Calcul de X, vecteur contenant tous les x
        x=(l-1)*N +n;
        X=[X x]; 

        % Calcul de Y, vecteur contenant tous les y
        y=y_int(x);
        Y=[Y y];
        
    end 
    
    % Calcul des différents coefficients utiles (voir résolution moindres carrées)
    x_mean=1/N*sum(X);
    y_mean=1/N*sum(Y);
    x2_mean=1/N*sum(X.^2);
    xy_mean=1/N*sum(X*Y');
    
    M1=[1 x_mean; x_mean x2_mean];
    M2=[y_mean; xy_mean];
    
    % Résolution matricielle pour trouver A, contenant a0 et a1
    A=inv(M1)*M2; 
    
    % Stockage des aO et a1
    a0=[a0 A(1)];
    a1=[a1 A(2)];
    
    
end 


end

