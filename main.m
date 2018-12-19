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

%y1=randn(1,1000);

% x=(1:N)*Te; 
% y=cos(2*pi*f0*x);

y1=cell2mat(dataEEG(1,1,1))';
% y2=cell2mat(dataEEG(1,2,2))';


%% Représentation des signaux 

% representation_temp_freq(y1, Fe, 1);
% representation_temp_freq(y2, Fe, 2);

%% DFA

[y_init,alpha_DFA]=DFA(y1, N_vec);


%% DMA
alpha_DMA=DMA(y1,Fe, N_vec)