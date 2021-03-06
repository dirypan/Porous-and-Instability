

close all
figure('Position',[100,100,750,650]);
 

%      /|\
% Pl  / | \ pr
%     \ | /
%      \|/

Pl=10;
Pr=1;
N = 150 ;
fs = 16;
Order = @(x,n) 1/(n-1)*(n-sum(x.^2).^2./sum(x.^4));

Rmin = 1;
Rmax = 14;
step = 0.1;


for n = 0:5
    
    subplot(3,2,n+1)
    
    for i=1:200    

        rs = rand(5,1)*(Rmax-Rmin)+Rmin;
        r1s = rs(1); r2s = rs(2);
        r3s = rs(3); r4s = rs(4);
        r5s = rs(5); 
        
        q1s = zeros(N,1);
        q2s = zeros(N,1);
        q3s = zeros(N,1);
        q4s = zeros(N,1);
        q5s = zeros(N,1);
        
        
        for j = 1:N
            c1 = r1s(end).^4;
            c2 = r2s(end).^4;
            c3 = r3s(end).^4;
            c4 = r4s(end).^4;
            c5 = r5s(end).^4;

            
            LHS = [-c1-c3-c4,c3;
                   c3,-c2-c3-c5];
            RHS = [-c1*Pl-c4*Pr;
                   -c2*Pl-c5*Pr];
             

            
            Ps = LHS\RHS;

            P1 = Pl;
            P4 = Pr;
            P2 = Ps(1);
            P3 = Ps(2);            
            
            
            q1 = abs(c1*(P2-P1));
            q2 = abs(c2*(P3-P1));
            q3 = abs(c3*(P3-P2));
            q4 = abs(c4*(P4-P2));
            q5 = abs(c5*(P4-P3));            
            
            q1s(j) = c1*(P2-P1);
            q2s(j) = c2*(P3-P1);
            q3s(j) = c3*(P3-P2);
            q4s(j) = c4*(P4-P2);
            q5s(j) = c5*(P4-P3);            
            
            
            if j==1
                initial_q = c1*(P2-P1) + c2*(P3-P1);
            end
            
            
            
            alpha = step./max([q1./r1s(end).^n,q2./r2s(end).^n,q3./r3s(end).^n,q4./r4s(end).^n,q5./r5s(end).^n]);
            
            
            dr1 = r1s(end) - alpha*q1/r1s(end).^n;            
            dr1Cond = dr1 > minR;              
            dr2 = r2s(end) - alpha*q2/r2s(end).^n;
            dr2Cond = dr2 > minR;
            dr3 = r3s(end) - alpha*q3/r3s(end).^n;            
            dr3Cond = dr3 > minR;              
            dr4 = r4s(end) - alpha*q4/r4s(end).^n;
            dr4Cond = dr4 > minR;
            dr5 = r5s(end) - alpha*q5/r5s(end).^n;            
            dr5Cond = dr5 > minR;                          
            
            if (~dr1Cond & ~dr2Cond) | (~dr4Cond & ~dr5Cond) 
                break
            end
                        
            
            r1s = [r1s,dr1*dr1Cond + 0*(1-dr1Cond)];
            r2s = [r2s,dr2*dr2Cond + 0*(1-dr2Cond)]; 
            r3s = [r3s,dr3*dr3Cond + 0*(1-dr3Cond)];
            r4s = [r4s,dr4*dr4Cond + 0*(1-dr4Cond)]; 
            r5s = [r5s,dr5*dr5Cond + 0*(1-dr5Cond)];

        end    

        
        
        
        q = [q1s,q2s,q3s,q4s,q5s];
        
        init_q = q(:,1)+q(:,2);
        fac = initial_q./init_q;
        
        % order = Order((fac.*q).',length(q));
        order = Order(q.',length(q));
        
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
    
