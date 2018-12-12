function [ ] = representation_temp_freq( x, fe, nb_signal)
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
if nb_signal==1
title('Représentation du signal EEG(1,1,1) en temps');
else 
 title('Représentation du signal EEG(1,2,2) en temps');
end
xlabel('Temps (s)') 
ylabel('Amplitude') 

subplot(2,1,2);
Nx = length(x);
nsc = floor(Nx/30); % fenêtre
nov = floor(nsc/2); % noverlap
nff = max(256,2^nextpow2(nsc)); % nfft

spectrogram(x,hamming(nsc),nov,nff, fe, 'yaxis');
%spectrogram(x,hamming(10),nov,nff, fe, 'yaxis');
if nb_signal==1
    title('Représentation du signal  EEG(1,1,1) en temps-fréquence');
else
    title('Représentation du signal  EEG(1,2,2) en temps-fréquence');
end

end

