clear all; close all; clc;
R1 = 9; R2 = 4; R3 = 12; Vcc = 12;
A = [1 1 0; 0 -1 1; 0 (1/R1+1/R2+1/R3) 0];
t = [Vcc; 0; Vcc/R1];
x0 = [2; 0.5; 0.5];
n = 80;
x = zeros(3, n+1);
x(:,1) = x0;
L = zeros(1, n+1);
alpha = 0.5;
L(:,1) = 0.5*sum((t-A*x(:,1)).^2);
for i=1:n
    x(:,i+1) = x(:,i) + alpha*A*(t-A*x(:,i));
    L(:,i+1) = 0.5*sum((t-A*x(:,i)).^2);
end
%%
figure(1); clf; set(gcf, 'position', [301 194 805 567], 'color', 'w');
subplot(3,2,1);
plot(0:n, x(1,:), 'k.-');
grid on; set(gca, 'gridlinestyle', '--');
xlabel('iterasyon numarası'); ylabel('x_1');
set(gca, 'position', [0.0502    0.6965    0.4433    0.2750]);
subplot(3,2,2);
plot(0:n, x(2,:), 'r.-');
grid on; set(gca, 'gridlinestyle', '--');
xlabel('iterasyon numarası'); ylabel('x_2')
set(gca, 'position', [0.5551    0.6965    0.4333    0.2750]);
subplot(3,2,3);
plot(0:n, x(3,:), 'b.-');
grid on; set(gca, 'gridlinestyle', '--');
xlabel('iterasyon numarası'); ylabel('x_3');
set(gca, 'position', [0.0502    0.3790    0.4433    0.2750]);
subplot(3,2,4);
hold on;
plot3(x(1,:), x(2,:), x(3,:), 'k.-');
plot3(x(1,1), x(2,1), x(3,1), 'ko', 'markersize', 8, 'markerface', 'r');
plot3(x(1,end), x(2,end), x(3,end), 'ks', 'markersize', 8, 'markerface', 'g');
hold off;
grid on;  set(gca, 'gridlinestyle', '--');
xlabel('x_1');
ylabel('x_2');
zlabel('x_3');
legend('$\mathbf{x}$','$\mathbf{x_0}$', '$\mathbf{x^*}$');
set(legend, 'interpreter', 'latex');
view(3);
set(gca, 'position', [0.5743    0.0723    0.4090    0.5443]);
subplot(3,2,5);
plot(0:n, L, 'k.-');
grid on; set(gca, 'gridlinestyle', '--');
xlabel('iterasyon numarası'); ylabel('L');
set(gca, 'position', [0.0502    0.0703    0.4433    0.2750]);
%% generate gif and mp4 video animations
figure(2); clf; set(gcf, 'position', [301 194 805 567], 'color', 'w');
generateGif = false;
generateVideo = false;
if generateVideo
    v = VideoWriter('circuit_analysis_example_numerical_solution.mp4','MPEG-4');
    v.Quality = 100; v.FrameRate = 10;
    open(v);
end
for i=0:n
    cla;
    subplot(3,2,1);
    plot(0:i, x(1,1:i+1), 'k-');
    grid on; set(gca, 'gridlinestyle', '--');
    xlabel('iterasyon numarası'); ylabel('x_1');
    set(gca, 'position', [0.0502    0.6965    0.4433    0.2750]);
    subplot(3,2,2);
    plot(0:i, x(2,1:i+1), 'r-');
    grid on; set(gca, 'gridlinestyle', '--');
    xlabel('iterasyon numarası'); ylabel('x_2')
    set(gca, 'position', [0.5551    0.6965    0.4333    0.2750]);
    subplot(3,2,3);
    plot(0:i, x(3,1:i+1), 'b-');
    grid on; set(gca, 'gridlinestyle', '--');
    xlabel('iterasyon numarası'); ylabel('x_3');
    set(gca, 'position', [0.0502    0.3790    0.4433    0.2750]);
    subplot(3,2,4);
    hold on;
    plot3(x(1,1:i+1), x(2,1:i+1), x(3,1:i+1), 'k-');
    plot3(x(1,1), x(2,1), x(3,1), 'ko', 'markersize', 8, 'markerface', 'r');
    plot3(x(1,end), x(2,end), x(3,end), 'ks', 'markersize', 8, 'markerface', 'g');
    hold off;
    grid on;  set(gca, 'gridlinestyle', '--');
    xlabel('x_1');
    ylabel('x_2');
    zlabel('x_3');
    legend('$\mathbf{x}$','$\mathbf{x_0}$', '$\mathbf{x^*}$');
    set(legend, 'interpreter', 'latex');
    view(3);
    set(gca, 'position', [0.5743    0.0723    0.4090    0.5443]);
    subplot(3,2,5);
    plot(0:i, L(1:i+1), 'k-');
    grid on; set(gca, 'gridlinestyle', '--');
    xlabel('iterasyon numarası'); ylabel('L');
    set(gca, 'position', [0.0502    0.0703    0.4433    0.2750]);
    % make gif animation
    frame = getframe(gcf);
    img = frame2im(frame);
    if generateGif
        [img, cmap] = rgb2ind(img, 256);
        if i == 0
            imwrite(img, cmap, 'circuit_analysis_example_numerical_solution.gif', 'gif', 'LoopCount', Inf, 'DelayTime', 0);
        else
            imwrite(img, cmap, 'circuit_analysis_example_numerical_solution.gif', 'gif', 'WriteMode', 'append', 'DelayTime', 0);
        end
    end
    if generateVideo
        writeVideo(v, img);
    end
%     pause(0.01);
end
if generateVideo
    close(v);
end