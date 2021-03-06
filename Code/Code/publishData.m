set(0,'defaultAxesFontSize',10)
fs = 12;
figFolder = '../Figs/publish2d/'
a = 0.2;
T = 12001;
dir = '../Data/Delaunay/100by50T12001d0.2/'
R_c = 15;

%% 
for N = 1:5
    
    subdir = [dir, strcat('N',num2str(N,'%.1f')),strcat('a',num2str(a,'%.1f'))];
    weightPs = [];
    Rs = [];
    for i = 1:12
        graphData = fullfile(subdir,strcat('ST',num2str(i),'.mat'));
        result = isfile(graphData);
        if result
            posData = fullfile(subdir,strcat('configArrayS',num2str(i),'.mat'));
            timeData = fullfile(subdir,strcat('matLargeDataS',num2str(i),'.mat'));
            close all
            load(graphData);
            load(timeData);
            load(posData);

        %     
        %     ave = mean(abs(weightP));
        % %     ave = mean(diameterP);
        %     display(ave);
        %     figure('Position',[100,100,2*300,300])
        %     h = plot(A,'XData',points(2,:),'YData',points(1,:)); %  , 'EdgeLabel', A.Edges.Weight
        % 
        %     % h.EdgeCData= (A.Edges.Weight2 - A.Edges.Weight); %  ave
        %     h.EdgeCData= (weightP)/ave;    
        %     % c_limit = max(abs(max(A.Edges.Weight))/mean(A.Edges.Weight), abs(min(A.Edges.Weight))/mean(A.Edges.Weight));
        %     caxis([-8,8]);
        %     % colorbar;
        %     h.LineWidth= 1;
        %     h.NodeLabel='';
        %     h.Marker='none'
        %     h.EdgeAlpha = 1.0;
        %     colormap(bluewhitered(256));
        %     axis equal
        %     box off
        %     axis off
        %     saveas(gcf,[subdir,'/Figs/','q_',timeData(1:end-4),'.pdf']) % ,'epsc')
        % 
        %  

            close all
            Rave_t = mean(transpose(R_t));
            Rmax_t = max(transpose(R_t));
%             if N==1  
%                 index = find(Rmax_t > 80);
%                 R_c = Rave_t(index(1))
%             else
%                 index = find(Rave_t > R_c);
%             end
            index = find(Rave_t > R_c);
            if ~isempty(index)
                Rs = [Rs R_t(index(1),:)/mean(R_t(index(1),:))];
                weightPi = abs(WeightP_t(index(1),:))/mean(abs(WeightP_t(index(1),:)));
                weightPs = [weightPs weightPi];
            end
        end
    %     if i==2
    %         histogram(abs(weightP)/ave, 50, 'normalization','probability'); %  linspace(0,10,200), max(abs(weightP)/maxflowP*100)
    % %         xlim([0,50]);
    %     else
    %         histogram(abs(weightP)/ave, 50, 'normalization','probability'); %  linspace(0,10,200), max(abs(weightP)/maxflowP*100)
    % %         xlim([0,15]);
    %     end



    end
    figure('Position',[100,100,400,300]);
    histogram(abs(weightPs)/mean(abs(weightPs)), 50, 'normalization','probability');
    set(gca,'yscale','log');
    xlabel('$|q|/\langle q \rangle$','Interpreter','latex','FontSize',fs);
    ylabel('PDF','Interpreter','latex','FontSize',fs+7);

    ylim([10^(-5),10^(0)]);
    yticks(10.^[-5:1:0]);
    yticklabels({'$10^{-5}$','$10^{-4}$','$10^{-3}$','$10^{-2}$','$10^{-1}$','$10^{0}$'});
    set(gca,'TickLabelInterpreter','latex','FontSize',fs);

    saveas(gcf,fullfile(figFolder,strcat('q_N_',num2str(N),'_T_',num2str(T),'.pdf'))); % ,'epsc')
    % mean(diameterP);

    figure('Position',[100,100,400,300]);

    h=histogram(Rs, 100,'Normalization','pdf');    
    %set(gca,'yscale','log')    


    xlabel('$r/\langle r \rangle$','Interpreter','latex','FontSize',fs);
    ylabel('PDF','Interpreter','latex','FontSize',fs+7);

%     ylim([0,]);
%     yticks(10.^[-5:2:0]);
%     yticklabels({' ','$10^{-3}$','$10^{-1}$'});
%     xticks([0:1:5]);
    set(gca,'TickLabelInterpreter','latex','FontSize',fs);
    saveas(gcf,fullfile(figFolder,strcat('R_N_',num2str(N),'_T_',num2str(T),'.pdf'))), % ,'epsc');
end
beep;
%% plot graph
for N =1:5
    close all
    figure('Position',[0,0,2*300,300])
    subdir = fullfile(dir,strcat('N',num2str(N,'%.1f')),strcat('a',num2str(a,'%.1f')));
    graphData = fullfile(subdir,strcat('ST',num2str(1),'.mat'));
    posData = fullfile(subdir,strcat('configArrayS',num2str(1),'.mat'));
    timeData = fullfile(subdir,strcat('matLargeDataS',num2str(1),'.mat'));
    load(timeData);
    load(graphData);
    load(posData);
    A = graph(s,t);
    %ave = mean(abs(A.Edges.Weight));
    h = plot(A,'XData',posArray(:,1),'YData',posArray(:,2)); %
%     axis([0 100 0 50]);
    Rave_t = mean(transpose(R_t));
    index = find(Rave_t > 15);
    weightPi = abs(WeightP_t(index(1),:))/mean(abs(WeightP_t(index(1),:)));
    logWeightPi = log10(0.01+abs(WeightP_t(index(1),:))/mean(abs(WeightP_t(index(1),:))));
    edgeWidth = log(1+R_t(index(1),:)/mean(R_t(index(1),:)));
    h.EdgeCData= weightPi;  

    % caxis([min(weightPi),max(weightPi)])
    caxis([0,10])
%     h.LineWidth= R_t(index(1),:)/mean(R_t(index(1),:));
%     h.LineWidth= 1.0;
    h.LineWidth = edgeWidth;
    h.NodeLabel='';
    h.Marker='none';
    h.EdgeAlpha = 1.0;
    J = customcolormap_preset("white-blue-red");
    colormap(J);
    set(colorbar,'position',[0.88 .17 .03 .7])
    axis equal
    box off
    axis off
    saveas(gcf,fullfile(figFolder,strcat('G_N_',num2str(N),'_T_',num2str(T),'.pdf'))) % ,'epsc');
end
beep;

%% plot t = 0 graph network
N=1;
a=0.2;
% dir = fullfile("E:","TempCode","MatlabFlow","matData","erosion","VoronoiNet",strcat("20by12by12T",num2str(T)));
figure('Position',[0,0,2*300,300])
subdir = fullfile(dir,strcat('N',num2str(N,'%.1f')),strcat('a',num2str(a,'%.1f')));
graphData = fullfile(subdir,strcat('ST',num2str(1),'.mat'));
posData = fullfile(subdir,strcat('configArrayS',num2str(1),'.mat'));
timeData = fullfile(subdir,strcat('matLargeDataS',num2str(1),'.mat'));
load(timeData);
load(graphData);
load(posData);
A = graph(s,t);
%ave = mean(abs(A.Edges.Weight));
h = plot(A,'XData',posArray(:,1),'YData',posArray(:,2)); %
%     axis([0 100 0 50]);
Rave_t = mean(transpose(R_t));
index = find(Rave_t > 7.5);
weightPi = abs(WeightP_t(index(1),:))/mean(abs(WeightP_t(index(1),:)));
logWeightPi = log10(0.01+abs(WeightP_t(index(1),:))/mean(abs(WeightP_t(index(1),:))));
edgeWidth = log(1+R_t(index(1),:)/mean(R_t(index(1),:)));
h.EdgeCData= weightPi;  

caxis([0,10])
%     h.LineWidth= R_t(index(1),:)/mean(R_t(index(1),:));
%     h.LineWidth= 1.0;
h.LineWidth = edgeWidth;
h.NodeLabel='';
h.Marker='none';
h.EdgeAlpha = 1.0;
J = customcolormap_preset("white-blue-red");
colormap(J);
set(colorbar,'position',[0.88 .17 .03 .7])
axis equal
box off
axis off
saveas(gcf,fullfile(figFolder,strcat('G_','initial.pdf'))) % ,'epsc');


%% Plot initial hist
T=12001;
N=1;
a=0.2;
% dir = fullfile("E:","TempCode","MatlabFlow","matData","erosion","VoronoiNet",strcat("20by12by12T",num2str(T)));
% dir = fullfile("E:","TempCode","MatlabFlow","matData","erosion","VoronoiNet",strcat("20by12by12T",num2str(T)));
subdir = fullfile(dir,strcat('N',num2str(N,'%.1f')),strcat('a',num2str(a,'%.1f')));
graphData = fullfile(subdir,strcat('ST',num2str(1),'.mat'));
posData = fullfile(subdir,strcat('configArrayS',num2str(1),'.mat'));
timeData = fullfile(subdir,strcat('matLargeDataS',num2str(1),'.mat'));
% figFolder = fullfile("E:","TempCode","MatlabFlow","Figs","Voro3d");

weightPs = [];
Rs = [];
for i = 1:12
    graphData = fullfile(subdir,strcat('ST',num2str(i),'.mat'));
    result = isfile(graphData);
    if result
        posData = fullfile(subdir,strcat('configArrayS',num2str(i),'.mat'));
        timeData = fullfile(subdir,strcat('matLargeDataS',num2str(i),'.mat'));
        close all
        load(graphData);
        load(timeData);
        load(posData);

    %     
    %     ave = mean(abs(weightP));
    % %     ave = mean(diameterP);
    %     display(ave);
    %     figure('Position',[100,100,2*300,300])
    %     h = plot(A,'XData',points(2,:),'YData',points(1,:)); %  , 'EdgeLabel', A.Edges.Weight
    % 
    %     % h.EdgeCData= (A.Edges.Weight2 - A.Edges.Weight); %  ave
    %     h.EdgeCData= (weightP)/ave;    
    %     % c_limit = max(abs(max(A.Edges.Weight))/mean(A.Edges.Weight), abs(min(A.Edges.Weight))/mean(A.Edges.Weight));
    %     caxis([-8,8]);
    %     % colorbar;
    %     h.LineWidth= 1;
    %     h.NodeLabel='';
    %     h.Marker='none'
    %     h.EdgeAlpha = 1.0;
    %     colormap(bluewhitered(256));
    %     axis equal
    %     box off
    %     axis off
    %     saveas(gcf,[subdir,'/Figs/','q_',timeData(1:end-4),'.pdf']) % ,'epsc')
    % 
    %  

        close all
        Rave_t = mean(transpose(R_t));
%         index = find(Rave_t > 10);
%         index = index(1);
%         index = 125;
        index = 1;
        if ~isempty(index)
            Rs = [Rs R_t(index,:)/mean(R_t(index,:))];
            weightPi = abs(WeightP_t(index,:))/mean(abs(WeightP_t(index,:)));
            weightPs = [weightPs weightPi];
        end
    end
%     if i==2
%         histogram(abs(weightP)/ave, 50, 'normalization','probability'); %  linspace(0,10,200), max(abs(weightP)/maxflowP*100)
% %         xlim([0,50]);
%     else
%         histogram(abs(weightP)/ave, 50, 'normalization','probability'); %  linspace(0,10,200), max(abs(weightP)/maxflowP*100)
% %         xlim([0,15]);
%     end



end
figure('Position',[0,0,400,300]);
histogram(abs(weightPs)/mean(abs(weightPs)), 50, 'normalization','probability');
set(gca,'yscale','log');
xlabel('$|q|/\langle q \rangle$','Interpreter','latex','FontSize',fs);
ylabel('PDF','Interpreter','latex','FontSize',fs+7);

ylim([10^(-5),10^(0)]);
yticks(10.^[-5:1:0]);
yticklabels({'$10^{-5}$','$10^{-4}$','$10^{-3}$','$10^{-2}$','$10^{-1}$','$10^{0}$'});
set(gca,'TickLabelInterpreter','latex','FontSize',fs);

saveas(gcf,fullfile(figFolder,strcat('Q_','initial.pdf'))); % ,'epsc')
% mean(diameterP);

figure('Position',[100,100,400,300]);

histogram(Rs/mean(Rs), 100 ,'Normalization','pdf')    
set(gca,'yscale','log')    


xlabel('$r/\langle r\rangle $','Interpreter','latex','FontSize',fs);
ylabel('PDF','Interpreter','latex','FontSize',fs+7);

ylim([10^(-5),1]);
yticks(10.^[-5:2:0]);
yticklabels({'$10^{-5}$ ','$10^{-3}$','$10^{-1}$'});
% xticks([0:1:5]);
set(gca,'TickLabelInterpreter','latex','FontSize',fs);
saveas(gcf,fullfile(figFolder,strcat('R_','initial.pdf'))), % ,'epsc');
