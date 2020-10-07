function [M] = rot_x(alpha)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
M=  [   1,  0,          0,              0 ;
        0,  cos(alpha), -sin(alpha),    0 ;
        0,  sin(alpha), cos(alpha),     0 ;
        0,  0,          0,              1];
end

