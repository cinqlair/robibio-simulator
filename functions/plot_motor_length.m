function nPlots = plot_motor_length(motors, index)

    nPlots = sum(cell2mat(struct2cell(motors.enable)));
    plotIndex = 1;
    
    if (motors.enable.hip)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.length.hip.left, 'r');
        plot (motors.length.hip.right, 'b');
        title ('Hip motor length [mm]');
        plotIndex=plotIndex+1; 
    end

    if (motors.enable.knee)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.length.knee.left, 'r');
        plot (motors.length.knee.right, 'b');
        title ('Knee motor length [mm]');
        plotIndex=plotIndex+1;
    end
    
    if (motors.enable.ankle)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.length.ankle.left, 'r');
        plot (motors.length.ankle.right, 'b');
        title ('Ankle motor length [mm]');
        plotIndex=plotIndex+1;
    end
    
    if (motors.enable.hip_knee)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.length.hip_knee.left, 'r');
        plot (motors.length.hip_knee.right, 'b');
        title ('Hip-knee motor length [mm]');
        plotIndex=plotIndex+1;
    end
    
    if (motors.enable.knee_ankle)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.length.knee_ankle.left, 'r');
        plot (motors.length.knee_ankle.right, 'b');
        title ('Knee-ankle motor length [mm]');
        plotIndex=plotIndex+1;
    end
end

