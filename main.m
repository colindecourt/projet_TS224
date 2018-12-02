clear; close all; clc; dbstop if error;

%% Chargement des donn�es 
load('dataEEG.mat');

%% D�claration des variables
Fe=1000; %Hz
N=1024;
Te=1/Fe;
f0=50; %Hz

%% Repr�sentation des signaux 
% Representation temps-fr�quence permet de voir la richesse fr�quentielle du signal au cours du temps
x=(1:N)*Te;

% G�n�ration des signaux
y=cos(2*pi*f0*x); 
%y=chirp(x, f0, 0.5, 100); % Sinusoide dont la fr�quence change au cours du temps

% Representation
representation_temp_freq(y, Fe);

%% DFA
[y_init,alpha]=DFA(y);

