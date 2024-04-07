A = 1; % Amplitud
fc = 1000; % Frecuencia en Hz
fs = 100000; % Frecuencia de muestreo en Hz
T = 1/fs; % Período de muestreo
duracion = 1/fc; % Duracion de la señal en segundos

% Generar la señal sinusoidal
t = 0:T:duracion-T; % Vector de tiempo
m_t = A * sin(2*pi*fc*t); % Señal sinusoidal

% Modulación por amplitud de pulso (PAM)
pulsos = zeros(1, length(t)); % Inicializar el vector de pulsos
for i = 1:length(t)
    pulsos(i) = m_t(i);

end

% Graficar la señal sinusoidal original y la señal modulada
figure;
subplot(2,1,1);
plot(t, m_t);
title('Señal sinusoidal original');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

subplot(2,1,2);
stem(t, pulsos);
title('Señal modulada por amplitud de pulso');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;