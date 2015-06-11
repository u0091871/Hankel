clear all
%close all
clc


load s0471_rem.mat
[ch,samp] = size(val);
signal = val;
clear val

heartbeat = signal(1,55:570);
x = 1:500;
y =sin(x - pi/3).*exp(-0.02*x) + 0.1*sin(0.5*x - pi/3).*exp(-0.002*x) + 2*sin(1.2*x - pi/3).*exp(-0.1*x) ;
figure
plot(y)
%% Step 1: Arrange data points in LxM Hankel Matrix H

N = length(y);
L = round(N/2);
M = N - L + 1;

H = zeros(L,M);

for i = 1:L
    
   H(i,:) = y(i:i+M-1); 
    
end


%% Step 2: Compute the SVD of H

[U,S,V] = svd(H);

%% Step 3
E = zeros(1, (L-1)/2);
for k = 1:(L-1)/2
    U_up = U(2:end,1:k);
    U_down = U(1:end-1,1:k);
    U_tb_k = [U_up U_down];
    [Y, G, W] = svd(U_tb_k);
    sumG = sum(G);
    
    E(k) = 1/k * sum(sumG(k+1:2*k));
end

figure
plot(1./E)