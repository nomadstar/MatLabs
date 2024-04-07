% par·metros de configuraciÛn
fm = 100000; % Hz
tiempo_muestreo = 1/fm; % segundos
ls = 200; % largo de la seÒal
f_c = 1000; % Hz

% Hay que ver
f_s = 5000; % Hz
t_s = 1/f_s; % segundos
tau = 0.5*t_s; % segundos
d = tau/t_s; % ciclo de trabajo


% Par·metros de la seÒal
duracion = 1;               % DuraciÛn de la seÒal en segundos
frec_muestreo = 8;       % Frecuencia de muestreo en Hz
bits_por_muestra = 4;       % N˙mero de bits por muestra

 t = (0:ls-1)*tiempo_muestreo;
% t = 0:1/frec_muestreo:duracion-1/frec_muestreo; % Vector de tiempo

% GeneraciÛn de la seÒal sinusoidal
m_t = sin(2*pi*f_c*t);


% muestreo instantaneo
m_t_inst = zeros(1,length(t));
for i=1:length(m_t)
    if mod(i,r)==0
        m_t_inst(i:i+s) = m_t(i);
    end
end

m_t_inst = m_t_inst(1:length(t));

% CuantificaciÛn PCM


% N˙mero de niveles de cuantificaciÛn
niveles = 2^bits_por_muestra;

% CuantificaciÛn
pcm_signal_inst = round((m_t_inst + 1) * (niveles - 1) / 2);


% Normaliza las seÒales para que estÈn en el mismo rango de amplitud (0 a 1)
m_t_norm = (m_t - min(m_t)) / (max(m_t) - min(m_t));
m_t_inst_norm = (m_t_inst - min(m_t_inst)) / (max(m_t_inst) - min(m_t_inst));
pcm_signal_inst_norm = (pcm_signal_inst - min(pcm_signal_inst)) / (max(pcm_signal_inst) - min(pcm_signal_inst));


% Calcular el error de cuantizaciÛn
error = m_t_inst_norm - pcm_signal_inst_norm;

% Calcular el error cuadr·tico medio (MSE)
MSE = mean(error.^2);

disp(['El error cuadr·tico medio (MSE) es: ', num2str(MSE)]);




% Plot de la seÒal original
subplot(3,1,1);
plot(t, m_t_norm);
title('SeÒal Original');
xlabel('Tiempo (s)');
ylabel('Amplitud');

% Plot de la seÒal PAM instant·nea
subplot(3,1,2);
plot(t, m_t_inst_norm);
title('SeÒal PAM instant·nea');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

% Plot de la seÒal PAM instant·nea cuantificada
subplot(3,1,3);
stem(t, pcm_signal_inst_norm);
title('SeÒal PCM Cuantificada');
xlabel('Tiempo (s)');
ylabel('Nivel de cuantificaciÛn');
grid on;





% Gr·fico del error de cuantizaciÛn en funciÛn del tiempo
figure;
plot(t, error);
title('Error de CuantizaciÛn');
xlabel('Tiempo (s)');
ylabel('Error');