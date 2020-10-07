function nPlots = plot_motor_torque_hip(motors, dataset)

    
    hold on; grid on;
    lgd ={};
    if (motors.enable.hip)
        plot (motors.max_torque.hip.left, 'r');
        plot (motors.max_torque.hip.right, 'b');
        lgd{end+1} = 'Torque mono-articular left';
        lgd{end+1} = 'Torque mono-articular right';
        
    end
    if (motors.enable.hip_knee)
        plot (motors.max_torque.hip_knee.hip.left, 'r:');
        plot (motors.max_torque.hip_knee.hip.right, 'b:');
        lgd{end+1} = 'Torque bi-articular left';
        lgd{end+1} = 'Torque bi-articular right';
    end
    
    plot (abs(dataset.torques.q(1,motors.start : motors.step : motors.stop)), 'r--');
    plot (abs(dataset.torques.q(2,motors.start : motors.step : motors.stop)), 'b--');
    lgd{end+1} = 'Torque required left';
    lgd{end+1} = 'Torque required right';
    
    legend (lgd);
    title ('Hip torques [N.m]');
    
   
end

