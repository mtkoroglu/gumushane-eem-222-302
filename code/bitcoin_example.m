clear all; close all; clc;
% T = 1/3;
% x = 0:T:10;
roots = [1,3,6,9];
optimal = poly(roots)
% t = (30*rand(1,length(x))-15) + (x-roots(1)).*(x-roots(2)).*(x-roots(3)).*(x-roots(4));

load data.mat
img = imread('./../figure/bitcoin example.jpg');

figure(1); clf; set(gcf,'position',[194 321 929 312],'color','w');
subplot(1,2,1);
plot(x,t,'kx','markersize',7,'linewidth',1.2);
grid on; set(gca, 'gridlinestyle', '--', 'position', [0.06, 0.137, 0.45, 0.83]);
xlabel('Zaman (saat)');
ylabel('Para (bitcoin)');
%% construct A matrix
A = zeros(length(x),5);
for i=1:length(x)
    A(i,:) = [x(i)^4, x(i)^3, x(i)^2, x(i), x(i)^0];
end
%% analytical solution
fprintf('Analitik çözüm\n');
p = (inv(A'*A)*A'*t)' % analytic solution - least squares solution
hold on;
plot(x,p(1)*x.^4+p(2)*x.^3+p(3)*x.^2+p(4)*x+p(5), 'r-', 'linewidth', 1.2);
hold off;
legend('target', 'model çıkışı y');
subplot(1,2,2);
imshow(img);
set(gca,'position',[0.52, 0, 0.48, 1]);
%% MATLAB numerical solution
fun = @(p,x)p(1)*x.^4+p(2)*x.^3+p(3)*x.^2+p(4)*x+p(5);
p0 = 2*rand(5,1)-1;
disp('MATLAB Optimization Toolbox çözümü:');
parameters = (lsqcurvefit(fun, p0, x, t))'
%% our numerical solution
p = p0; % optimal'; % random initial condition
alpha = 0.001;
k=3;
for i=1:k % epoch numarası
    for j=1:length(x) % her bir veriyi tek tek kullanarak ..
        % .. eğim düşümü yöntemi (gradient descent) ile parametreleri güncelleyeceğiz
        y = p(1)*x(j)^4+p(2)*x(j)^3+p(3)*x(j)^2+p(4)*x(j)+p(5);
        p = p + alpha*(t(j)-y)*[x(j)^4, x(j)^3, x(j)^2, x(j), 1]';
%         p(1) = p(1) + alpha*(t(j)-y)*x(j)^4;
%         p(2) = p(2) + alpha*(t(j)-y)*x(j)^3;
%         p(3) = p(3) + alpha*(t(j)-y)*x(j)^2;
%         p(4) = p(4) + alpha*(t(j)-y)*x(j);
%         p(5) = p(5) + alpha*(t(j)-y);
    end
end
fprintf('Kendi eğim düşümü sonucumuz')
p