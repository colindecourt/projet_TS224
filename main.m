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

y=cell2mat(dataEEG(1,1,1));
y=y';

%% Représentation des signaux 

representation_temp_freq(y, Fe);

%% DFA

[y_init,alpha]=DFA(y);

