function motors = appendX2motors(x, motors)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    motors.parameters.hip.trunk         = [x(1); x(2)];
    motors.parameters.hip.thigh         = [x(3); x(4)];
    motors.parameters.hip.offset        = x(5);

    motors.parameters.knee.thigh        = [x(6); x(7)];
    motors.parameters.knee.shang        = [x(8); x(9)];
    motors.parameters.knee.offset       = x(10);

    motors.parameters.ankle.shang       = [x(11); x(12)];
    motors.parameters.ankle.foot        = [x(13); x(14)];
    motors.parameters.ankle.offset      = x(15);

    motors.parameters.hip_knee.trunk    = [x(16); x(17)];
    motors.parameters.hip_knee.shang    = [x(18); x(19)];
    motors.parameters.hip_knee.offset   = x(20);


    motors.parameters.knee_ankle.thigh   = [x(21); x(22)];
    motors.parameters.knee_ankle.foot    = [x(23); x(24)];
    motors.parameters.knee_ankle.offset  = x(25);
end

