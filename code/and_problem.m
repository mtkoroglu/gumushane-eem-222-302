clear all; close all; clc;
x = [0 0; 0 1; 1 0;1 1];
t = [0, 0, 0, 1]';
p = 2*rand(3,1)-1;
alpha = 0.8;
k = 1000
for i=1:k
    for j=1:length(t)
        y = 1 / (1 + exp(-(p'*[x(j,:)'; -1])));
        p = p + alpha*(t(j)-y)*y*(1-y)*[x(j,:)'; -1];
    end
end
for j=1:length(t)
    y(j,1) = 1 / (1 + exp(-(p'*[x(j,:)'; -1])));
end
[x t y]