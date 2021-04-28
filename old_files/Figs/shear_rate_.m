

close all

figure('Position',[100,100,800,500]);

for i=1:200

    Rs = rand(2,1)*5+1;
    r1 = Rs(1); r2 = Rs(2);
    c1 = r1.^4; c2 = r2.^4;
    N = 5000 ; dc = 1;
    c1s = linspace(c1,c1+N*dc,N+1);
    c2s = linspace(c2,c2+N*dc,N+1);

    p1 = plot(c2s./(c1s+c2s),'-k'); hold on;
    p1.Color(4) = 0.2;
    
end

xlim([0,4000]);

xlabel('Iteration','Interpreter','latex');
ylabel('$\sigma_2 / (\sigma_1 + \sigma_2)$','Interpreter','latex');
set(gca,'TickLabelInterpreter','latex');
set(gca,'fontSize',18);

plot([0,4000],[0.5,0.5],'-r','LineWidth',3)

%%


figure('Position',[100,100,800,500]);

for i=1:200

    Rs = rand(2,1)*5+1;
    r1 = Rs(1); r2 = Rs(2);
    c1 = r1.^4; c2 = r2.^4;
    N = 5000 ; dc = 1;
    c1s = c1; c2s = c2;
    n = 0.25;
    for j = 1:N
        Cmax = max(c1s(end)^n,c2s(end)^n);
        c1s = [c1s,c1s(end) + c1s(end)^n];
        c2s = [c2s,c2s(end) + c2s(end)^n];
    end
    
    p1 = plot(c2s./(c1s+c2s),'-k'); hold on;
    p1.Color(4) = 0.2;
    
end

xlim([0,4000]);

xlabel('Iteration','Interpreter','latex');
ylabel('$\sigma_2 / (\sigma_1 + \sigma_2)$','Interpreter','latex');
set(gca,'TickLabelInterpreter','latex');
set(gca,'fontSize',18);

plot([0,4000],[0.5,0.5],'-r','LineWidth',3)
