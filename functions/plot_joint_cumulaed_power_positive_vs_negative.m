function plot_joint_power_positive_vs_negative(motors, dataset)

    plus_left=[];
    plus_right=[];
    index=1;
    for i=motors.start:motors.step:motors.stop
        % Left leg
        plus_left(index) = sum(dataset.power.q([1;0;1;0;1;0].*dataset.power.q(:,i)>0 , i));
        minus_left(index) = sum(dataset.power.q([1;0;1;0;1;0].*dataset.power.q(:,i)<0 , i));
        % Right leg
        plus_right(index) = sum(dataset.power.q([0;1;0;1;0;1].*dataset.power.q(:,i)>0 , i));
        minus_right(index) = sum(dataset.power.q([0;1;0;1;0;1].*dataset.power.q(:,i)<0 , i));

        index = index+1;
    end

    subplot(2,1,1); hold on; grid on;
    area (plus_left, 'FaceColor','r','FaceAlpha',.1,'EdgeAlpha',.2);
    area (minus_left, 'FaceColor','g','FaceAlpha',.1,'EdgeAlpha',.2);
    plot (plus_left+minus_left, 'k--');
    title ('Left leg [W]');
    legend ('Required', 'Available', 'Difference');

    subplot(2,1,2); hold on; grid on;
    area (plus_right, 'FaceColor','r','FaceAlpha',.1,'EdgeAlpha',.2);
    area (minus_right, 'FaceColor','g','FaceAlpha',.1,'EdgeAlpha',.2);
    plot (plus_right+minus_right, 'k--');
    title ('Right leg [W]');
    legend ('Required', 'Available', 'Difference');

end

