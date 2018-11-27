function [ y_init,a_0,a_1 ] = DFA( y )
% DFA 
%   Idée : Trouver la tendance locale (sur M echanttillons) (attention il peut avoir des discontinuités --> calcul du résidu, de la puissance et de ... )
 % Il faut faire une estimation des moindres carrés
 
%% Création du profil
M=length(y);
mu_y=mean(y);

for m=1:M
    somme=0;
    for i=1:m
        temp=y(i)-mu_y;
        somme=somme+temp;
    end
    y_init(m)=somme;
    
end

figure, plot(y_init, 'x'); title('Profil du signal'); xlabel('Echantillons') ; ylabel('Amplitude')

%% Décomposition du profil 
N=30; % A CHANGER !
L= floor(M/N);  % Nombre de segments ( pas 1, 2, ni au dela de M/2 car plus d'interet)

[a_0,a_1] = moindres_carres(y_init,N,L);

for l=2:L+1
    for n=1:N
        p(n)=(l-1)*N+n; 
    end
end 

for n=1:N
    xl(n)=a_0(p(n))+a_0(n); % Marche pas 
end


end

