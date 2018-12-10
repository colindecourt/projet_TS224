function [ ] = representation_temp_freq( x, fe)
% Répresentation temporelle et temps fréquence d'un signal 
  % Representation temps-fréquence permet de voir la richesse fréquentielle du signal au cours du temps


Te=1/fe; 
N=length(x);


% Axe temporel 
axe_temp=(1:N)*Te;

% Axe fréquentiel
axe_freq=(0:N-1)*fe/N; 

% Signal en fréquence
x_freq=abs(fftshift(fft(x))); 

% Représentations
figure
subplot(2,1,1);
plot(axe_temp,x);
title('Représentation du signal en temps');
xlabel('Temps (s)') 
ylabel('Amplitude') 

subplot(2,1,2);
Nx = length(x);
nsc = floor(Nx/10);
nov = floor(nsc/2);
nff = max(256,2^nextpow2(nsc));
spectrogram(x,hamming(nsc),nov,nff, fe, 'yaxis');
title('Représentation du signal en fréquence');
end

