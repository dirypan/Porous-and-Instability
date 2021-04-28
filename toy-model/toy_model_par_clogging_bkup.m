

close all
figure('Position',[100,100,750,650]);
Q = 10;
N = 500 ;
fs = 10;

alphaS = [1e-3,1,1,10,50,200]*1e-4;


Rmin = 1;
Rmax = 6;
% maxRChange = 1-1e-1;
minR = 0.1;

for n = 0:5
    
    subplot(3,2,n+1)
    
    for i=1:200    
        alpha = alphaS(n+1);
        rs = rand(2,1)*(Rmax-Rmin)+Rmin;
        r1s = rs(1); r2s = rs(2);
        % maxR1change = min(r1s-1e-3,maxRChange);
        % maxR2change = min(r2s-1e-3,maxRChange); 
        
        for j = 1:N
            c1 = r1s(end).^4;
            c2 = r2s(end).^4;
            Q1 = c1/(c1+c2)*Q;
            Q2 = c2/(c1+c2)*Q;
            
            dr1 = r1s(end) - alpha*Q1/r1s(end).^n;
            dr1Cond = (r1s(1)-dr1(end))<maxR1change;              
            dr2 = r2s(end) - alpha*Q2/r2s(end).^n;
            dr2Cond = (r2s(1)-dr2(end))<maxR2change;
            
            r1s = [r1s,dr1*dr1Cond + r1s(end)*(1-dr1Cond)];
            r2s = [r2s,dr2*dr2Cond + r2s(end)*(1-dr2Cond)]; 
            
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