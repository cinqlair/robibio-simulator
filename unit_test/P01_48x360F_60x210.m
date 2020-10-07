close all;
clear all;
clc;

%% Path for Matlab functions
addpath ('../functions/')

L = [0:1:600];
for i=1:size(L,2)

    l=L(i);
    
    F(i) = motor_P01_48x360F_60x210(l,50);
    
end

plot (L, F);
grid on;