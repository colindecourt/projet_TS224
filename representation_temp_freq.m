function [ ] = representation_temp_freq( x, fe, nb_signal)
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
if nb_signal==1
    title('Repr�sentation du signal EEG(1,2,2) en temps');
elseif nb_signal==2
        title('Repr�sentation du signal EEG(2,1,4) en temps');
elseif nb_signal==3
        title('Repr�sentation d''un bruit blanc gaussien en temps');
else 
    title('Repr�sentation d''un cosinus en temps');
end

xlabel('Temps (s)')
ylabel('Amplitude')

subplot(2,1,2);
Nx = length(x);
nsc = floor(Nx/30); % fen�tre
nov = floor(nsc/4); % noverlap
nff = max(256,2^nextpow2(nsc)); % nfft

spectrogram(x,hamming(nsc),nov,nff, fe, 'yaxis');
%spectrogram(x,hamming(10),nov,nff, fe, 'yaxis');
if nb_signal==1
    title('Repr�sentation du signal  EEG(1,2,2) en temps-fr�quence');
elseif nb_signal==2
        title('Repr�sentation du signal EEG(2,1,4) en temps-fr�quence');
elseif nb_signal==3
        title('Repr�sentation d''un bruit blanc gaussien en temps-fr�quence');
else 
    title('Repr�sentation d''un cosinus en temps-fr�quence');
end

end
    
