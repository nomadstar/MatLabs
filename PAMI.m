% Parámetros configurables
A = 1; % Amplitud de la señal sinusoidal
fc = 1000; % Frecuencia de la señal sinusoidal en Hz
fs = 100000; % Frecuencia de muestreo en Hz (muestras por segundo)
T = 1/fs; % Período de muestreo
duracion = 0.001; % Duracion de la señal en segundos

% Generar la señal sinusoidal
t = 0:T:duracion-T; % Vector de tiempo
m_t = A * sin(2*pi*fc*t); % Señal sinusoidal
tren = heaviside(square(2 * pi * fc * t*10,20)); % Onda cuadrada con frecuencia fc y ciclo de trabajo d

% Modulación por amplitud de pulso (PAM)
pulsos = zeros(1, length(t)); % Inicializar el vector de pulsos
for i = 1:length(t)
    pulsos(i) = m_t(i)*tren(i);
    
end




% Graficar la señal sinusoidal original y la señal modulada
figure;
subplot(3,1,1);
plot(t, m_t);
title('Señal sinusoidal original');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

subplot(3,1,2);
stem(t,tren);
title('Señal modulada por amplitud de pulso');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

subplot(3,1,3);
stem(t,pulsos);
title('Señal modulada por amplitud de pulso');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;