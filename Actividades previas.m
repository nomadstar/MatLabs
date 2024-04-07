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
disp(r)

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
subplot(3,1,1);
plot(t,m_t);
title('Señal Original');
xlabel('Tiempo (s)');
ylabel('Amplitud');
hold on;

subplot(3,1,2);
plot(t,m_t_nat,'-r');
title('Señal Natural');
xlabel('Tiempo (s)');
ylabel('Amplitud');

subplot(3,1,3);
plot(t,m_t_inst, '-b');
title('Señal Instantánea');
xlabel('Tiempo (s)');
ylabel('Amplitud');

grid on;