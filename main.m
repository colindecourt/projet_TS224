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

y_bb=randn(1,1000);

x=(1:N)*Te;
y_cos=cos(2*pi*f0*x);

y1=cell2mat(dataEEG(1,2,2))';

y2=cell2mat(dataEEG(2,1,4))';


%% Représentation des signaux

% representation_temp_freq(y1, Fe, 1);
% representation_temp_freq(y2, Fe, 2);
% representation_temp_freq(y_bb, Fe, 3);
% representation_temp_freq(y_cos, Fe, 4);

%% DFA

%y1=cell2mat(dataEEG(2,1,4))';

%[y_init,alpha_DFA]=DFA(y1, N_vec);


%% DMA
%alpha_DMA=DMA(y1,Fe, N_vec)
