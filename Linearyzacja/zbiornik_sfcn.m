function [sys, x0, str, ts] = zbiornik_sfcn(t, x, u, flag, V0, T0)
    switch flag
        case 0 % inicjalizacja
            str = [];
            ts = [0 0];
            s = simsizes;
                s.NumContStates = 2; % liczba stanów ciągłych
                s.NumDiscStates = 0; % liczba stanów dyskretnych
                s.NumOutputs = 2; % liczba wyjść
                s.NumInputs = 4; % liczba wejść
                s.DirFeedthrough = 0; % wejście nie przenosi się bezpośrednio na wyjście
                s.NumSampleTimes = 1; % czas próbkowania
            sys = simsizes(s);
            x0 = [V0, T0];
        case 1 % pochodne
            wi = u(1);
            w = u(2);
            Ti = u(3);
            Q = u(4);
            sys = zbiornik_stan(t, x, wi, w, Ti, Q);
        case 3 % wyjście
            sys = x;
        case {2 4 9}
            sys = [];
        otherwise
            error(['unhandled flag =', num2str(flag)]);
    end
end