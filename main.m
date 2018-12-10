clear; close all; clc; dbstop if error;

%% Chargement des donn�es 
load('dataEEG.mat');

%% D�claration des variables
Fe=1000; %Hz
N=1024;
Te=1/Fe;
f0=50; %Hz

%% G�n�ration des signaux

%y=randn(1,1000);

% x=(1:N)*Te;
% y=cos(2*pi*f0*x);

y=cell2mat(dataEEG(1,1,1));
y=y';

%% Repr�sentation des signaux 

representation_temp_freq(y, Fe);

%% DFA

[y_init,alpha]=DFA(y);

