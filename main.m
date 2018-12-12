clear; close all; clc; dbstop if error;

%% Chargement des données 
load('dataEEG.mat');

%% Déclaration des variables
Fe=1000; %Hz
N=1024;
Te=1/Fe;
f0=50; %Hz

%% Génération des signaux

%y=randn(1,1000);

% x=(1:N)*Te;
% y=cos(2*pi*f0*x);

y1=cell2mat(dataEEG(1,1,1))';
y2=cell2mat(dataEEG(1,2,2))';


%% Représentation des signaux 

representation_temp_freq(y1, Fe, 1);
representation_temp_freq(y2, Fe, 2);

%% DFA

[y_init,alpha]=DFA(y1);

