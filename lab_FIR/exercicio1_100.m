clc; clear; close all;

Omega_c1 = 10;
Omega_c2 = 35;
Omega_s = 100;

wc1 = (Omega_c1/Omega_s)*pi;
wc2 = (Omega_c2/Omega_s)*pi;

M = 100;
n = 0:M-1;
alpha = (M-1)/2;

hd = (sin(wc2*(n - alpha)) - sin(wc1*(n - alpha))) ./ (pi*(n - alpha));
hd(n == alpha) = (wc2 - wc1)/pi;

w_hamming = hamming(M)';
w_hanning = hanning(M)';
w_blackman = blackman(M)';

h_hamming = hd .* w_hamming;
h_hanning = hd .* w_hanning;
h_blackman = hd .* w_blackman;

figure;
freqz(h_hamming, 1, 1024, Omega_s);
axis([0 Omega_s/2 -90 10]);
title('Filtro Passa-Faixa - Janela de Hamming (M = 100)');

figure;
freqz(h_hanning, 1, 1024, Omega_s);
axis([0 Omega_s/2 -90 10]);
title('Filtro Passa-Faixa - Janela de Hanning (M = 100)');

figure;
freqz(h_blackman, 1, 1024, Omega_s);
axis([0 Omega_s/2 -90 10]);
title('Filtro Passa-Faixa - Janela de Blackman (M = 100)');