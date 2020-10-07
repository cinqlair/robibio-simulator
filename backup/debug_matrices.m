close all;
clear all;

P1=[0;0;0;1]
plot (P1(1), P1(1),'.', 'MarkerSize', 20);
grid on; 
hold on;
axis square equal;

M_1_2 = tra_x(2) * rot_z(pi/4);

P2  = M_1_2 * P1;
plot (P2(1), P2(2),'r.', 'MarkerSize', 20);

M_2_3 = tra_x(4)
P4  =  M_1_2 * M_2_3 * P1
plot (P4(1), P4(2),'y.', 'MarkerSize', 20);