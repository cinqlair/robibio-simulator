function nPlots = plot_motor_force(motors)

    nPlots = sum(cell2mat(struct2cell(motors.enable)));
    plotIndex = 1;
    
    if (motors.enable.hip)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.forces.left(5,:), 'r');
        plot (motors.forces.right(5,:), 'b');
        area(motors.max_force.hip.left,'FaceColor','r','FaceAlpha',.05,'EdgeAlpha',.05);
        area(motors.max_force.hip.right,'FaceColor','b','FaceAlpha',.05,'EdgeAlpha',.05);
        area(-motors.max_force.hip.left,'FaceColor','r','FaceAlpha',.05,'EdgeAlpha',.05);
        area(-motors.max_force.hip.right,'FaceColor','b','FaceAlpha',.05,'EdgeAlpha',.05);
        title ('Force produced by hip motors [N]');
        plotIndex=plotIndex+1;
    end

    if (motors.enable.knee)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.forces.left(3,:), 'r');
        plot (motors.forces.right(3,:), 'b');
        area(motors.max_force.knee.left,'FaceColor','r','FaceAlpha',.05,'EdgeAlpha',.05);
        area(motors.max_force.knee.right,'FaceColor','b','FaceAlpha',.05,'EdgeAlpha',.05);
        area(-motors.max_force.knee.left,'FaceColor','r','FaceAlpha',.05,'EdgeAlpha',.05);
        area(-motors.max_force.knee.right,'FaceColor','b','FaceAlpha',.05,'EdgeAlpha',.05);
        title ('Force produced by knee motors [N]');
        plotIndex=plotIndex+1;
    end
    
    if (motors.enable.ankle)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.forces.left(1,:), 'r');
        plot (motors.forces.right(1,:), 'b');
        area(motors.max_force.ankle.left,'FaceColor','r','FaceAlpha',.05,'EdgeAlpha',.05);
        area(motors.max_force.ankle.right,'FaceColor','b','FaceAlpha',.05,'EdgeAlpha',.05);
        area(-motors.max_force.ankle.left,'FaceColor','r','FaceAlpha',.05,'EdgeAlpha',.05);
        area(-motors.max_force.ankle.right,'FaceColor','b','FaceAlpha',.05,'EdgeAlpha',.05);
        title ('Force produced by ankle motors [N]');
        plotIndex=plotIndex+1;
    end
    
    if (motors.enable.hip_knee)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.forces.left(4,:), 'r');
        plot (motors.forces.right(4,:), 'b');
        area(motors.max_force.hip_knee.left,'FaceColor','r','FaceAlpha',.05,'EdgeAlpha',.05);
        area(motors.max_force.hip_knee.right,'FaceColor','b','FaceAlpha',.05,'EdgeAlpha',.05);
        area(-motors.max_force.hip_knee.left,'FaceColor','r','FaceAlpha',.05,'EdgeAlpha',.05);
        area(-motors.max_force.hip_knee.right,'FaceColor','b','FaceAlpha',.05,'EdgeAlpha',.05);
        title ('Force produced by hip-knee motors [N]');
        plotIndex=plotIndex+1;
    end
    
    if (motors.enable.knee_ankle)
        subplot (nPlots,1,plotIndex); hold on; grid on;
        plot (motors.forces.left(2,:), 'r');
        plot (motors.forces.right(2,:), 'b');
        area(motors.max_force.knee_ankle.left,'FaceColor','r','FaceAlpha',.05,'EdgeAlpha',.05);
        area(motors.max_force.knee_ankle.right,'FaceColor','b','FaceAlpha',.05,'EdgeAlpha',.05);
        area(-motors.max_force.knee_ankle.left,'FaceColor','r','FaceAlpha',.05,'EdgeAlpha',.05);
        area(-motors.max_force.knee_ankle.right,'FaceColor','b','FaceAlpha',.05,'EdgeAlpha',.05);
        title ('Force produced by knee-ankle motors [N]');
        plotIndex=plotIndex+1;
    end
end

