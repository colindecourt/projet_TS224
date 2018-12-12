function [F] = DMA(y,Fe)
% Detrending Moving Average (DMA)

close all;

%% Parametres

M=length(y);
mu_y=mean(y);


%% Cr�ation du profil

for m=1:M
    somme=0;
    for i=1:m
        temp=y(i)-mu_y;
        somme=somme+temp;
    end
    y_int(m)=somme;
    
end

F=[];
N_vec = [11,13,17,21,27,35,47,59,77,101];
for j=1:length(N_vec) % calcul pour diff�rentes valeurs de N
    
    N=N_vec(j);
    b = 1/N*ones(1,N);
    a=1;
    f = -1/2:1/256:(1/2-1/256);
    f1 = -Fe:1/256:Fe; %Pour visualiser tout le signal th�orique
    [H,w] = freqz(b,a,2*pi*f);
    
    
    
    
    %% Affichage de la r�ponse en fr�quence et de la phase
    %     figure
    %     subplot(1,2,1);
    %     plot(f,abs(H));
    %     title('R�ponse en fr�quence du filtre h_{DMA}');
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
    %     title('R�ponse fr�quentielle du signal th�orique');
    %     xlabel('Frequence (Hz)');
    %     ylabel('Amplitude');
    
    
    
    
    %% Filtrage du profil y_int
    
    y_int_filtre = filter(b,a,y_int);
    
    %% Calcul du r�sidu
    
    % Prise en compte du retard de groupe pour pouvoir comparer les 2 signaux
    delay=floor(0.5*(N-1)); % voir th�orie %Attention on a pris on dessus, � verif
    
    % D�calage du y_init
    y_int_filtre_delay=y_int_filtre(delay:end); %tendance
    
    y_int=y_int(1:end-delay+1); % Permet d'avoir la meme taille que y_int_filtre_delay
    
    % R�sidu
    %R=((y_int - y_int_filtre_delay).^2);
    
    F_temp=0;
    for n=1:N
        F_temp = F_temp+(y_int(n) - y_int_filtre_delay(n)).^2;
    end
    F_temp = sqrt((1/N)*F_temp);
    
    F=[F [F_temp;N]];
    
%     % Affichage
%     figure
%     plot(y_int)
%     hold on
%     plot(y_int_filtre_delay)
%     plot(F_temp)
%     hold off
%     
    
end


figure
plot(log(F(1,:)),log(F(2,:)),'o');
title('Droite repr�sentant les valeurs des profils globals pour differentes valeurs de N');
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

