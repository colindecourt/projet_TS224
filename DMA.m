function [alpha] = DMA(Y,Fe, Nens)
% Detrending Moving Average (DMA)

close all;

%% Parametres

M=length(Y);
mu_y=mean(Y);


%% Création du profil

y_int=[];
for m=1:M
    y_int=[y_int sum(Y(1:m)-mu_y)];
end

F=[];
for j=1:length(Nens) % Calcul pour différentes valeurs de N
    
    N=Nens(j);
    
    % Fontion de transfert du filtre    
    b=[1 zeros(1,N-1) -1]; % Numérateur
    a=N*[1 -1]; % Dénominateur
       
    % Reponse en fréquence et en phase
    f = -1/2:1/256:(1/2-1/256);
    f1 = -Fe:1/256:Fe; % Pour visualiser tout le signal théorique
    [H,w] = freqz(b,a,2*pi*f);
    
    
    
    %% Affichage de la réponse en fréquence et de la phase
    %     figure
    %     subplot(1,2,1);
    %     plot(f,abs(H));
    %     title('Réponse en fréquence du filtre h_{DMA}');
    %     xlabel('Frequence (Hz)');
    %     ylabel('Amplitude');
    %     subplot(1,2,2)
    %     plot(f,w);
    %     title('Phase du filtre h_{DMA}');
    %     xlabel('Frequence (Hz)');
    %     ylabel('Phase en rad');
    %
    %     figure
    %     sig_th =sin(pi*f1*N/Fe)./(N*pi*f1*Fe);
    %     plot(f1,abs(sig_th));
    %     title('Réponse fréquentielle du signal théorique');
    %     xlabel('Frequence (Hz)');
    %     ylabel('Amplitude');
    
    
    
    %% Filtrage du profil y_int
    yint_filtre = filter(b,a,y_int);
    
    
    %% Prise en compte du retard induit par le filtre
    
    delay=floor((N-1)/2)+1; % Attention on a pris on dessus, à verif ds théorie
    yint_filtre_delay=yint_filtre(delay:end); % Tendance
    
    % Permet d'avoir la meme taille que y_int_filtre_delay
   % y_int=y_int(1:end-delay+1);
    
    
    %% Calcul du résidu
    
    F_temp=0;
    L=length(yint_filtre_delay);
    for n=1:L
        F_temp = F_temp+(y_int(n) - yint_filtre_delay(n)).^2;
    end
    F_temp = sqrt((1/L)*F_temp);
    
    F=[F F_temp];
    
    %     % Affichage
    %     figure
    %     plot(y_int)
    %     hold on
    %     plot(y_int_filtre_delay)
    %     plot(F_temp)
    %     hold off
    %
    
end

%% Recherche de la pente alpha de la droite des profils

X=log(Nens);
Y=log(F);

[r,alpha,b] = regression(X ,Y,'one');
droite = alpha*X+b;

%% Affichage
figure

% F(N)
plot(X,Y,'o');
hold on

% Droite de régression
plot(X,droite);

title('Droite représentant les valeurs des profils globals pour differentes valeurs de N');
xlabel('log(F(N)');
ylabel('log(N)');
legend('Tendance globale du profil','Droite de regression');
hold off

end

