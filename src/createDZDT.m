function dzdt=createDZDT(z, N, UR, UL, r, L)
% This defines the right hand side of the differential equation model for
% the simple car with two wheels. UR,rt is the control for the right wheel
% and UL,lt is the control for the left wheel

dzdt = [];
for k=1:N
    dzdt = [dzdt;
        (r*(UR(k)+UL(k))/2)*cos(z((k-1)*4+3));
        (r*(UR(k)+UL(k))/2)*sin(z((k-1)*4+3));
        (r*(UR(k)-UL(k))/L);
        0];
end
end