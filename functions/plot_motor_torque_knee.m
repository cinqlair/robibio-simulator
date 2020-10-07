function nPlots = plot_motor_torque_knee(motors, dataset)

    
    hold on; grid on;
    lgd ={};
    if (motors.enable.knee)
        plot (motors.max_torque.knee.left, 'r');
        plot (motors.max_torque.knee.right, 'b');
        lgd{end+1} = 'Torque mono-articular left';
        lgd{end+1} = 'Torque mono-articular right';
        
    end
    
    if (motors.enable.hip_knee)
        plot (motors.max_torque.hip_knee.knee.left, 'r:');
        plot (motors.max_torque.hip_knee.knee.right, 'b:');
        lgd{end+1} = 'Torque bi-articular hip-knee left ';
        lgd{end+1} = 'Torque bi-articular hip-knee right';
    end
    
    if (motors.enable.knee_ankle)
        plot (motors.max_torque.knee_ankle.knee.left, 'r-.');
        plot (motors.max_torque.knee_ankle.knee.right, 'b-.');
        lgd{end+1} = 'Torque bi-articular knee-ankle left ';
        lgd{end+1} = 'Torque bi-articular knee-ankle right';
    end
    
    plot (abs(dataset.torques.q(3,motors.start : motors.step : motors.stop)), 'r--');
    plot (abs(dataset.torques.q(4,motors.start : motors.step : motors.stop)), 'b--');
    lgd{end+1} = 'Torque required left';
    lgd{end+1} = 'Torque required right';
    
    legend (lgd);
    title ('Knee torques [N.m]');
    
   
end

