function status = hamownik_out(t ,x, flag)
    global w3

    h = 42;       %[m]
    k1 = 54.7e3;  %[N/m]
    m1 = 14000;   %[kg]
    
    if strcmp(flag, 'init')
        w3 = 0;
    elseif isempty(flag)
        y1 = sqrt(x(1)^2+h^2)-h;
        sin_alfa = x(1)/(h+y1);
        
        if y1 >= 2*x(3)
            Fk1 = k1*(y1-2*x(3));
        else
            Fk1 = 0;
        end
        
        w3 = [w3; -2*Fk1*sin_alfa/m1];
    end
    
    status = 0;
end