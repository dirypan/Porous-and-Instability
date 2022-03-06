

close all
figure('Position',[100,100,750,650]);
Q = 10;
N = 150 ;
fs = 16;
Order = @(x,n) 1/(n-1)*(n-sum(x.^2).^2./sum(x.^4));

Rmin = 1;
Rmax = 14;
step = 0.1;
minR = 0.01;


for n = 0:5
    
    subplot(3,2,n+1)
    
    for i=1:200    

        rs = rand(10,1)*(Rmax-Rmin)+Rmin;
        
        for j = 1:N
            c = rs(:,end).^4;
            
            q = c./sum(c)*Q;
            
            
            alpha = step./max(q./rs(:,end).^n);
            
            
            dr = rs(:,end) - alpha.*q./rs(:,end).^n;
            
            dr = dr.*(dr>0) + 0.*(dr<=0);

            drCond = dr<=0;
            
            if all(drCond)
                break
            end
                        
            rs = [rs,dr];
        end    

        cs = rs.^4;

        q = cs./sum(cs);

        order = Order(q,10);

        p1 = plot(order,'-k'); hold on;
        p1.Color(4) = 0.2;

    end
    drawnow
    xlim([0,N]);

    xlabel('Iteration','Interpreter','latex');
    ylabel('$\mathcal{O}(q)$','Interpreter','latex');
    set(gca,'TickLabelInterpreter','latex');
    set(gca,'fontSize',fs);
    title(sprintf('$n=%d$',n),'Interpreter','latex');
end
    
