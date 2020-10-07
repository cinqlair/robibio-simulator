function nPlots = plot_motor_force(motors)

    nPlots = sum(cell2mat(struct2cell(motors.enable)));
    plotIndex = 1;
    
    if (motors.enable.hip)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.max_force.hip.left, 'r');
        plot (motors.max_force.hip.right, 'b');
        title ('Max force available on hip motors [N]');
        plotIndex=plotIndex+1;
    end

    if (motors.enable.knee)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.max_force.knee.left, 'r');
        plot (motors.max_force.knee.right, 'b');
        title ('Max force available on knee motors [N]');
        plotIndex=plotIndex+1;
    end
    
    if (motors.enable.ankle)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.max_force.ankle.left, 'r');
        plot (motors.max_force.ankle.right, 'b');
        title ('Max force available on ankle motors [N]');
        plotIndex=plotIndex+1;
    end
    
    if (motors.enable.hip_knee)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.max_force.hip_knee.left, 'r');
        plot (motors.max_force.hip_knee.right, 'b');
        title ('Max force available on hip-knee motors [N]');
        plotIndex=plotIndex+1;
    end
    
    if (motors.enable.knee_ankle)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.max_force.knee_ankle.left, 'r');
        plot (motors.max_force.knee_ankle.right, 'b');
        title ('Max force available on knee-ankle motors [N]');
        plotIndex=plotIndex+1;
    end
end

