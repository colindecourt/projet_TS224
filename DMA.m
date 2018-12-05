function [] = DMA(y)
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
    y_init(m)=somme;
    
end
% figure
% plot(y_init);
% hold on
b = 1/20*ones(1,20);
a=1;
f = -1/2:1/256:(1/2-1/256);
[H,w] = freqz(b,a,2*pi*f);

%% Affichage de la réponse en fréquence et de la phase
figure
subplot(1,2,1);
plot(f,abs(H));
title('Réponse en fréquence du filtre h_{DMA}');
xlabel('Frequence (Hz)');
ylabel('Amplitude');
subplot(1,2,2)
plot(f,w);
title('Phase du filtre h_{DMA}');
xlabel('Frequence (Hz)');
ylabel('Phase en rad');


end

