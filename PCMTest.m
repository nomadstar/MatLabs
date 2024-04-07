% parametros de configuración
fm = 100000; % Hz
tiempo_muestreo = 1/fm; % segundos
ls = 200; % largo de la señal
f_c = 1000; % Hz

% Hay que ver
f_s = 5000; % Hz
t_s = 1/f_s; % segundos
tau = 0.5*t_s; % segundos
d = tau/t_s; % ciclo de trabajo


% Parametros de la señal
duracion = 1;               % Duracion de la señal en segundos
frec_muestreo = 8;       % Frecuencia de muestreo en Hz
bits_por_muestra = 1
;       % Numero de bits por muestra

 t = (0:ls-1)*tiempo_muestreo;
% t = 0:1/frec_muestreo:duracion-1/frec_muestreo; % Vector de tiempo

% Generación de la señal sinusoidal
m_t = sin(2*pi*f_c*t);


% muestreo instantaneo
m_t_inst = zeros(1,length(t));
r = floor(t_s/tm);
s = floor(tau/tm);
disp(r)
for i=1:length(m_t)
    if mod(i,r)==0
        m_t_inst(i:i+s) = m_t(i);
    end
end

m_t_inst = m_t_inst(1:length(t));

% Cuantificación PCM


% N˙mero de niveles de cuantificación
niveles = 2^bits_por_muestra;

% Cuantificación
pcm_signal_inst = round((m_t_inst + 1) * (niveles - 1) / 2);


% Normaliza las señales para que estÈn en el mismo rango de amplitud (0 a 1)
m_t_norm = (m_t - min(m_t)) / (max(m_t) - min(m_t));
m_t_inst_norm = (m_t_inst - min(m_t_inst)) / (max(m_t_inst) - min(m_t_inst));
pcm_signal_inst_norm = (pcm_signal_inst - min(pcm_signal_inst)) / (max(pcm_signal_inst) - min(pcm_signal_inst));


% Calcular el error de cuantización
error = m_t_inst_norm - pcm_signal_inst_norm;

% Calcular el error cuadrático medio (MSE)
MSE = mean(error.^2);

disp(['El error cuadrático medio (MSE) es: ', num2str(MSE)]);




% Plot de la señal original
subplot(3,1,1);
plot(t, m_t_norm);
title('Señal Original');
xlabel('Tiempo (s)');
ylabel('Amplitud');

% Plot de la señal PAM instantanea
subplot(3,1,2);
plot(t, m_t_inst_norm);
title('Señal PAM instantánea');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

% Plot de la señal PAM instantánea cuantificada
subplot(3,1,3);
stem(t, pcm_signal_inst_norm);
title('Señal PCM Cuantificada');
xlabel('Tiempo (s)');
ylabel('Nivel de cuantificación');
grid on;





% Gráfico del error de cuantización en función del tiempo
figure;
plot(t, error);
title('Error de Cuantización');
xlabel('Tiempo (s)');
ylabel('Error');