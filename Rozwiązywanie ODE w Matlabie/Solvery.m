%% zadanie 1 - metoda Eulera
clear all; close all;

figure;
fplot(@(t) t.^2, [0 3]);
hold on;

N = 3;

for h = [1 0.5 0.25 0.125]
    t = 0:h:N;
    y(1) = 0;
    for i = 1:N/h
        dy = 2*t(i);
        y(i+1) = y(i) + dy*h;
    end
    plot(t, y, '-o');
end

title('Rozwiązanie równania y''=2t metodą Eulera');
xlabel('t'); ylabel('y(t)');
legend('analitycznie', 'h=1', 'h=0.5', 'h=0.25', 'h=0.125', 'Location', 'northwest');
hold off;

%% wahadło
clear all; close all;

opts = odeset('stats', 'on');
tspan = [0 25];
y0 = [pi/4, 0];

[t, y] = ode45(@wahadlo, tspan, y0, opts);

figure;
plot(t, y(:, 1), t, y(:, 2));
legend('\theta', '\theta''');

%% zadanie 2
clear all; close all;

N = 3;

opts = odeset('stats', 'on');
tspan = [0 N];
y0 = 0;
fun = @(t, y) 2*t;

[t, y] = ode45(fun, tspan, y0, opts);

figure;
plot(t, y);
title('Rozwiązanie równania y''=2t metodą Eulera - solver ode45');
xlabel('t'); ylabel('y(t)');

%% zadanie 3
clear all; close all;

global w3;

options = odeset('OutputFcn', @hamownik_out, 'Refine', 1);
[T, Y] = ode45(@hamownik, [0 20], [0 67 0 0 0 0], options);

figure;
subplot(2, 1, 1);
plot(T, Y(:, 1), 'b');
hold on;
plot(T, Y(:, 2), 'y');
xlabel('t');
grid on;
legend('droga', 'prędkość');
hold off;

subplot(2, 1, 2);
plot(T, w3, 'r');
xlabel('t');
grid on;
legend('przyspieszenie');
