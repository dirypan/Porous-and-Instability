% toy model - par-series



close all
figure('Position',[100,100,750,650]);
Pl = 1;
Pr = 11;
N = 200 ;

Rmin = 1;
Rmax = 14;
step = 0.1;
minR = 0.01;
fs = 18
Ns = 0:1:5;
Os = zeros(size(Ns));
plotting = true;

for ij  =  1:length(Ns) % different powers of n
    
    n = Ns(ij);
    
    if plotting
        subplot(3,2,n+1)
    end
    
    
    O_n_s = zeros(1000,1);    
    for i=1:1000    % number of simulations
        
        rs = rand(5,1)*(Rmax-Rmin)+Rmin;
        r1s = rs(1); 
        r2s = rs(2);
        r3s = rs(3); 
        r4s = rs(4);
        r5s = rs(5); 
        Pas = [];
        Pbs = [];
        
        Q14s =[];
        order = [];
        
        for j = 1:N % running in steps

            
            Rs = [r1s(end);r2s(end);r3s(end);r4s(end);r5s(end)];
            
            c1 = r1s(end).^4;
            c2 = r2s(end).^4;
            c3 = r3s(end).^4;
            c4 = r4s(end).^4;
            c5 = r5s(end).^4;
            
            LHS = [-c1-c2-c3, c2; c2, -c2-c4-c5];
            RHS = [-c1*Pl-c3*Pr; -c4*Pl-c5*Pr];
            
            Pm = LHS\RHS;
           
            Pa = Pm(1);
            Pb = Pm(2);

            Pas = [Pas,Pa];
            Pbs = [Pbs,Pb];
            
            Cs = [c1;c2;c3;c4;c5];
            dP = [Pa-Pl; Pb-Pa; Pr-Pa; Pb-Pl;Pr-Pb];
            Q = abs(Cs.*dP);         
            
            order = [order, 1/4*( 5 - (sum(Q.^2)^2/sum(Q.^4)))];
            
            
            
            Q14s = [Q14s, Q(1)+Q(4)];
            
            alpha = step./max(Q./Rs.^n);
            
            
            dr1 = r1s(end) - alpha*Q(1)/r1s(end).^n;
            dr2 = r2s(end) - alpha*Q(2)/r2s(end).^n;
            dr3 = r3s(end) - alpha*Q(3)/r3s(end).^n;
            dr4 = r4s(end) - alpha*Q(4)/r4s(end).^n;
            dr5 = r5s(end) - alpha*Q(5)/r5s(end).^n;
            
            dr1Cond = dr1>minR;            
            dr2Cond = dr2>minR;            
            dr3Cond = dr3>minR;            
            dr4Cond = dr4>minR;            
            dr5Cond = dr5>minR;            
            
            if ~dr1Cond | ~dr2Cond | ~dr3Cond | ~dr4Cond | ~dr5Cond | Q14s(end)/Q14s(1)<1e-4
                break
            end
            
            r1s = [r1s, dr1];
            r2s = [r2s, dr2];
            r3s = [r3s, dr3];
            r4s = [r4s, dr4];
            r5s = [r5s, dr5];
            

        end    
        
        O_n_s(i) = order(end)/order(1);
        
        if plotting
            % p1 = plot(Pas,'-r'); hold on;
            % p1.Color(4) = 0.2;
            % p1 = plot(Pbs,'-b'); hold on;        
            % % p1.Color(4) = 0.2;
            p1 = plot(order/order(1),'-k'); hold on;        
            % p1 = plot(order,'-k'); hold on;                    
            p1.Color(4) = 0.2;        
        end
        
    end
    On(ij) = mean(O_n_s);
    
    if plotting
        drawnow
        xlim([0,N]);

        xlabel('Iteration','Interpreter','latex');
        % ylabel('$P_a, P_b$','Interpreter','latex');
        ylabel('$\mathcal{O}$','Interpreter','latex');    
        set(gca,'TickLabelInterpreter','latex');
        set(gca,'fontSize',fs);
        title(sprintf('$n=%d$',n),'Interpreter','latex');
    end
    
end