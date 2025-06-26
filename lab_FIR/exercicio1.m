% 1.Projete um filtro passa-faixa usando a janela de Hamming, a janela de Hanning e janela de Blackman que
% satisfaça a especificação a seguir.
%
% M = 10, 100, 1000
% • Ωc1 = 10 rad/s
% • Ωc2 = 35 rad/s
% • Ωs = 100 rad/s

clc; clear; close all;

% Especificações
Omega_c1 = 10;
Omega_c2 = 35;
Omega_s = 100;

% Frequências normalizadas
wc1 = (Omega_c1/Omega_s)*pi;
wc2 = (Omega_c2/Omega_s)*pi;

% Parâmetros do filtro
M = 10;
n = 0:M-1;
alpha = (M-1)/2;

% Resposta ao impulso ideal
hd = (sin(wc2*(n - alpha)) - sin(wc1*(n - alpha))) ./ (pi*(n - alpha));
hd(n == alpha) = (wc2 - wc1)/pi;

% Janelas
w_hamming = hamming(M)';
w_hanning = hanning(M)';
w_blackman = blackman(M)';

% Filtros
h_hamming = hd .* w_hamming;
h_hanning = hd .* w_hanning;
h_blackman = hd .* w_blackman;

% Plot Hamming
figure;
freqz(h_hamming, 1, 1024, Omega_s);
axis([0 Omega_s/2 -90 10]);
title('Filtro Passa-Faixa - Janela de Hamming (M = 10)');

% Plot Hanning
figure;
freqz(h_hanning, 1, 1024, Omega_s);
axis([0 Omega_s/2 -90 10]);
title('Filtro Passa-Faixa - Janela de Hanning (M = 10)');

% Plot Blackman
figure;
freqz(h_blackman, 1, 1024, Omega_s);
axis([0 Omega_s/2 -90 10]);
title('Filtro Passa-Faixa - Janela de Blackman (M = 10)');