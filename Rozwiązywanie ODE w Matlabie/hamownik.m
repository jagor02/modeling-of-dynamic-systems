function Dx = hamownik(t, x)
    h = 42;       %[m]
    m1 = 14000;   %[kg]
    m2 = 450.28;  %[kg]
    m3 = 200;     %[kg]
    k1 = 54700;   %[N/m]
    k2 = 303600;  %[N/m]
    
    % interpolacja
    wezlyF3 = [0 10 20 30 40 50 60 70 80 90 94 98 102 104 107 120];
    wartosciF3 = [833 400 160 320 520 520 660 830 1070 1600 2100 2800 4100 5000 9000 9000];
    funF3 = interp1(wezlyF3, wartosciF3, x(5), 'pchip');
    Fb = funF3*x(6)^2;
    
    % zmienne stanu
    y1 = sqrt(x(1)^2 + h^2) - h;
    sin_theta = x(1)/(h + y1);
    
    if y1 >= 2*x(3)
        Fk1 = k1*(y1 - 2*x(3));
    else
        Fk1 = 0;
    end

    if x(3) >= x(5)
        Fk2 = k2*(x(3) - x(5));
    else
        Fk2 = 0;
    end
    
    dx(1) = x(2);
    dx(2) = -2*Fk1*sin_theta/m1;
    dx(3) = x(4);
    dx(4) = (2*Fk1 - Fk2)/m2;
    dx(5) = x(6);
    dx(6) = (Fk2 - Fb)/m3;

    Dx = [dx(1); dx(2); dx(3); dx(4); dx(5); dx(6)];
end