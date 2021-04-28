

close all
figure('Position',[100,100,750,650]);
Q = 10;
N = 1200 ;
fs = 10;

alphaS = [0.1,1,1,10,50,200];

for n = 0:5
    
    subplot(3,2,n+1)
    
    for i=1:200    
        alpha = alphaS(n+1);
        rs = rand(3,1)*5+1;
        r1s = rs(1); r2s = rs(2);r3s = rs(3);

        for j = 1:N
            c1 = r1s(end).^4;
            c2 = r2s(end).^4;
            Q1 = c1/(c1+c2)*Q;
            Q2 = c2/(c1+c2)*Q;
            r1s = [r1s,r1s(end) + alpha*Q1/r1s(end).^n];
            r2s = [r2s,r2s(end) + alpha*Q2/r2s(end).^n];
        end    

        c1s = r1s.^4;
        c2s = r2s.^4;

        p1 = plot(c1s./(c1s+c2s),'-k'); hold on;
        p1.Color(4) = 0.2;

    end
    drawnow
    xlim([0,N]);

    xlabel('Iteration','Interpreter','latex');
    ylabel('$Q_1 / Q$','Interpreter','latex');
    set(gca,'TickLabelInterpreter','latex');
    set(gca,'fontSize',fs);
    title(sprintf('$n=%d$',n),'Interpreter','latex');
end
    
% plot([0,4000],[1/3,1/3],'-r','LineWidth',3)