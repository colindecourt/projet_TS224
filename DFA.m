function [ y_init,alpha ] = DFA( y )
% Detrended Fluctuation Analysis (DFA)
%   Idée : Trouver la tendance locale (sur M echanttillons) (attention il peut avoir des discontinuités --> calcul du résidu, de la puissance et de ... )
% Il faut faire une estimation des moindres carrés

%% Parametres

F=[];
M=length(y);
mu_y=mean(y);

N_vec = [11,13,17,21,27,35,47,59,77,101];

%% Création du profil

y_init=[];
for m=1:M
    y_init=[y_init sum(y(1:m)-mu_y)];   
end

% Affichage du profil
figure, plot(y_init); title('Profil du signal'); xlabel('Echantillons') ; ylabel('Amplitude')

for j=1:length(N_vec)
    
    %% Décomposition du profil et tendance locale
    N=N_vec(j);
    L= floor(M/N);  % Nombre de segments ( pas 1, 2, ni au dela de M/2 car plus d'interet)
    
    % Moindres carrés
    [a_0,a_1] = moindres_carres(y_init,N,L);
    
    % Tendance locale sur chaque segment
    xl=zeros(N,L);
    for l=1:L 
        for n=1:N
            p(n)=(l-1)*N+n;
            xl(n,l)=a_1(l)*p(n) + a_0(l);
        end
    end
    xl = reshape(xl,1,N*L);
    
    %% Calcul de la tendance globale du profil
    
    F_temp=0;
    for l=1:L
        for n=1:N
            F_temp = F_temp+(y_init((l-1)*N+n)-xl(n))^2;
        end
    end
    F_temp = sqrt((1/L*N)*F_temp);
    F = [F [F_temp; N]];
end


figure
plot(log(F(1,:)),log(F(2,:)),'o');
title('Droite représentant les valeurs des profils globals pour differentes valeurs de N');
xlabel('log(F(N)');
ylabel('log(N)');
hold on

%% Recherche de la pente alpha de la droite des profils

t=log(F(1,:));
y=log(F(2,:));

[r,alpha,b] = regression(t ,y,'one');
droite = alpha*t+b;
plot(t,droite);
legend('Tendance globale du profil','Droite de regression');
hold off

end

  