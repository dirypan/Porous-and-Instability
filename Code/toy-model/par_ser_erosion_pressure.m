
close all
figure('Position',[100,100,750,650]);
dP = 10;
N = 1200 ;
fs = 10;

% 
%        --------1/C1 -------
% ------|                    |----------
%        ---1/C2 ----1/C3----
% 


alphaS = [0.1,1,1,10,50,200];

for n = 0:5
    
    subplot(3,2,n+1)
    
    for i=1:200    
        alpha = alphaS(n+1);
        rs = rand(2,1)*5+1;
        portion = rand(1,1);
        r1s = rs(1); r2s = rs(2)*portion;r3s = rs(2)*(1-portion);

        for j = 1:N
            c1 = r1s(end).^4;
            c2 = r2s(end).^4;
            c3 = r3s(end).^4;
            
            Q1 = c1*dP;
            Q23 = dP*(c2*c3)/(c2+c3);

            r1s = [r1s,r1s(end) + alpha*Q1/r1s(end).^n];
            r2s = [r2s,r2s(end) + alpha*Q23/r2s(end).^n];
            r3s = [r3s,r3s(end) + alpha*Q23/r3s(end).^n];            
        end    

        c1s = r1s.^4;
        c2s = r2s.^4;
        c3s = r3s.^4;

        p1 = plot(c1s./(c1s+c2s.*c3s./(c2s+c3s)),'-k'); hold on;
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