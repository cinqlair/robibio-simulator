function nPlots = plot_motor_length(motors, index)

    nPlots = sum(cell2mat(struct2cell(motors.enable)));
    plotIndex = 1;
    
    if (motors.enable.hip)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.velocity.hip.left, 'r');
        plot (motors.velocity.hip.right, 'b');
        title ('Hip motor velocity [mm]');
        plotIndex=plotIndex+1; 
    end

    if (motors.enable.knee)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.velocity.knee.left, 'r');
        plot (motors.velocity.knee.right, 'b');
        title ('Knee motor velocity [mm]');
        plotIndex=plotIndex+1;
    end
    
    if (motors.enable.ankle)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.velocity.ankle.left, 'r');
        plot (motors.velocity.ankle.right, 'b');
        title ('Ankle motor velocity [mm]');
        plotIndex=plotIndex+1;
    end
    
    if (motors.enable.hip_knee)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.velocity.hip_knee.left, 'r');
        plot (motors.velocity.hip_knee.right, 'b');
        title ('Hip-knee motor velocity [mm]');
        plotIndex=plotIndex+1;
    end
    
    if (motors.enable.knee_ankle)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.velocity.knee_ankle.left, 'r');
        plot (motors.velocity.knee_ankle.right, 'b');
        title ('Knee-ankle motor velocity [mm]');
        plotIndex=plotIndex+1;
    end
end

