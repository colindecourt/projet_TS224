function [F] = DMA(y,Fe,tendance)
% Detrending Moving Average (DMA)


%% Parametres

M=length(y);
mu_y=mean(y);


%% Création du profil

for m=1:M
    somme=0;
    for i=1:m
        temp=y(i)-mu_y;
        somme=somme+temp;
    end
    y_int(m)=somme;
    
end


for j=3:5:M/2
    
    
    N=j;
    
    b = 1/N*ones(1,N);
    a=1;
    f = -1/2:1/256:(1/2-1/256);
    f1 = -Fe:1/256:Fe; %Pour visualiser tout le signal théorique
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
    
    y_int_filtre = filter(b,a,y_int);
    
    % Deux solutions pour la suite : soit on calcul les tendances locales
    % pour chaque N avec y_int_filtre comme pour le DFA puis on soustrait
    % aux tendances locales de y_int non filtré obtenue avec le DFA. 
    %Soit j'ai rien pigé de plus et.... Bon courage ;) 
    
end

end

