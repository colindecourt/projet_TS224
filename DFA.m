function [ y_init,alpha ] = DFA( y )
% Detrended Fluctuation Analysis (DFA)
%   Idée : Trouver la tendance locale (sur M echanttillons) (attention il peut avoir des discontinuités --> calcul du résidu, de la puissance et de ... )
% Il faut faire une estimation des moindres carrés

%% Parametres

F=[];
M=length(y);
mu_y=mean(y);

%% Création du profil

for m=1:M
    somme=0;
    for i=1:m
        temp=y(i)-mu_y;
        somme=somme+temp;
    end
    y_init(m)=somme;
    
end

figure, plot(y_init); title('Profil du signal'); xlabel('Echantillons') ; ylabel('Amplitude')

for j=3:5:M/2
    
    %% Décomposition du profil
    N=j;
    L= floor(M/N);  % Nombre de segments ( pas 1, 2, ni au dela de M/2 car plus d'interet)
    
    [a_0,a_1] = moindres_carres(y_init,N,L);
    xl=zeros(N,L);
    for l=2:L+1 
        for n=1:N
            p(n)=(l-1)*N+n;
            xl(n,l-1)=a_1(l-1)*p(n) + a_0(l-1);
        end
    end
    xl = reshape(xl,1,N*L);
    
    % figure,
    % plot(xl);
    % title('Affichage des tendances locales du profil')
    
    % Les précédents plots ont été commentés pour plus de visibilité (24 figures environ sinon). 
    % On remarque que plus N augmente moins le profil est visible
    
    % Exemple avec 3 valeurs de N différentes : 
    
    if(N==30)
        figure,
        plot(xl);
        title('Affichage des tendances locales du profil pour N = 30')
    end
    if(N==50)
        figure,
        plot(xl);
        title('Affichage des tendances locales du profil pour N = 50')
    end
    if(N==490)
        figure,
        plot(xl);
        title('Affichage des tendances locales du profil pour N = 490')
    end
    
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

  