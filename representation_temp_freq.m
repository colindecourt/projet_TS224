function [ ] = representation_temp_freq( x, fe)
% R�presentation temporelle et temps fr�quence d'un signal 
  % Representation temps-fr�quence permet de voir la richesse fr�quentielle du signal au cours du temps


Te=1/fe; 
N=length(x);


% Axe temporel 
axe_temp=(1:N)*Te;

% Axe fr�quentiel
axe_freq=(0:N-1)*fe/N; 

% Signal en fr�quence
x_freq=abs(fftshift(fft(x))); 

% Repr�sentations
figure
subplot(2,1,1);
plot(axe_temp,x);
title('Repr�sentation du signal en temps');
xlabel('Temps (s)') 
ylabel('Amplitude') 

subplot(2,1,2);
Nx = length(x);
nsc = floor(Nx/10);
nov = floor(nsc/2);
nff = max(256,2^nextpow2(nsc));
spectrogram(x,hamming(nsc),nov,nff, fe, 'yaxis');
title('Repr�sentation du signal en fr�quence');
end

