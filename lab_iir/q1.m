% Especificações
wp = 0.2*pi;
ws = 0.3*pi;
Ts = 2;

%frequencias
Omega_p = tan(wp/2);  
Omega_s = tan(ws/2);

% atenuação 
delta_p = 1-0.9;
delta_s = 0.2;
Ap = -20*log10(1-delta_p);
As = -20*log10(delta_s);

epsilon = sqrt((10^(0.1*Ap))-1);
Omega_r_linha = Omega_s / Omega_p;

num = log10((10^(0.1 * As) - 1)/ epsilon^2);
den = (2 * log10(Omega_r_linha));
n = ceil(num/den);

[b_a, a_a] = butter(n, Omega_p, 's');   

fs = 1 / Ts;   
[bz, az] = bilinear(b_a, a_a, fs);

%plot
figure;
freqz(bz, az, 1024);
title('Resposta em frequência do filtro IIR Butterworth (digital)');
xlabel('Frequência Normalizada (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
grid on;