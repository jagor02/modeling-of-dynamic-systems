clear all;
close all;

N = 10000;
h = 0.1;
Q_max = 25000;
w_ust = 0.4;
T_i = 293;
T_ust = 303;
V_ust = 0.04;
C = 4200;
rho = 1000;

Q_ust = -C*w_ust*(T_i - T_ust);

t = 0:h:N*h;

T(1) = T_i;
for i = 1:N
    dT = (w_ust*(T_i - T(i)) + Q_ust/C)/(V_ust*rho);
    T(i+1) = T(i) + dT*h;
end

figure;

subplot(4, 1, 1);
plot(t, ones(1, length(t))*V_ust);
ylim([0 0.1]);
title('objętość');
xlabel('s'); ylabel('m^3');

subplot(4, 1, 2:4);
plot(t, T);
ylim([292 304]);
title('temperatura');
xlabel('s'); ylabel('[K]');

X = ones(1, floor(N/5));

figure;

hold on;
for w = [0.4, 0.5, 0.6]
    Q_ust = -C*w*(T_i - T_ust);
    Q = [Q_ust, Q_ust*X, 0.5*Q_ust*X, Q_ust*X, 1.5*Q_ust*X, Q_ust*X];
    plot(t, Q);
end
title('Moc grzałki');
xlabel('Czas [s]'); ylabel('Moc [W]');
grid on;
legend('w = wi = 0.4', 'w = wi = 0.5', 'w = wi = 0.6', Location='northwest');

figure;

hold on;
Tw(1) = T_i;
for w = [0.4, 0.5, 0.6]
    Q_ust = -C*w*(T_i - T_ust);
    Q = [Q_ust, Q_ust*X, 0.5*Q_ust*X, Q_ust*X, 1.5*Q_ust*X, Q_ust*X];
    for i = 1:N
        dTw = (w*(T_i - Tw(i)) + Q(i)/C)/(V_ust*rho);
        Tw(i+1) = Tw(i) + dTw*h;
    end
    plot(t, Tw)
end
ylim([290 310]);
yticks(290:5:310);
title('Temperatura cieczy w zbiorniku dla stałej objętości');
xlabel('Czas [s]'); ylabel('Temperatura [K]');
grid on;
legend('w = wi = 0.4, V = 0.04', 'w = wi = 0.5, V = 0.04', 'w = wi = 0.6, V = 0.04', Location='northwest');
hold off;

Q_ust = -C*w_ust*(T_i - T_ust);
Q = [Q_ust, Q_ust*X, 0.5*Q_ust*X, Q_ust*X, 1.5*Q_ust*X, Q_ust*X];

figure;

subplot(4, 1, 1);
plot(t, Q);
ylim([0 30000]);
title('Moc grzałki');
xlabel('Czas [s]'); ylabel('Moc [W]');
grid on;

subplot(4, 1, 2:4);
hold on;
TV(1) = T_i;
for V = [0.04, 0.06, 0.08]
    for i = 1:N
        dTV = (w_ust*(T_i - TV(i)) + Q(i)/C)/(V*rho);
        TV(i+1) = TV(i) + dTV*h;
    end
    plot(t, TV)
end
ylim ([290 310]);
yticks(290:5:310);
title('Temperatura cieczy w zbiorniku dla stałego przepływu');
xlabel('Czas [s]'); ylabel('Temperatura [K]');
grid on;
legend('w = wi = 0.4, V = 0.04', 'w = wi = 0.4, V = 0.06', 'w = wi = 0.4, V = 0.08', Location='northwest');
hold off;
