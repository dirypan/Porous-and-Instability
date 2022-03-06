
close all
figure('Position',[100,100,750,650]);
Q = 10;
N = 1200 ;
fs = 10;

%
%        ---1/C1 ----1/C2---
% ------|                    |----------
%        ---1/C3 ----1/C4----

alphaS = [0.1,1,1,10,50,200];

for n = 0:5
    
    subplot(3,2,n+1)
    
    for i=1:200    
        alpha = alphaS(n+1);
        rs = rand(4,1)*5+1;
        r1s = r1s(1); r2s = rs(2);r3s = rs(3);r4s = rs(4);

        for j = 1:N
            c1 = r1s(end).^4;
            c2 = r2s(end).^4;
            c3 = r3s(end).^4;
            c4 = r4s(end).^4;

            C12 = c1*c2/(c1+c2);
            C34 = c3*c4/(c3+c4);

            
            Q12 = C12/(C12+C34)*Q;
            Q34 = Q-Q12;
            
            r1s = [r1s,r1s(end) + alpha*Q12/r1s(end).^n];
            r2s = [r2s,r2s(end) + alpha*Q12/r2s(end).^n];
            r3s = [r3s,r3s(end) + alpha*Q34/r3s(end).^n];            
            r4s = [r4s,r4s(end) + alpha*Q34/r4s(end).^n];
            
        end    

        c1s = r1s.^4;
        c2s = r2s.^4;
        c3s = r3s.^4;
        c4s = r4s.^4;        

        C12 = c1s.*c2s./(c1s+c2s);
        C34 = c3s.*c4s./(c3s + c4s);
        p1 = plot(C12./(C12+C34),'-k'); hold on;
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