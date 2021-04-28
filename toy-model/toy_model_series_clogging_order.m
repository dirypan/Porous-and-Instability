

close all
figure('Position',[100,100,750,650]);
dP = 10;
N = 200 ;
fs = 10;
Order = @(x,n) 1/(n-1)*(n-sum(x.^2).^2./sum(x.^4));

Rmin = 1;
Rmax = 14;
step = 0.1;
minR = 0.01;


for n = 0:5
    
    subplot(3,2,n+1)
    
    for i=1:200    
        
        rs = rand(2,1)*(Rmax-Rmin)+Rmin;
        r1s = rs(1); r2s = rs(2);

        
        for j = 1:N
            c1 = r1s(end).^4;
            c2 = r2s(end).^4;
            
            ceq = c1*c2/(c1+c2);
            Q = ceq*dP;
            
            alpha = step/max(Q/r1s(end).^n,Q/r2s(end).^n);
            
            
            dr1 = r1s(end) - alpha*Q/r1s(end).^n;
            dr1Cond = dr1>minR;            
            dr2 = r2s(end) - alpha*Q/r2s(end).^n;
            dr2Cond = dr2>minR;
            
            if ~dr1Cond | ~dr2Cond
                break
            end
            
            r1s = [r1s, dr1];
            r2s = [r2s, dr2];

        end    

        c1s = r1s.^4;
        c2s = r2s.^4;

        q = [c1s./(c1s + c2s); c2s./(c1s + c2s)]; 
        order = Order(q,2);
        
        p1 = plot(order,'-k'); hold on;
        p1.Color(4) = 0.2;

    end
    drawnow
    xlim([0,N]);

    xlabel('Iteration','Interpreter','latex');
    ylabel('$\mathcal{O}(\Delta P) $','Interpreter','latex');
    set(gca,'TickLabelInterpreter','latex');
    set(gca,'fontSize',fs);
    title(sprintf('$n=%d$',n),'Interpreter','latex');
end
    
