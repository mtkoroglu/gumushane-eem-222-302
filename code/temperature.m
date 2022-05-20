clear all; close all; clc;
astar = 3; bstar = 10;
x = [0:0.5:5]';
t = (astar*x + bstar) + (2*rand(length(x),1)-1);

figure(1); set(gcf,'position',[590,188,498,300]);
plot(x,t,'ko','linewidth',1.3);
grid on; set(gca,'gridlinestyle','--');
set(gca,'position',[0.0889 0.1516 0.8900 0.8261]);
xlabel('Zaman (saat)');
ylabel('Sıcaklık (derece)');
axis([x(1) x(end) 0 40]);