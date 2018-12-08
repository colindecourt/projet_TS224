clear; close all; clc; dbstop if error;

%% Chargement des données 
load('dataEEG.mat');

%% Déclaration des variables
Fe=1000; %Hz
N=1024;
Te=1/Fe;
f0=50; %Hz

%% Représentation des signaux 
% Representation temps-fréquence permet de voir la richesse fréquentielle du signal au cours du temps
x=(1:N)*Te;

% Génération des signaux
%y=randn(1,length(x));
%y=randn(1,N);
y=cos(2*pi*f0*x);


% Representation
representation_temp_freq(y, Fe);

%% DFA
[y_init,alpha]=DFA(y);

