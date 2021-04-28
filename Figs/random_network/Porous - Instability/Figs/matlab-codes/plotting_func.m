
clear all
close all
fs = 19;
gamma  = 1;
n = 3;

[x,y] = meshgrid(linspace(0,10,100),linspace(0,10,100));

% contour(x.^((n-3)/(n+1)) - y.^((n-3)/(n+1)),[gamma/2,gamma,2*gamma])

contour(x.^((n-3)/(n+1)) - y.^((n-3)/(n+1)),[-0.5:.1:0.5])



xlabel('$r^{n+1}_1$','Interpreter','latex');
ylabel('$r^{n+1}_2$','Interpreter','latex');
set(gca,'TickLabelInterpreter','latex');
set(gca,'fontSize',fs);
title(sprintf('$n=%d$',n),'Interpreter','latex');