clc;
close all;
clear all;

% parámetros de configuración
fm = 100000; % Hz
tm = 1/fm; % segundos
ls = 200; % largo de la señal
f_c = 1000; % Hz
f_s = 5000; % Hz
t_s = 1/f_s; % segundos
tau = 0.5*t_s; % segundos
d = tau/t_s; % ciclo de trabajo

% vectores
t = (0:ls-1)*tm;
m_t = sin(2*pi*f_c*t);

% auxiliaries
r = floor(t_s/tm);
s = floor(tau/tm);

% muestreo natural
s_nat = zeros(1,length(t));
for i=1:length(m_t)
    if mod(i,r)==0
        s_nat(i:i+s) = 1;
    end
end
s_nat = s_nat(1:length(t));
m_t_nat = m_t.*s_nat;

% muestreo instantaneo
m_t_inst = zeros(1,length(t));
for i=1:length(m_t)
    if mod(i,r)==0
        m_t_inst(i:i+s) = m_t(i);
    end
end




% muestreo natural
s_nat = zeros(1,length(t));
for i=1:length(m_t)
if mod(i,r)==0
s_nat(i:i+s) = 1;
end
end
s_nat = s_nat(1:length(t));
m_t_nat = m_t.*s_nat;

% muestreo instantaneo
m_t_inst = zeros(1,length(t));
for i=1:length(m_t)
if mod(i,r)==0
m_t_inst(i:i+s) = m_t(i);
end
end

m_t_inst = m_t_inst(1:length(t));

% Senales de Furier
F = fft(m_t);
FNat = fft(m_t_nat);
FInts = fft(m_t_inst);

subplot(4,1,1);
plot(t,m_t);
title('Señal en el dominio del tiempo');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

subplot(4,1,2);
plot(t, abs(F));
title('Espectro de magnitud de frecuencia');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud');
grid on;

subplot(4,1,3);
plot(t, abs(FNat));
title('Furier PAM Natural');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud');
grid on;

subplot(4,1,4);
plot(t, abs(FInts));
title('Furier PAM instantanea');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud');
grid on;
