subjects = 6;
modules = 5;
A = zeros(modules,modules);
for l = 1:modules
    for jjj = 1:modules
        A(l,jjj) = corr(W(:,1,1),W(:,jjj,l+1));
    end
end

[M, I] = max(A,[],2);
Timing_tot1(:,1) = W(:,1,1);
for ll = 2:6
    Timing_tot1(:,ll) = W(:,I(ll-1),ll);
end
AVG_1 = mean(Timing_tot1,2);
figure(1)
plot(AVG_1, 'LineWidth',4,'Color','k');
hold on
for i = 1:modules
    plot(Timing_tot(:,i), 'Color',[0.5 0.5 0.5])
end
box off
set(gcf,'color','w')
set(gca,'TickDir', 'out','LineWidth',4,'TickDir','out','FontSize',16);
hold off

%% Second one
A2 = zeros(modules,modules);
for lm = 1:modules
    for jjjm = 1:modules
        A2(lm,jjjm) = corr(W(:,2,1),W(:,jjjm,lm+1));
    end
end

[M2, I2] = max(A2,[],2);
Timing_tot2(:,1) = W(:,2,1);
for llm = 2:6
    Timing_tot2(:,llm) = W(:,I2(llm-1),llm);
end
AVG_2 = mean(Timing_tot2,2);

figure(2)
plot(AVG_2, 'LineWidth',4,'Color','k');
hold on
for im = 1:modules
    plot(Timing_tot2(:,im), 'Color',[0.5 0.5 0.5])
end
box off
set(gcf,'color','w')
set(gca,'TickDir', 'out','LineWidth',4,'TickDir','out','FontSize',16);
hold off

%% Third one
A3 = zeros(modules,modules);
for le = 1:modules
    for jjje = 1:modules
        A3(le,jjje) = corr(W(:,3,1),W(:,jjje,le+1));
    end
end

[M3, I3] = max(A3,[],2);
Timing_tot3(:,1) = W(:,3,1);
for lle = 2:6
    Timing_tot3(:,lle) = W(:,I3(lle-1),lle);
end
AVG_3 = mean(Timing_tot3,2);

figure(3)
plot(AVG_3, 'LineWidth',4,'Color','k');
hold on
for ie = 1:modules
    plot(Timing_tot3(:,ie), 'Color',[0.5 0.5 0.5])
end
box off
set(gcf,'color','w')
set(gca,'TickDir', 'out','LineWidth',4,'TickDir','out','FontSize',16);
hold off

%% Fourth module
A4 = zeros(modules,modules);
for l4 = 1:modules
    for jjj4 = 1:modules
        A4(l4,jjj4) = corr(W(:,4,1),W(:,jjj4,l4+1));
    end
end

[M4, I4] = max(A4,[],2);
Timing_tot4(:,1) = W(:,4,1);
for ll4 = 2:6
    Timing_tot4(:,ll4) = W(:,I4(ll4-1),ll4);
end
AVG_4 = mean(Timing_tot4,2);

figure(4)
plot(AVG_4, 'LineWidth',4,'Color','k');
hold on
for i4 = 1:modules
    plot(Timing_tot4(:,i4), 'Color',[0.5 0.5 0.5])
end
box off
set(gcf,'color','w')
set(gca,'TickDir', 'out','LineWidth',4,'TickDir','out','FontSize',16);
hold off

%% Fifth
A5 = zeros(modules,modules);
for l5 = 1:modules
    for jjj5 = 1:modules
        A5(l5,jjj5) = corr(W(:,5,1),W(:,jjj5,l5+1));
    end
end

[M5, I5] = max(A5,[],2);
Timing_tot5(:,1) = W(:,5,1);
for ll5 = 2:6
    Timing_tot5(:,ll5) = W(:,I5(ll5-1),ll5);
end
AVG_5 = mean(Timing_tot5,2);

figure(5)
plot(AVG_5, 'LineWidth',4,'Color','k');
hold on
for i5 = 1:modules
    plot(Timing_tot5(:,i5), 'Color',[0.5 0.5 0.5])
end
box off
set(gcf,'color','w')
set(gca,'TickDir', 'out','LineWidth',4,'TickDir','out','FontSize',16);
hold off
