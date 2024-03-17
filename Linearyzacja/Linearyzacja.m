%% Model nieliniowy (I)
Q = 12000;
w = 0.4;
wi = 0.4;
Ti = 293;
T0 = 293;
V0 = 0.04;

[t, x] = ode45(@zbiornik_stan, [0:799], [V0, T0], [], wi, w, Ti, Q);

figure;
subplot(2, 1, 1);
plot(t, x(:, 1));
ylim([0 0.05]);
title("Charakterystyka objętości cieczy w zbiorniku w dziedzinie czasu");
xlabel("Czas [s]"); ylabel("Objętość cieczy w zbiorniku [m^3]");
grid on;
subplot(2, 1, 2);
plot(t, x(:, 2));
ylim([290 305]);
title("Charakterystyka temperatury cieczy w zbiorniku w dziedzinie czasu");
xlabel("Czas [s]"); ylabel("Temperatura cieczy [K]");
grid on;

%% Model nieliniowy (II)
Q = 10000;
w = 0.3;
wi = 0.5;
Ti = 290;
T0 = 290;
V0 = 0.04;

[t, x] = ode45(@zbiornik_stan, [0:799], [V0, T0], [], wi, w, Ti, Q);

figure;
subplot(2, 1, 1);
plot(t, x(:, 1));
ylim([0 0.25]);
title("Charakterystyka objętości cieczy w zbiorniku w dziedzinie czasu (wi > w)");
xlabel("Czas [s]"); ylabel("Objętość cieczy w zbiorniku [m^3]");
grid on;
subplot(2, 1, 2);
plot(t, x(:, 2));
ylim([289 295]);
title("Charakterystyka temperatury cieczy w zbiorniku w dziedzinie czasu (wi > w)");
xlabel("Czas [s]"); ylabel("Temperatura cieczy [K]");
grid on;

%% Model nieliniowy (III)
Q = 10000;
w = 0.5;
wi = 0.3;
Ti = 290;
T0 = 290;
V0 = 0.2;

[t, x] = ode45(@zbiornik_stan, [0:799], [V0, T0], [], wi, w, Ti, Q);

figure;
subplot(2, 1, 1);
plot(t, x(:, 1));
ylim([0 0.25]);
title("Charakterystyka objętości cieczy w zbiorniku w dziedzinie czasu (wi < w)");
xlabel("Czas [s]"); ylabel("Objętość cieczy w zbiorniku [m^3]");
grid on;
subplot(2, 1, 2);
plot(t, x(:, 2));
ylim([288 298]);
title("Charakterystyka temperatury cieczy w zbiorniku w dziedzinie czasu (wi < w)");
xlabel("Czas [s]"); ylabel("Temperatura cieczy [K]");
grid on;

%% Stan ustalony (I)
V0 = 0.04;
T0 = 293;

X0 = [0.04; 303];
U0 = [0.4; 0.4; 293; 12000];
Y0 = [0.04; 303];

IX = [];
IU = [1; 2; 3];
IY = [1; 2];

[x, u, y, dx] = trim('zbiornik_sys', X0, U0, Y0, IX, IU, IY)

[t_, x_] = ode45(@zbiornik_stan, [0:799], [V0, T0], [], u(1), u(2), u(3), u(4));

figure;
subplot(2, 1, 1);
plot(t_, x_(:, 1));
title("Charakterystyka objętości cieczy w zbiorniku w dziedzinie czasu (w stanie ustalonym)");
xlabel("Czas [s]"); ylabel("Objętość cieczy w zbiorniku [m^3]");
grid on;
subplot(2, 1, 2);
plot(t_, x_(:, 2));
ylim([290 305]);
title("Charakterystyka temperatury cieczy w zbiorniku w dziedzinie czasu (w stanie ustalonym)");
xlabel("Czas [s]"); ylabel("Temperatura cieczy [K]");
grid on;

%% Stan ustalony (II)
V0 = 0.04;
T0 = 293;

X0 = [0.04; 303];
U0 = [0.3; 0.5; 293; 12000];
Y0 = [0.04; 303];

IX = [];
IU = [1; 2; 3];
IY = [1; 2];

[x, u, y, dx] = trim('zbiornik_sys', X0, U0, Y0, IX, IU, IY)

[t_, x_] = ode45(@zbiornik_stan, [0:799], [V0, T0], [], u(1), u(2), u(3), u(4));

figure;
subplot(2, 1, 1);
plot(t_, x_(:, 1));
title("Charakterystyka objętości cieczy w zbiorniku w dziedzinie czasu (w stanie ustalonym) (w = 0.5, wi = 0.3, Ti = 293, Q = 12000)");
xlabel("Czas [s]"); ylabel("Objętość cieczy w zbiorniku [m^3]");
grid on;
subplot(2, 1, 2);
plot(t_, x_(:, 2));
ylim([290 305]);
title("Charakterystyka temperatury cieczy w zbiorniku w dziedzinie czasu (w stanie ustalonym) (w = 0.5, wi = 0.3, Ti = 293, Q = 12000)");
xlabel("Czas [s]"); ylabel("Temperatura cieczy [K]");
grid on;

%% Model liniowy
V0 = 0.04;
T0 = 293;

X0 = [0.04; 303];
U0 = [0.4; 0.4; 293; 12000];
Y0 = [0.04; 303];

IX = [];
IU = [1; 2; 3];
IY = [1; 2];

[x, u, y, dx] = trim('zbiornik_sys', X0, U0, Y0, IX, IU, IY);

[A, B, C, D] = linmod('zbiornik_sys', x, u);

for iu = 1:4
    [licz, mian] = ss2tf(A, B, C, D, iu);
    
    printsys(licz, mian);
end

t = 0:799;
U = zeros(length(t), length(u));
X_pocz = [0.04 293];
X_ust = [0.04 303];
x0 = X_pocz - X_ust;

y_ = lsim(A, B, C, D, U, t, x0);

figure;
subplot(2, 1, 1);
plot(t, y_(:,1) + X_ust(1));
ylim([0 0.06]);
title('Model liniowy');
xlabel('Objętość');
grid on;
subplot(2, 1, 2);
plot(t, y_(:,2) + X_ust(2));
ylim([292 302]);
xlabel('Temperatura');
grid on;

%% Porównanie układu nieliniowego i układu liniowego w stanie ustalonym
Q = 12000;
w = 0.4;
wi = 0.4;
Ti = 293;

T0 = 293;
V0 = 0.04;

% układ nieliniowy
[t, x] = ode45(@zbiornik_stan, [0:799], [V0, T0], [], wi, w, Ti, Q);

X0 = [0.04; 303];
U0 = [0.4; 0.4; 293; 12000];
Y0 = [0.04; 303];

IX = [];
IU = [1; 2; 3];
IY = [1; 2];

[x_, u_, y_, dx_] = trim('zbiornik_sys', X0, U0, Y0, IX, IU, IY);

[A, B, C, D] = linmod('zbiornik_sys', x_, u_);

U = zeros(length(t), length(u_));
X_pocz = [0.04 293];
X_ust = [0.04 303];
x0 = X_pocz - X_ust;

% układ liniowy w stanie ustalonym
y__ = lsim(A, B, C, D, U, t, x0);

% błąd linearyzacji
Y = x(:, 2) - (y__(:, 2) + X_ust(2));

figure;
subplot(3, 1, 1);
plot(t, x(:, 2));
ylim([290 305]);
title("Charakterystyka temperatury cieczy w zbiorniku w dziedzinie czasu (model nieliniowy)");
xlabel("Czas [s]"); ylabel("Temperatura cieczy [K]");
grid on;
subplot(3, 1, 2);
plot(t, y__(:, 2) + X_ust(2));
ylim([290 305]);
title("Charakterystyka temperatury cieczy w zbiorniku w dziedzinie czasu" + ...
    "(model liniowy w stanie ustalonym)");
xlabel("Czas [s]"); ylabel("Temperatura cieczy [K]");
grid on;
subplot(3, 1, 3);
plot(t, Y);
ylim([-2 4]);
title("Błąd linearyzacji");
xlabel("Czas [s]"); ylabel("Temperatura cieczy [K]");
grid on;

%% Stan nieustalony
Q = 12000;
w = 0.4;
wi = 0.5;
Ti = 293;

T0 = 293;
V0 = 0.04;

% układ nieliniowy
[t, x] = ode45(@zbiornik_stan, [0:799], [V0, T0], [], wi, w, Ti, Q);

X0 = [0.04; 303];
U0 = [0.5; 0.4; 293; 12000];
Y0 = [0.04; 303];

IX = [];
IU = [1; 2; 3];
IY = [1; 2];

[x_, u_, y_, dx_] = trim('zbiornik_sys', X0, U0, Y0, IX, IU, IY);

[A, B, C, D] = linmod('zbiornik_sys', x_, u_);

U = zeros(length(t), length(u_));
X_pocz = [0.04 293];
X_ust = [0.04 303];
x0 = X_pocz - X_ust;

% układ liniowy
y__ = lsim(A, B, C, D, U, t, x0);

% błąd linearyzacji
Y = x(:, 2) - (y__(:, 2) + X_ust(2));

figure;
subplot(3, 1, 1);
plot(t, x(:, 2));
ylim([290 305]);
title("Charakterystyka temperatury cieczy w zbiorniku w dziedzinie czasu" + ...
    "(model nieliniowy) - stan nieustalony");
xlabel("Czas [s]"); ylabel("Temperatura cieczy [K]");
grid on;
subplot(3, 1, 2);
plot(t, y__(:, 2) + X_ust(2));
ylim([290 305]);
title("Charakterystyka temperatury cieczy w zbiorniku w dziedzinie czasu" + ...
    "(model liniowy) - stan nieustalony");
xlabel("Czas [s]"); ylabel("Temperatura cieczy [K]");
grid on;
subplot(3, 1, 3);
plot(t, Y);
ylim([-4 4]);
title("Błąd linearyzacji - stan nieustalony");
xlabel("Czas [s]"); ylabel("Temperatura cieczy [K]");
grid on;
