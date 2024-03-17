%% Transformata Laplace'a - przykład
syms t s
syms a positive
f = heaviside(t-a)
Fs = laplace(f,t,s)
%% Zadanie 1
syms t s
f = heaviside(t-1)
Fs = laplace(f,t,s)
%% Zadanie 1 - (wykres funkcji Heaviside'a dla a = 1)
ezplot(f, [-2, 3])
%% Zadanie 1 - (wykres transformaty Laplace'a funkcji Heaviside'a dla a = 1)
ezplot(Fs)
%% Transmitancja - przykład
licz = [0 0 1];
mian = [1000 500 400];
%% Transmitancja - przykład c.d. (odpowiedź skokowa dla 'licz' i 'mian')
step(licz,mian)
%% Transmitancja - przykład c.d. (odpowiedź impulsowa dla 'licz' i 'mian')
impulse(licz,mian)
%% Transmitancja - przykład c.d. (zastosowanie funkcji 'tf')
obiekt = tf(licz,mian)
get(obiekt)
%% Transmitancja - przykład c.d. (odpowiedź skokowa dla 'obiekt')
step(obiekt)
%% Transmitancja - przykład c.d. (odpowiedź impulsowa dla 'obiekt')
impulse(obiekt)
%% Transmitancja - przykład c.d. (konwersja transmitancji do reprezentacji zera/bieguny/wzmocnienie)
[z, p, k] = tf2zp(licz,mian)
%% Transmitancja - przykład c.d. (przedstawienie graficzne zer i biegunów - I sposób)
pzmap(p,z)
%% Transmitancja - przykład c.d. (przedstawienie graficzne zer i biegunów - II sposób)
pzmap(licz,mian)
%% Transmitancja - przykład c.d. (przedstawienie graficzne zer i biegunów - III sposób)
pzmap(obiekt)
%% Zadanie 2
%% podpunkt b
licz = [0 0 1];
mian = [1000 500 400];
[z, p, k] = tf2zp(licz,mian)
%% podpunkt c (układ oscylacyjny)
M = 2000;
c = 380;
a = 600;
E = a/(2*sqrt(c*M))
licz = [0 0 1];
mian = [M a c];
obiekt = tf(licz, mian)
%% podpunkt c c.d. (odpowiedź układu na skok jednostkowy w przypadku układu oscylacyjnego)
step(obiekt)
%% podpunkt c c.d. (układ tłumiony)
M = 500;
c = 300;
a = 800;
E = a/(2*sqrt(c*M))
licz = [0 0 1];
mian = [M a c];
obiekt = tf(licz, mian)
%% podpunkt c c.d. (odpowiedź układu na skok jednostkowy w przypadku układu tłumionego)
step(obiekt)
%% Zera, bieguny, wzmocnienie - przykład
[licz, mian] = zp2tf(-1/3, [0 -1 -3], 3)
printsys(licz, mian)
obiekt = zpk(-1/3, [0 -1 -3], 3)
%% Zadanie 3
obiekt = zpk(-1/4, [0 -5 -1/10], 2)
%% Przestrzeń stanów - przykład
M = 1000;
a = 500;
c = 400;
A = [0 1; -c/M -a/M]
B = [0; 1/M]
C = [1 0]
D = 0
obiekt = ss(A, B, C, D)
k = dcgain(A, B, C, D)
%% Przestrzeń stanów - przykład c.d. (odpowiedź skokowa dla argumentu 'obiekt')
step(obiekt)
%% Przestrzeń stanów - przykład c.d. (odpowiedź impulsowa dla argumentu 'obiekt')
impulse(obiekt)
%% Przestrzeń stanów - przykład (odpowiedź skokowa dla argumentów 'A', 'B', 'C', 'D')
step(A, B, C, D)
%% Przestrzeń stanów - przykład (odpowiedź impulsowa dla argumentów 'A', 'B', 'C', 'D')
impulse(A, B, C, D)
%% Zadanie 4 ('zp2ss')
licz = [0 0 1];
mian = [1000 500 400];
[z, p, k] = tf2zp(licz,mian);
[A, B, C, D] = zp2ss(z, p, k)
step(A, B, C, D)
%% Zadanie 4 c.d. ('tf2ss')
[A, B, C, D] = tf2ss(licz, mian)
step(A, B, C, D)
%% Zadanie 5
licz_sys1 = [0 1 1];
mian_sys1 = [1 5 1];
sys1 = tf(licz_sys1, mian_sys1)
licz_sys2 = [0 0 0 1];
mian_sys2 = [1 1 -2 1];
sys2 = tf(licz_sys2, mian_sys2)
sys_series = series(sys1, sys2)
sys_parallel = parallel(sys1, sys2)
sys_feedback = feedback(sys1, sys2)
