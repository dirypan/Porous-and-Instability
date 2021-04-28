

N = 1000;
a = randi([0,1],N,1);
d = randi([0,1],N,1);

g = randi([0,3],N,1);
b = randi([0,3],N,1);

A = a -d + g -b;
B = b-2*g+3*d;
C = g-3*d;
D = d-1/2;




p  = linspace(0,1,100);
figure
for i = 1:N
    p1 = plot(p,A(i)*p.^3+B(i)*p.^2 + C(i)*p + D(i),'-k'); hold on;
    p1.Color(4) = 0.4;
    
end


plot([0,1],[0,0],'--k')
% axis off

