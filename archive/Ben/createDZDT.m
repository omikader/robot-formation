function dzdt=createDZDT(z, N, UR, UL, r, L)
% This defines the right hand side of the differential equation model for
% the simple car with two wheels. UR,rt is the control for the right wheel
% and UL,lt is the control for the left wheel

dzdt = [];
for i=1:N
    dzdt = [dzdt;
        (r*(UR(i)+UL(i))/2)*cos(z((i-1)*4+3));
        (r*(UR(i)+UL(i))/2)*sin(z((i-1)*4+3));
        (r*(UR(i)-UL(i))/L);
        0];
end
end