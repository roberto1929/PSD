clc; clear; close all;


Ap = 1;         
Ar = 40;        
Omega_p = 1200;
Omega_r = 1000;
Omega_s = 5000;

F = [Omega_p Omega_r]; 
A = [1 0]; 
delta_p = (10^(0.05*Ap) - 1)/(10^(0.05*Ap) + 1); 
delta_r = 10^(-0.05*Ar);                               
ripples = [delta_p delta_r];

[M, Wn, beta, ftype] = kaiserord(F, A, ripples, Omega_s);
w_kaiser = kaiser(M+1, beta);


h = fir1(M, Wn, ftype, w_kaiser, 'noscale');


figure(1)
stem(0:M, h)
xlabel('n'); ylabel('h[n]');
title('Resposta ao Impulso do Filtro FIR com Janela de Kaiser');


[H, w] = freqz(h, 1, 2048, Omega_s);

figure(2)
plot(w, 20*log10(abs(H)))
axis([0 Omega_s/2 -90 10])
xlabel('Frequência (rad/s)');
ylabel('Magnitude (dB)');
title('Resposta em Frequência - Filtro FIR com Janela de Kaiser');
grid on;