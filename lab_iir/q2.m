clc;
clear;

% Frequência de amostragem
fs = 8000;  % Hz
t = 0:1/fs:0.1;  % 100 ms

% Frequências dos sinais
f1 = 770;
f2 = 852;
f3 = 941;

% Sinal composto
x = sin(2*pi*f1*t) + sin(2*pi*f2*t) + sin(2*pi*f3*t);

% ---- Projeto dos filtros ----
% Faixas de passagem (em Hz)
bands = [740 800; 820 880; 910 970];

% Parâmetros
Ap = 1;   % dB
As = 60;  % dB

% Inicialização
y = zeros(3, length(x));

for i = 1:3
    fp = bands(i,:);  % faixa de passagem
    fs1 = fp(1) - 40;  % faixa de rejeição inferior
    fs2 = fp(2) + 40;  % faixa de rejeição superior

    wp = fp / (fs/2);  % normaliza [0,1]
    ws = [fs1 fs2] / (fs/2);

    [n, Wn] = buttord(wp, ws, Ap, As);  % ordem e cutoff
    [b, a] = butter(n, Wn, 'bandpass'); % filtro passa-faixa

    y(i,:) = filter(b, a, x);  % sinal filtrado

    % Visualizar resposta em frequência
    figure;
    freqz(b, a, 1024, fs);
    title(['Filtro Butterworth - ', num2str(fp(1)+30), ' Hz']);
end

% ---- Plot sinais no tempo ----
figure;
plot(t, x);
title('Sinal original composto');
xlabel('Tempo (s)');
ylabel('Amplitude');

for i = 1:3
    figure;
    plot(t, y(i,:));
    title(['Sinal filtrado - ', num2str(bands(i,1)+30), ' Hz']);
    xlabel('Tempo (s)');
    ylabel('Amplitude');
end

% ---- FFT para análise em frequência ----
nfft = 1024;
f = linspace(0, fs/2, nfft/2);

X = abs(fft(x, nfft));
figure;
plot(f, X(1:nfft/2));
title('Espectro do sinal original');
xlabel('Frequência (Hz)');
ylabel('Magnitude');

for i = 1:3
    Y = abs(fft(y(i,:), nfft));
    figure;
    plot(f, Y(1:nfft/2));
    title(['Espectro do sinal filtrado - ', num2str(bands(i,1)+30), ' Hz']);
    xlabel('Frequência (Hz)');
    ylabel('Magnitude');
end