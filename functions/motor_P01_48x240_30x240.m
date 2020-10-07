%% This function compute the force according to the motor lenght
% The origin is at the beginning of the stator 
% Lenght is the length between attachement points in millimeters
% The offset is the distance between the attachement point in millimeters
%
% Force is the maximum available force in Newton
% State is the state of the motor
% 0 : lenght is too short (no force is produced)
% 1 : lenght is in the first ramp (still too short)
% 2 : motor produces its maximum force
% 3 : lenght is in the second ramp (a bit too long)
% 4 : lenght is too long (no force is produced)
%
% Motor documentation: https://shop.linmot.com/E/ag1000.48.240/linear-motors/linear-motors-p01-48/stators-ps01-48x240/ps01-48x240-c.htm
function [Force, State] = motor_P01_48x240_30x240(Length, Offset)
    
    Length = Length + Offset;
    Force=0;
    State=0;
    
    if (Length>=290 && Length<340)
        Force = 2.4180 * Length - 237.1200;
        State = 1;
    end
    
    if (Length>=340 && Length<=430)
        Force = 585;
        State = 2;
    end
    
    if (Length>430 && Length<=505)
        Force = -2.4180 * Length + 1.6247e+03;
        State = 3;
    end
    
    if (Length>505)
        Force=0;
        State=4;
    end
    

end

