function nPlots = plot_motor_torque_ankle(motors, dataset)

    
    hold on; grid on;
    lgd ={};
    if (motors.enable.ankle)
        plot (motors.max_torque.ankle.left, 'r');
        plot (motors.max_torque.ankle.right, 'b');
        lgd{end+1} = 'Torque mono-articular left';
        lgd{end+1} = 'Torque mono-articular right';
        
    end
    if (motors.enable.knee_ankle)
        plot (motors.max_torque.knee_ankle.ankle.left, 'r:');
        plot (motors.max_torque.knee_ankle.ankle.right, 'b:');
        lgd{end+1} = 'Torque bi-articular left';
        lgd{end+1} = 'Torque bi-articular right';
    end
    
    plot (abs(dataset.torques.q(5,motors.start : motors.step : motors.stop)), 'r--');
    plot (abs(dataset.torques.q(6,motors.start : motors.step : motors.stop)), 'b--');
    lgd{end+1} = 'Torque required left';
    lgd{end+1} = 'Torque required right';
    
    legend (lgd);
    title ('Ankle torques [N.m]');
    
   
end

