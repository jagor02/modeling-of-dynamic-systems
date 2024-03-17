function d2ydt2 = wahadlo(t, y)
    g = 9.8; % m/s^2
    m = 1;   % kg
    L = 2;   % m
    b = 0.2;
    d2ydt2 = [y(2); -b/m*y(2)-m*g/L/(m-2*b)*sin(y(1))];
end