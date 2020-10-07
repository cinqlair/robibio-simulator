function [M] = rot_y(alpha)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
M=  [   cos(alpha),     0,  sin(alpha), 0 ;
        0,              1,  0,          0 ;        
        -sin(alpha),    0,  cos(alpha), 0 ;            
        0,              0,  0,          1];
end

