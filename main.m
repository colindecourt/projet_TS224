clear; close all; clc; dbstop if error;

%% Chargement des données
load('dataEEG.mat');

%% Déclaration des variables
Fe=1000; %Hz
N=1024;
Te=1/Fe;
f0=50; %Hz
N_vec = [11,13,17,21,27,35,47,59,77,101];

%% Génération des signaux

% Cosinus
x=2*(1:N)*Te;
y_cos=chirp(x, 0, 1, 250);

% EEG
y1=cell2mat(dataEEG(1,2,2))';
y2=cell2mat(dataEEG(2,1,4))';

% Signaux synthétiques à régularité connue
b_blanc= randn(1,1000);
b_rouge= rednoise(1,1000);
b_bleu= bluenoise(1,1000);
b_rose= pinknoise(1,1000);


signal = chirp(x,0,1, 300);
%% Représentations signal1
 axe_temps = 0:Te:length(signal)*Te-Te;


% figure
% % Temporel
% plot(axe_temps, signal)
% title('Représentation temporelle du signal y=chirp(x,0,1,300)')
% xlabel('Time (s)')
% ylabel('Amplitude')

% Temps-fréquence
    % Paramètres
window_0 = 128;% Détermine la largeur de morceaux (en nombre d'échantillons)
window_1 = 16;
noverlap_0 = floor(window_0/2); % 50% de recouvrement
noverlap_1 = floor(window_0/10); 
nfft_0 = max(256,2^nextpow2(window_0));
nfft_1 = max(256,2^nextpow2(window_1));

% window_2 = 128;% Détermine la largeur de morceaux (en nombre d'échantillons)
% noverlap_2 = floor(window_2/2); 
% nfft_2 = max(256,2^nextpow2(window_2));

    % Affichage
figure,
subplot(2,1,1)
spectrogram(signal,hamming(window_0), noverlap_0, nfft_0, Fe,'yaxis')
title('Spectrogramme du signal y avec fenêtre rectangulaire  = 256 échantillons, recouvrement = 50%, nfft = max(256,2^{nextpow2(fenêtre)})')
subplot(2,1,2)
spectrogram(signal,hamming(window_0), noverlap_1, nfft_0, Fe,'yaxis')
title('Spectrogramme du signal y avec fenêtre de hamming = 16 échantillons, recouvrement = 50%, nfft = max(256,2^{nextpow2(fenêtre)})')
% subplot(3,1,2)
% spectrogram(signal,hamming(window_2), noverlap_2, nfft_2, Fe,'yaxis')
% title('Spectrogramme du signal y avec fenêtre de hamming = 128 échantillons, recouvrement = 50%, nfft = max(256,2^{nextpow2(fenêtre)})')


%% Représentation des signaux

% representation_temp_freq(y1, Fe, 1);
% representation_temp_freq(y2, Fe, 2);
% representation_temp_freq(b_blanc, Fe, 3);
% representation_temp_freq(y_cos, Fe, 4);

%% DFA

y1=cell2mat(dataEEG(2,1,4))';



%[y_init,alpha_DFA]=DFA(b_blanc, N_vec);


%% DMA
%alpha_DMA=DMA(y1,Fe, N_vec)
